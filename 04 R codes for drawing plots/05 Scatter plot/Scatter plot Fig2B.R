rm(list = ls())
library(ggplot2)
library(tidyverse)

#read table Fig2B
dat <- readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/05 Scatter plot/normalized_counts_gcn5.xlsx",sheet = 1)
head(dat)
#Set thresholds of log2 fold chang and p-adj
logFCcut <- 1 #log2-foldchange
adjPcut <- 0.05 #adj.P.value

#delete p-adj==NA
x <- dat

x$padj_WT_G[is.na(x$padj_WT_G)] <- 1
x$padj_WT_G <- as.numeric(x$padj_WT_G)

x$padj_WT_H[is.na(x$padj_WT_H)] <- 1
x$padj_WT_H <- as.numeric(x$padj_WT_H)

x$padj_G_H[is.na(x$padj_G_H)] <- 1
x$padj_G_H <- as.numeric(x$padj_G_H)

x1<-x[x$padj_WT_G<0.05&abs(x$log2_G_WT)>1,]

#Set colors
x1$color_transparent<-ifelse((x1$log2_G_WT > logFCcut&x1$log2_H_G<0&x1$padj_G_H<0.05), "#faa755", ifelse((x1$log2_G_WT< -logFCcut&x1$log2_H_G>0&x1$padj_G_H<0.05), "#00ae9d","#B7B7B7"))

# Construct the plot object
p2 <- ggplot(data=x1, aes(log2_G_WT,log2_H_WT),label = Symbol, color = pathway) +
  geom_point(data=subset(x1,color_transparent=="#B7B7B7"),alpha = 0.6, size = 1, shape=16,color = "#B7B7B7") +
  geom_point(data=subset(x1,color_transparent=="#00ae9d"),alpha = 0.6, size = 2, shape=16,color = "#00ae9d") +
  geom_point(data=subset(x1,color_transparent=="#faa755"),alpha = 0.6, size = 2, shape=16,color = "#faa755") +
  
  labs(x=bquote("3d"~log[2]~"(gcn5c450/c450/WT)"), y=bquote("3d"~log[2]~"(H/WT)"), title="") + 
  scale_x_continuous(
    breaks = c(-7,-6,-5,-4,-3, -2, -logFCcut, 0, logFCcut, 2,3,4,5),
    labels = c(-7,-6,-5,-4,-3, -2, -logFCcut, 0, logFCcut, 2,3,4,5),
    limits = c(-7.5, 5.5) 
  ) +
  scale_y_continuous(
    breaks = c(-7,-6,-5,-4,-3, -2, -logFCcut, 0, logFCcut, 2,3,4,5), 
    labels = c(-7,-6,-5,-4,-3, -2, -logFCcut, 0, logFCcut, 2,3,4,5),
    limits = c(-7.5, 5.5) 
  )+
  #Draw the threshold lines
  geom_abline(slope = 1,intercept =0, color="grey40", 
              linetype="longdash", lwd = 0.5) +
  geom_vline(xintercept = 1, color="grey40", 
             linetype="longdash", lwd = 0.5) +
  geom_vline(xintercept = -1, color="grey40", 
             linetype="longdash", lwd = 0.5) +
  geom_vline(xintercept = 0, color="black", 
             linetype="solid", lwd = 0.5) +
  geom_hline(yintercept = 0, color="black", 
             linetype="solid", lwd = 0.5) +  
  theme_bw(base_size = 12
  ) +
  theme(panel.grid=element_blank())

p2

