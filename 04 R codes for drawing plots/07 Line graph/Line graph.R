library(tidyverse)
library(ggplot2)
df<-readxl::read_excel("Data/Gcn5 paper/04 R codes for drawing plots/07 Line graph/Aging for line graph.xlsx",sheet = 1)


#Common sites '5a'=='3d>15d>30d>45d,p_3d&45d<0.05', '7a'=='3d<15d<30d<45d,p_3d&45d<0.05', '6a'=='Not significant'
df1<-df[df$Change=="5a"|df$Change=="6a"|df$Change=="7a",]
ggplot(df1,aes(Group,`Log 2 FC`,group=Label))+
  geom_line(data=subset(df,Change == "6a"),color='#BEBEBE',size=0.1,alpha=0.5,linetype=1)+
  geom_line(data=subset(df,Change == "5a"|Change =="7a"),aes(color=Change),size=0.3,alpha=0.5,linetype=1)+
  scale_color_manual(values = c("7a"='#E54646', "5a"='#426EB4'))+
  geom_hline(yintercept = 0,linetype=1,size=0.1)+
  stat_summary(aes(group=1),fun = mean,geom = "line",size=0.5,color="black")+
  scale_y_continuous(breaks = c(-6,-4,-2,0,2,4,6),labels =c(-6,-4,-2,0,2,4,6),limits = c(-6,6) )+
  theme_bw()+
  theme(axis.text = element_text(size = 8,face = "bold"),strip.text = element_text(size = 8,face = "bold"))

#3d/15d/30d-specific (45d=0)  '3a'=='3d>15d>30d', '4a'=='Not significant'
df2<-df[df$Change=="3a"|df$Change=="4a",]
ggplot(df2,aes(Group,`Log 2 FC`,group=Label))+
  geom_line(data=subset(df,Change == "4a"),color='#BEBEBE',size=0.1,alpha=0.5,linetype=1)+
  geom_line(data=subset(df,Change == "3a"),color='#426EB4',size=0.3,alpha=0.5,linetype=1)+
  geom_hline(yintercept = 0,linetype=1,size=0.1)+
  stat_summary(aes(group=1),fun = mean,geom = "line",size=0.5,color="black")+
  scale_y_continuous(breaks = seq(-25,5,5),labels =seq(-25,5,5),limits = c(-25,5) )+
  theme_bw()+
  theme(axis.text = element_text(size = 8,face = "bold"),strip.text = element_text(size = 8,face = "bold"))

#15d/30d/45d-specific (3d=0)  '9a'=='15d<30d<45d', '8a'=='Not significant'
df3<-df[df$Change=="8a"|df$Change=="9a",]
ggplot(df3,aes(Group,`Log 2 FC`,group=Label))+
  geom_line(data=subset(df,Change == "8a"),color='#BEBEBE',size=0.1,alpha=0.5,linetype=1)+
  geom_line(data=subset(df,Change == "9a"),color='#E54646',size=0.3,alpha=0.5,linetype=1)+
  geom_hline(yintercept = 0,linetype=1,size=0.1)+
  stat_summary(aes(group=1),fun = mean,geom = "line",size=0.5,color="black")+
  scale_y_continuous(breaks = seq(-5,25,5),labels =seq(-5,25,5),limits = c(-5,25) )+
  theme_bw()+
  theme(axis.text = element_text(size = 8,face = "bold"),strip.text = element_text(size = 8,face = "bold"))

#3d/15d-specific (30d=45d=0) '2a'=='3d/15d-specific'
df4<-df[df$Change=="2a",]
ggplot(df4,aes(Group,`Log 2 FC`,group=Label))+
  geom_line(data=subset(df,Change == "2a"),color='#426EB4',size=0.3,alpha=0.5,linetype=1)+
  geom_hline(yintercept = 0,linetype=1,size=0.1)+
  stat_summary(aes(group=1),fun = mean,geom = "line",size=0.5,color="black")+
  scale_y_continuous(breaks = seq(-25,5,5),labels =seq(-25,5,5),limits = c(-25,5) )+
  theme_bw()+
  theme(axis.text = element_text(size = 8,face = "bold"),strip.text = element_text(size = 8,face = "bold"))

#30d/45d-specific (3d=15d=0) '10a'=='30d/45d-specific'
df5<-df[df$Change=="10a",]
ggplot(df5,aes(Group,`Log 2 FC`,group=Label))+
  geom_line(data=subset(df,Change == "10a"),color='#E54646',size=0.3,alpha=0.5,linetype=1)+
  geom_hline(yintercept = 0,linetype=1,size=0.1)+
  stat_summary(aes(group=1),fun = mean,geom = "line",size=0.5,color="black")+
  scale_y_continuous(breaks = seq(-5,25,5),labels =seq(-5,25,5),limits = c(-5,25) )+
  theme_bw()+
  theme(axis.text = element_text(size = 8,face = "bold"),strip.text = element_text(size = 8,face = "bold"))

#3d-specific (15d=30d=45d=0) '1a'=='3d-specific'
df6<-df[df$Change=="1a",]
ggplot(df6,aes(Group,`Log 2 FC`,group=Label))+
  geom_line(data=subset(df,Change == "1a"),color='#426EB4',size=0.3,alpha=0.5,linetype=1)+
  geom_hline(yintercept = 0,linetype=1,size=0.1)+
  stat_summary(aes(group=1),fun = mean,geom = "line",size=0.5,color="black")+
  scale_y_continuous(breaks = seq(-25,5,5),labels =seq(-25,5,5),limits = c(-25,5) )+
  theme_bw()+
  theme(axis.text = element_text(size = 8,face = "bold"),strip.text = element_text(size = 8,face = "bold"))

#45d-specific (3d=15d=30d=0) '11a'=='45d-specific'
df7<-df[df$Change=="11a",]
ggplot(df7,aes(Group,`Log 2 FC`,group=Label))+
  geom_line(data=subset(df,Change == "11a"),color='#E54646',size=0.3,alpha=0.5,linetype=1)+
  geom_hline(yintercept = 0,linetype=1,size=0.1)+
  stat_summary(aes(group=1),fun = mean,geom = "line",size=0.5,color="black")+
  scale_y_continuous(breaks = seq(-5,25,5),labels =seq(-5,25,5),limits = c(-5,25) )+
  theme_bw()+
  theme(axis.text = element_text(size = 8,face = "bold"),strip.text = element_text(size = 8,face = "bold"))

