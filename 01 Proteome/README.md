Proteomic data processing 

- `proteins-Gcn5.xlsx`: Gcn5-related proteomic data (`WT`:Wild type,`G`:gcn5c450/c450 (gcn5 knock out), `H`:gcn5c450, tub-GAL4/c450, UAS-HA-Gcn5 (GCN5 overexpression), at age of 3d)

- `proteins-aging.xlsx`: Aging proteomic data (`3d`, `15d`, `30d', and `45d` represented wild type flies at age of 3d, 15d, 30d, and 45d, respectively.)

## Sheet1: Raw data (`Area`:intensity)

## Sheet2: Keeping information only important for calculation

	- Lists: keeping lists of `Area` and simple description
	- Rows: deleting rows that `Sum Area=0`

## Sheet3: Normalization

	- The intensities for protein levels were divided by the ratio of the sum intensity of each replicate in every group.
	- Missing values were labelled as `NA` and the average levels were calculated using intensities in the remaining replicates.
	- The ratios of average protein levels of WT: gcn5c450/c450: gcn5c450, tub-GAL4/c450, UAS-HA-Gcn5 and the ratios of average protein levels of WT 3d:15d:30d:45d were calculated for normalization of the acetylomic data respectively and were used in the normalization of acetylation levels in the `02 Acetylome` folder.
