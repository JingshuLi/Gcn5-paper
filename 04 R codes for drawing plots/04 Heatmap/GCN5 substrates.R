rm(list = ls())
options(stringsAsFactors = F)
library(ggplot2)
library(tidyverse)
library(pheatmap)

#read table Fig1F
df1 <- readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/04 Heatmap/Heatmap-gcn5 candidates.xlsx",sheet = 1)
head(df1)
#read log 10 intensity
dat1<- as.data.frame(cbind(df1[,5],df1[,6],df1[,7]))
rownames(dat1) <- df1$Label
head(dat1)
#set breaks
bk1 <- c(seq(0,5.5,by=0.01))
#draw plots
b1<-pheatmap(dat1,cluster_rows = F,cluster_cols = F,scale="none",
             color=c(colorRampPalette(colors = c("#ffffff","#5C3675"))(length(bk1))),legend_breaks=seq(2,4,1),breaks=bk1)

#read table Fig1G, FigS3A
df2 <- readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/04 Heatmap/Heatmap-gcn5 candidates.xlsx",sheet = 2)
head(df2)
#read log2 fold change
dat2 <- as.data.frame(cbind(df2[,2],df2[,3]))
rownames(dat2) <- df$Label
head(dat2)
#breaks
bk2 <- c(seq(-4.5,-0.1,by=0.01),seq(0,4.5,by=0.01))

b2<-pheatmap(dat2,cluster_rows = F,cluster_cols = F,scale = "none",
             color=c(colorRampPalette(colors = c("#5050c4","white"))(length(bk2)/2),colorRampPalette(colors = c("white","#c45050"))(length(bk2)/2)),
             legend_breaks=seq(-4,4,1),
             breaks=bk)
