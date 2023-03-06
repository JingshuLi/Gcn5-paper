library(ggplot2)
library(tidyverse)
#read data
dat<-readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/03 GO analysis/GO analysis-gcn5.xlsx",sheet = 1)
#Custom Function
compare_dotplot <- function(enrich.compare.obj, showCategory=10){
  eobj <- as.data.frame(enrich.compare.obj)
  eobj %>% 
    dplyr::group_by(Cluster) %>% 
    slice_min(order_by = p.value, n=showCategory) %>% 
    ungroup() %>% 
    dplyr::select(Description) %>% 
    dplyr::inner_join(eobj, y=., by='Description') %>%
    ggplot(aes(x=Cluster, 
               y=factor(Description, levels=rev(unique(Description))))) +
    geom_point(aes(size=GeneCount, color=p.value)) + 
    geom_text(aes(label=paste0(round(GeneCount,2))),nudge_x = 0.15) +
    scale_color_gradient(low="#f0c27b",high="#4b1248") + 
    theme_minimal() +
    theme(panel.grid = element_blank(),
          axis.line = element_line(),
          axis.ticks = element_line(color='black'),
          axis.text = element_text(color='black', size=12)) +
    labs(x='',y='',size='GeneCount')
}
#Draw plots
dp1 <- compare_dotplot(dat)
dp1
