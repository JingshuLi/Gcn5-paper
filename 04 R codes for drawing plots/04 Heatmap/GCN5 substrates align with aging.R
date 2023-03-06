rm(list = ls())
options(stringsAsFactors = F)
library(ggplot2)
library(tidyverse)
library(pheatmap)

#read table Fig5B
df1 <- readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/04 Heatmap/Heatmap-gcn5 candidates align with aging.xlsx",sheet = 1)
head(df)
#read fold change
dat1 <- as.data.frame(cbind(df1[,3],df1[,4],df1[,5]))
rownames(dat1) <- df1$Label
head(dat1)
#set breaks
bk <- c(seq(-4.7,-0.1,by=0.01),seq(0,4.7,by=0.01))
#draw plots
b1<-pheatmap(dat1,cluster_rows = F,cluster_cols = F,scale = "none",
             color=c(colorRampPalette(colors = c("#5050c4","white"))(length(bk)/2),colorRampPalette(colors = c("white","#c45050"))(length(bk)/2)),
             legend_breaks=seq(-4,4,1),
             breaks=bk)

#read table Fig5D
df2 <- readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/04 Heatmap/Heatmap-gcn5 candidates align with aging.xlsx",sheet = 2)
head(df2)
#read fold change
dat2 <- as.data.frame(cbind(df2[,3],df2[,4],df2[,5]))
rownames(dat2) <- df2$Label
head(dat2)
#set breaks
bk <- c(seq(-4.7,-0.1,by=0.01),seq(0,4.7,by=0.01))
#draw plots
b2<-pheatmap(dat2,cluster_rows = F,cluster_cols = F,scale = "none",
             color=c(colorRampPalette(colors = c("#5050c4","white"))(length(bk)/2),colorRampPalette(colors = c("white","#c45050"))(length(bk)/2)),
             legend_breaks=seq(-4,4,1),
             breaks=bk)

