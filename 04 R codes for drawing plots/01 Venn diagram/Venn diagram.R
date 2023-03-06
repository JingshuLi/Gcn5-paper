install.packages('eulerr')
library(eulerr)

#Fig1B:
#A:WT; B:gcn5-/-; C:gcn5-/- Gcn5(+)
vd <- euler(c(A = 26,B=8,C=280,"A&B"=7,"A&C" = 61, "B&C"=15, "A&B&C"=509))
plot(vd,
     fills = list(fill = c("#A0A0A4","#FFA0A0","#90BFF9"), alpha = 0.5),
     labels = list(col = "black", font = 8), 
     edges = T,
     quantities = T)

#Fig4A
#A:3d; B:15d; C:30d; D:45d
vd <- euler(c(C = 44, D = 51,A=20,B=46,"A&B"=12,"A&C" = 5, "A&D"=3, "B&C"=16, "B&D"=12, "C&D"=44, "A&B&C"=27, "A&B&D"=8,"A&C&D"=11,"B&C&D"=117,"A&B&C&D"=785))
plot(vd,
     fills = list(fill = c("#606060","#323232","#a0a0a4","#808080"), alpha = 0.6),
     labels = list(col = "black", font = 8), 
     edges = T,
     quantities = T)

#Fig5A
#A:GCN5 candidates; B:Aging data (nonmitochondrial)
vd1 <- euler(c(A = 46,B=734,"A&B"=21))
plot(vd1,
     fills = list(fill = c("#ffffff","#ffffff"), alpha = 0),
     labels = list(col = "black", font = 8), 
     edges = T,
     quantities = T)

#Fig5C
#A:GCN5-promoted acetylation sites; B:Aging data (nonmitochondrial)
vd2 <- euler(c(A = 296,B=692,"A&B"=63))
plot(vd2,
     fills = list(fill = c("#ffffff","#ffffff"), alpha = 0),
     labels = list(col = "black", font = 8), 
     edges = T,
     quantities = T)