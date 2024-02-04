# Clustering in Cancer vs NDD Paper

## This is a project that is a collaboration between the laboratories of Dr. Tychele N. Turner at Washington University in St. Louis and Dr. Rachel Karchin at the Johns Hopkins University. 

## Contributors to this project include:
Jeffrey K. Ng :red_circle:, Yilin Chen :red_circle: , Titilope Akinwe :red_circle:, Hillary B. Heins, Elvisa Mehinovic, Yoonhoo Chang, Zachary L. Payne, Juana G. Manuel, Rachel Karchin :large_blue_diamond:, and Tychele N. Turner :large_blue_diamond:

:red_circle: co-first authors

:large_blue_diamond: denotes co-corresponding authors

Please check out our preprint on medRxiv: https://www.medrxiv.org/content/10.1101/2024.02.02.24302238v1 and watch for our future publication.

## AlphaFold Structures
We generated RefSeq structures for proteins based on their RefSeq sequence. This was to be in alignment with the variant annotation information. We focused on proteins where there were at least 5 missense de novo variants in individuals with neurodevelopmental disorders and 5 missense somatic variants in individuals with cancer. Proteins requiring more than 700 GB of RAM to model were not possible for us to model in our current compute environment and were therefore not generated in this study.

The final AlphaFold structures have been deposited at https://www.modelarchive.org/doi/10.5452/ma-tur-clump

## Plotting Proteins with Proteome-Wide Significance for Clustering of Missense Variants
We generated plots of missense variants on 3D structures using an intensity-based color scheme for all proteins reaching proteome-wide significance. Red are variants in NDDs and Blue are variants in Cancer. The more intense the color, the more variants at that residue. A table is also included in the html output. 

The final plots are present as html files by comparison types at: https://data.cyverse.org/dav-anon/iplant/home/tycheleturner/3D-CLUMP-Paper/Proteins_With_Significant_Clustering


