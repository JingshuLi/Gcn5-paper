install.packages("UpSetR")
library(UpSetR)
library(gg.gap)
library(ggplot2)
#Read data Fig4A
expressionInput <- c(
  A = 20, B = 46, C = 44, D=51,
  `A&B` = 12, `A&C` = 5, `A&D` = 3, `B&C` = 16, `B&D` = 12,`C&D` = 44, 
  `A&B&C` = 27,`A&B&D` = 8,`A&C&D` = 11,`B&C&D` = 117,
  `A&B&C&D` = 785)
#Draw plot
b<-upset(fromExpression(expressionInput), nsets =4, 
         sets = c("D","C", "B", "A"),
         order.by = "freq",
         decreasing =T,
         keep.order = T,
         point.size = 2, 
         line.size = 1, 
         mainbar.y.label = "Acetylation sites", 
         sets.x.label = "Acetylation sites", 
         text.scale = c(1.3, 1.3, 1, 1, 2, 0.75))
b
