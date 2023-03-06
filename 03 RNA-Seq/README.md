## RNA-seq_pipeline

In "RNA-seq_pipeline" folder:

- `RNAseq_pipeline.sh`: In-house script for RNA-sequencing data quality control, mapping and quantification. 
- `README.md`: Detailed description of the `RNAseq_pipeline.sh`

In this step, we got the `raw counts` folder.


## raw counts

In "raw counts" folder, gene summarized counts from fly were listed, containing:
- WT: W1-W4_counts.txt
- gcn5c450/c450: G1-G4_counts.txt
- gcn5c450, tub-GAL4/c450, UAS-HA-Gcn5: H1-H4_counts.txt


## metadata.csv

Information of samples.


## Standard_DESeq2.r

R code for standard gene expression differential analysis using DESeq2.

In this step, we got `normalized_counts_gcn5.xlsx` in the `04 R codes for drawing plots\05 Scatter plot` folder.


The raw data files of sequencing experiments have been deposited in the NCBI Gene Expression Omnibus, as well as the normalized read density profiles of differential expression results from DESeq2 of RNA-seq reported in this paper. The accession number is GEO:GSE221154.

