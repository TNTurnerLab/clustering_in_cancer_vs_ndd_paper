## Readme on plotting the variants
### Tychele N. Turner, Ph.D.
### February 1, 2024

Analysis to plot the variants on 3D structures using an intensity-based color scheme. Red are variants in NDDs and Blue are variants in Cancer. The more intense the color, the more variants at that residue. A table is also included in the html output. This is using the `plot3D_with_counts_intensity.R` script. The original script `plot3D_with_counts.R` is retained for record keeping and colors variants either Red or Blue with not intensity shading.

Two sample files (`NDD_VARIANTS.txt`, `BRCA_VARIANTS.txt`) are included in this directory. The files are derived from the variant files present in the Supplementary Tables. A file with the significant proteins `BRCA_NDD_Significant.txt` is also provided. 

To run the analysis on a bunch of files at once:

```
while read line
do
grep -w "$line" NDD_VARIANTS.txt | cut -f4 > NDD_VARIANTS_INPUT.txt
grep -w "$line" BRCA_VARIANTS.txt | cut -f4 > BRCA_VARIANTS_INPUT.txt
Rscript plot3D_with_counts.R -d NDD_VARIANTS_INPUT.txt -e BRCA_VARIANTS_INPUT.txt -p ModelArchive_Submission/"$line".pdb -o "$line".visualization.NDD.v.BRCA.significant.html
done < BRCA_NDD_Significant.txt
```

An example is provided to run one protein:

```
Rscript plot3D_with_counts_intensity.R -p NP_001180345.pdb -d NP_001180345_NDD_VARIANTS.txt -e NP_001180345_BRCA_VARIANTS.txt -
o NP_001180345_visualization.html
```

