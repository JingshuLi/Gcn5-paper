Acetylomic data processing 

- `ptmprofile-Gcn5.xlsx`: Gcn5-related acetylomic data (`WT`:Wild type,`G`:gcn5c450/c450, `H`:gcn5c450, tub-GAL4/c450, UAS-HA-Gcn5, at age of 3d)

- `ptmprofile-aging.xlsx`: Aging acetylomic data (`3d`, `15d`, `30d', and `45d` represented wild type flies at age of 3d, 15d, 30d, and 45d, respectively.)

## Sheet1: Raw data (`xx_modified`:intensity of acetylation)

## Sheet2: Keeping information only important for calculation

	- Lists: keeping lists of `xx_modified` and simple description
	- Raws: deleting raws that `Sum Modified=0`

## Sheet3: Normalization

	- The intensities for acetylation levels were divided by the ratio of the sum intensity of each replicate in every group.
	- Missing values were labelled as `NA` and the average levels were calculated using intensities in the remaining replicates.
	(- Acetylation sites with more than two missing values in each group were filtered out. We got `Gcn5 cor matrix.xlsx` and `Aging cor matrix.xlsx` in the `04 R codes for drawing plots\08 Correlation matrix` folder.)

## Sheet4: Protein normalization	

	- The relative acetylation levels were the acetylation levels divided by the ratio of protein levels at WT: gcn5c450/c450: gcn5c450, tub-GAL4/c450, UAS-HA-Gcn5 or WT 3d:15d:30d:45d respectively. 
	- Acetylation sites whose corresponding protein abundances were not quantified were also filtered out.

## Sheet5: Calculation

	- Acetylation sites with more than two missing values in each group were filtered out. 
	- Log2 fold change, p-value of student t-test, and log10 intensity were calculated and arranged to generate `For violin-gcn5.xlsx` and `For violin-aging.xlsx` in the `04 R codes for drawing plots\02 Violin plot` folder, `Heatmap-gcn5 candidates.xlsx` and `Heatmap-gcn5 candidates align with aging.xlsx` in the `04 R codes for drawing plots\04 Heatmap` folder, and `Aging for line graph.xlsx` in the `04 R codes for drawing plots\07 Line graph` folder.
	- In Gcn5-related data, to obtain GCN5 candidates, the threshold of significant alterations of relative acetylation level was set as followed: fold change of WT / gcn5c450/c450>1.5, p-value<0.05, two-tailed Student's t test; fold change of gcn5c450,tub-GAL4/c450,UAS-HA-Gcn5 / gcn5c450/c450>1. To obtain GCN5-promoted acetylation sites, the threshold of significant alterations of relative acetylation level was set as followed: fold change of gcn5c450,tub-GAL4/c450,UAS-HA-Gcn5 / WT>1.5, a significance threshold of a testing p-value<0.05, two-tailed Student's t test. 
	- In aging data, to get age-associated dynamic acetylation sites, we set thresholds as followed: Age-associated increased sites: 45d-specific sites (3d=15d=30d=0); 30d/45d-specific sites (3d=15d=0); 15d/30d/45d-specific sites (3d=0, 15d<30d<45d); and common sites with increased acetylation (3d<15d<30d<45d, p-value of 3d & 45d <0.05, two-tailed Student's t test); Age-associated decreased acetylation sites: 3d-specific sites (15d=30d=45d=0); 3d/15d-specific sites (30d=45d=0); 3d/15d/30d-specific sites (3d>15d>30d, 45d=0); and common sites with decreased acetylation (3d>15d>30d>45d, p-value of 3d & 45d <0.05, two-tailed Student's t test).





