rm(list = ls())
library(ggplot2)
library(tidyverse)

#read table Fig2A
dat <- readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/05 Scatter plot/normalized_counts_gcn5.xlsx",sheet = 1)
head(dat)
#delete p-adj==NA
x <- dat
na.omit(x[,17])
x$padj_WT_G <- as.numeric(x$padj_WT_G)

#Set thresholds of log2 fold chang and p-adj
logFCcut <- 1 #log2-foldchange
adjPcut <- 0.05 #adj.P.value

#Set the min and max limit of x-axis and y-axis
xmin <- (range(x$log2_G_WT)[1]- (range(x$log2_G_WT)[1]+ 10))
xmax <- (range(x$log2_G_WT)[1]+ (10-range(x$log2_G_WT)[1]))
ymin <- 0

summary(x$padj_WT_G < adjPcut & x$log2_G_WT > logFCcut)
summary(x$padj_WT_G < adjPcut & x$log2_G_WT < -logFCcut)

#Set colors and sizes
x$color_transparent <- ifelse((x$padj_WT_G < adjPcut & x$log2_G_WT > logFCcut), "#E54646", ifelse((x$padj_WT_G < adjPcut & x$log2_G_WT< -logFCcut), "#426EB4","#B7B7B7"))
size <- ifelse((x$padj_WT_G < adjPcut & abs(x$log2_G_WT) > logFCcut), 2, 1)

# Construct the plot object
p1 <- ggplot(data=x, aes(log2_G_WT,-log10(padj_WT_G)),label = Symbol, color = pathway) +
  geom_point(alpha = 0.6, size = size, shape=16,color = x$color_transparent) +
  
  labs(x=bquote("3d"~log[2]~"(gcn5c450/c450/WT)"), y=bquote(~-log[10]~italic("p-adj")), title="") + 
  scale_x_continuous(
    breaks = c(-7,-6,-5,-4,-3, -2, -logFCcut, 0, logFCcut, 2,3,4,5),
    labels = c(-7,-6,-5,-4,-3, -2, -logFCcut, 0, logFCcut, 2,3,4,5),
    limits = c(-7.5, 5.5) 
  ) +
  scale_y_continuous(
    breaks = c(seq(0,140,by=20)), 
    labels = c(seq(0,140,by=20)),
    limits = c(0,143) 
  ) +
  #Draw the threshold lines
  geom_vline(xintercept = c(-logFCcut, logFCcut), color="grey40", 
             linetype="longdash", lwd = 0.5) + 
  geom_hline(yintercept = -log10(adjPcut), color="grey40", 
             linetype="longdash", lwd = 0.5) +
  theme_bw(base_size = 12
  ) +
  theme(panel.grid=element_blank())

p1

#Add breaks
library(gg.gap)
p2<-gg.gap(plot = p1,segments = c(90,110),tick_width=c(10,30),rel_heights = c(0.8,0,0.2),ylim = c(0,150))
p2
