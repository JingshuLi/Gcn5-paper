# standard differential expression analysis based on DESeq2
if (!requireNamespace("tidyverse")) install.packages("tidyverse")
if (!requireNamespace("dendextend")) install.packages("dendextend")
if (!requireNamespace("DESeq2")) BiocManager::install("DESeq2")
if (!requireNamespace("ComplexHeatmap")) BiocManager::install("ComplexHeatmap")
if (!requireNamespace("magick")) BiocManager::install("magick")
if (!requireNamespace("rtracklayer")) BiocManager::install("rtracklayer")
# Loading required packages
library(tidyverse)
library(DESeq2)
# make directory for results
if (!dir.exists('results/qc')) dir.create('results/qc', recursive = T)
if (!dir.exists('results/de')) dir.create('results/de', recursive = T)
# read in meta information (required)
metadata <- read.csv("metadata.csv", header=TRUE)

# step 0. Merging counts from featureCounts ----
counts_df <- metadata$path %>%
  map_dfc(., ~ read.table(.x, sep = '\t', row.names = 1, skip = 2,
                          colClasses = c('character',rep('NULL',5),'integer')))

colnames(counts_df) <- metadata$id
# if exists, remove version number in ENSEMBL gene id 
#rownames(counts_df) <- gsub('\\..*', '', rownames(counts_df))
write.table(counts_df, file='Counts.csv', sep=',')
counts_df <- as.matrix(counts_df)
# step 1. filter lowly expressed genes ----
counts_keep <- counts_df[rowSums(counts_df>0) > 0.75*ncol(counts_df), ]

# step 2. generate QC plots: PCA, correlation, hclust ----
samples_name <- paste(metadata$condition, metadata$replicate, sep = '.')
# perform vst transformation
vt <- vst(as.matrix(counts_keep))
pca.tmp <- prcomp(t(vt))
rownames(pca.tmp$x) <- samples_name
## PCA
pcaplot <- as.data.frame(pca.tmp$x) %>% 
  mutate(group=metadata$condition) %>%  
  ggplot(aes(x=PC1, y=PC2)) +
  geom_point(aes(color=group)) +
  ggforce::geom_mark_ellipse(aes(fill = group,color = group))+
  #Add confidence ellipse
  guides(fill="none")+
  ggrepel::geom_text_repel(label=samples_name) +
  geom_vline(xintercept=0, color='grey80', lty=2) + 
  geom_hline(yintercept=0, color='grey80', lty=2) + 
  theme_bw() +
  theme(panel.grid = element_blank(), legend.position = 'top', axis.text = element_text(color='black')) +
  labs(x=paste0('PC1: ', round(summary(pca.tmp)$importance[2,1],3)*100, '%'), 
       y=paste0('PC2: ', round(summary(pca.tmp)$importance[2,2],3)*100, '%'))
ggsave(plot = pcaplot, filename = 'results/qc/PCA-PC12.pdf', width=10, height=8)

## Correlation Heatmap
library(ComplexHeatmap)
library(magick)
corMat <- cor(vt)
colnames(corMat) <- samples_name
rownames(corMat) <- samples_name
od <- hclust(dist(corMat))$order
corMat <- corMat[od,od]
rowDend <-  as.dendrogram(hclust(dist(corMat)))
corp1 <- ComplexHeatmap::Heatmap(corMat, name='corMat', 
                                 col=colorRampPalette(RColorBrewer::brewer.pal(9,'YlOrRd'))(50),
                                 cluster_columns = F, cluster_rows = rowDend, row_dend_side = 'left',
                                 row_dend_width = unit(2, "cm"),
                                 column_names_rot = 45, row_names_side = 'left', use_raster = T,
                                 heatmap_legend_param = list(direction = "horizontal"), 
                                 cell_fun=function(j, i, x, y, width, height, fill) {
                                   if(i <= j) {
                                     grid::grid.text(sprintf("%.2f", corMat[i, j]), x, y, gp = grid::gpar(fontsize = 10))
                                   }
                                   else if(i > j) {
                                     grid::grid.rect(x = x, y = y, width = width, height = height, 
                                                     gp = grid::gpar(type='none', col=NA))
                                   }
                                 })
pdf(file='results/qc/CorHeatmap.pdf', bg='white', width=10, height=8)
ComplexHeatmap::draw(corp1, heatmap_legend_side = 'top')
dev.off()

## Hierarchical clustering 
colnames(vt) <- samples_name
clust <- hclust(dist(t(vt)))
pdf('results/qc/HClustering.pdf', width=10, height=8)
par(mar = c(8,4.5,2,2)) # tune the margin of plot
as.dendrogram(clust) %>% 
  dendextend::color_branches(k=length(unique(metadata$condition))) %>% 
  dendextend::color_labels(k=length(unique(metadata$condition))) %>%
  plot(ylab='Height', main = 'Cluster dendrogram')
dev.off()

# step 3. DE and output de results ----
rownames(metadata) <- metadata$id
coldatas <- metadata[, 'condition', drop=FALSE]
design.formula <- as.formula('~ condition')
dds <- DESeqDataSetFromMatrix(countData = counts_keep,
                              colData = coldatas,
                              design = design.formula)
de <- DESeq(dds)
normalized_counts <- counts(de, normalized=T)
write.csv(normalized_counts, "normalized_counts_gcn5.csv",
          row.names=T,quote=F)
# set contrast for differential analysis as a list.
# each contrast is set as an vector at the list. 
# Noted: DE will be performed as first element vs second element in the vector
contr.ls <- list(
    c('G', 'WT'),
    c('H', 'WT'),
    c('H', 'G')
)
# extract DE results by contrasts
res.ls <- lapply(contr.ls, function(contr) {

  restmp <- results(de, contrast = c('condition', contr[1], contr[2]), tidy=TRUE) %>% dplyr::rename(GeneID = row)
  
})
names(res.ls) <- paste0('Res_', unlist(lapply(contr.ls, paste, collapse='_')))

# save unfiltered DE results
lapply(seq_along(res.ls), function(x, nm, i) {
      write.csv(x = x[[i]], file = paste0('results/de/', nm[[i]], '_DE.csv'), row.names=FALSE)
}, x=res.ls, nm=names(res.ls))

# significant DEGs are considered as genes that pass cutoff:
# |fold change| >= 2 and p.adj < 0.05
res.sig.ls <- lapply(seq_along(res.ls), function(x, nm, i) {
  sig <- subset(x[[i]], padj < 0.05 & abs(log2FoldChange) >= 1)
  # save significant DEGs tables
  write.csv(x = sig, file = paste0('results/de/', nm[[i]], '_DE_sig.csv'), row.names=FALSE)
  return(sig)
}, x=res.ls, nm=names(res.ls))
# save DE results as .RData
save(de, res.ls, res.sig.ls, file = 'DE.RData')

