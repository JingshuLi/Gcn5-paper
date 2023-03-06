library(tidyverse)
library(ggplot2)
library(ggrepel)
library(ggsignif)

#Gcn5-related data (Fig1C, Fig1D, Fig3B)
  
  #draw violin plot
    #read table
      #Fig1C
        dat1<-readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/02 Violin plot/For violin-gcn5.xlsx",sheet = 1)
      #Fig1D
        dat1A<-dat1[dat1$Change=='Loss of acetylation',]
        dat1B<-dat1[dat1$Change=='Decreased acetylation',]
    #draw violin plot (Fig1C, Fig1D)
        ggplot(data=dat1C, aes(Group,`Log 10 Average`)) +
          geom_violin(aes(Group,`Log 10 Average`),color='black', width=0.6,size=0.3) +
          geom_jitter(aes(Group, `Log 10 Average`, color = Group), stroke=0, width=0.1, alpha=0.8, size=0.6) +
          scale_color_manual(values = c("#A0A0A4", "#FFA0A0","#90BFF9"))+
          geom_boxplot(aes(Group,`Log 10 Average`),color='grey40',fill=NA, width=0.3, outlier.shape=NA,size=0.3) +
          stat_summary(geom='point', fun=mean, color='#840228', size=0.8) +
           theme_bw() +
          scale_y_continuous(breaks = seq(0,6,2), labels = seq(0,6,2),limits = c(-0.1,7))+ 
          labs(x='',y='log10 Intensity',color='', caption='(wilcox rank-sum-test)')
    #read table
      #Fig3B
        dat1C<-dat1[dat1$Change_WT_H=='Gain of acetylation'&dat1$Group!='02-G',]
        dat1D<-dat1[dat1$Change_WT_H=='Increased acetylation'&dat1$Group!='02-G',]
    #draw violin plot (Fig3B)
        ggplot(data=dat1C, aes(Group,`Log 10 Average`)) +
          geom_violin(aes(Group,`Log 10 Average`),color='black', width=0.6,size=0.3) +
          geom_jitter(aes(Group, `Log 10 Average`, color = Group), stroke=0, width=0.1, alpha=0.8, size=0.6) +
          scale_color_manual(values = c("#A0A0A4", "#FFA0A0","#90BFF9"))+
          geom_boxplot(aes(Group,`Log 10 Average`),color='grey40',fill=NA, width=0.3, outlier.shape=NA,size=0.3) +
          stat_summary(geom='point', fun=mean, color='#840228', size=0.8) +
          theme_bw() +
          scale_y_continuous(breaks = seq(0,6,2), labels = seq(0,6,2),limits = c(-0.1,7))+ 
          labs(x='',y='log10 Intensity',color='', caption='(wilcox rank-sum-test)')
        
  #wilcox rank-sum test
    #read table
      #Fig1C
        df1<-readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/02 Violin plot/For violin.xlsx",sheet = 2)
    #wilcox rank-sum test
      #WT: WT; G: gcn5-/-; H: gcn5-/- Gcn5(+)
      wilcox.test(df1$`LOG10-WT`,df1$`LOG10-G`,paired = F)
      wilcox.test(df1$`LOG10-WT`,df1$`LOG10-H`,paired = F)
      wilcox.test(df1$`LOG10-G`,df1$`LOG10-H`,paired = F)
      
      

  
#Aging data (Fig4B)
      
  #draw violin plot
    #read table
      dat<-readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/02 Violin plot/For violin-aging.xlsx",sheet = 1)
    #draw violin plot   
      ggplot(data=dat, aes(Group,`Log 10 Average`)) +
        geom_violin(aes(Group,`Log 10 Average`),color='black', width=0.6,size=0.3) +
        geom_jitter(aes(Group, `Log 10 Average`, color = Group), stroke=0, width=0.1, alpha=0.8, size=0.6) +
        scale_color_manual(values = c("#A0A0A4", "#808080","#606060","#323232"))+
        geom_boxplot(aes(Group,`Log 10 Average`),color='grey40',fill=NA, width=0.3, outlier.shape=NA,size=0.3) +
        stat_summary(geom='point', fun=mean, color='#840228', size=0.8) +
        theme_bw() +
        scale_y_continuous(breaks = seq(0,10,2), labels = seq(0,10,2),limits = c(-0.1,10))+ 
        labs(x='',y='log10 Intensity',color='', caption='(wilcox rank-sum-test)')
  #wilcox rank-sum test
    #read table
      df<-readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/02 Violin plot/For violin-aging.xlsx",sheet = 2)
    #wilcox rank-sum test
      wilcox.test(df$`LOG10-3d`,df$`LOG10-15d`,paired = F)
      wilcox.test(df$`LOG10-3d`,df$`LOG10-30d`,paired = F)
      wilcox.test(df$`LOG10-3d`,df$`LOG10-45d`,paired = F)
      wilcox.test(df$`LOG10-15d`,df$`LOG10-30d`,paired = F)
      wilcox.test(df$`LOG10-15d`,df$`LOG10-45d`,paired = F)
      wilcox.test(df$`LOG10-30d`,df$`LOG10-45d`,paired = F)
