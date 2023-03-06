install.packages("GGally")
library(ggplot2)
library(GGally)
#read table FigS2A
df<-readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/08 Correlation matrix/Gcn5 cor matrix.xlsx",sheet = 2)
df<-df[,3:13]
#Function
GGscatterPlot <- function(data, mapping, ..., 
                          method = "pearson") {
  
  #Get correlation coefficient
  x <- GGally::eval_data_col(data, mapping$x)
  y <- GGally::eval_data_col(data, mapping$y)
  
  cor <- cor(x, y, method = method, use="pairwise.complete.obs")
  #Assemble data frame
  df <- data.frame(x = x, y = y)
  df <- na.omit(df)
  # PCA
  nonNull <- x!=0 & y!=0
  dfpc <- prcomp(~x+y, df[nonNull,])
  df$cols <- predict(dfpc, df)[,1]
  # Define the direction of color range based on PC1 orientation:
  dfsum <- x+y
  colDirection <- ifelse(dfsum[which.max(df$cols)] < 
                           dfsum[which.min(df$cols)],
                         1,
                         -1)
  #Get 2D density for alpha
  dens2D <- MASS::kde2d(df$x, df$y)
  df$density <- fields::interp.surface(dens2D ,df[,c("x", "y")])
  
  if (any(df$density==0)) {
    mini2D = min(df$density[df$density!=0]) #smallest non zero value
    df$density[df$density==0] <- mini2D
  }
  #Prepare plot
  pp <- ggplot(df, aes(x=x, y=y, alpha = density))+
    #, color = cols)) +
    ggplot2::geom_point(shape=16, size=1,show.legend = FALSE) +
    #ggplot2::scale_color_viridis_c(direction = colDirection) +
    #                scale_color_gradient(low = "#0091ff", high = "#f0650e") +
    ggplot2::scale_alpha(range = c(.05, .6)) +
    ggplot2::geom_abline(intercept = 0, slope = 1, col="darkred") +
  theme_bw()
  return(pp)
}
#draw plot
ggpairs(df, 
        lower = list(continuous = wrap(GGscatterPlot)),
        upper = list(continuous = wrap(ggally_cor, cor="pairwise.complete.obs"))
) + 
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.text =  element_text(color='black'))