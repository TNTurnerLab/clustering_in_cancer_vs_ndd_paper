#!/bin/Rscript

library("optparse")

# Setup arguments
option_list <- list(
	make_option(c("-p", "--pdb"), type = "character", default = NULL, help = "Path to PDB file", metavar = "path/to/pdb_file.pdb"),
	make_option(c("-d", "--dataset1"), type = "character", default = NULL, help = "Path to the first dataset file", metavar = "path/to/dataset1.tsv"),
	make_option(c("-c", "--color1"), type = "character", default = "red", help = "Color for the first datasets selections", metavar = "color1"),
	make_option(c("-n", "--name1"), type = "character", default = "NDD", help = "Name for the first datasets selections", metavar = "name1"),
	make_option(c("-e", "--dataset2"), type = "character", default = NULL, help = "Path to the second dataset file", metavar = "path/to/dataset2.tsv"),
	make_option(c("-g", "--color2"), type = "character", default = "blue", help = "Color for the second datasets selections", metavar = "color2"),
	make_option(c("-z", "--name2"), type = "character", default = "Cancer", help = "Name for the second datasets selections", metavar = "name2"),
	make_option(c("-o", "--output"), type = "character", default = "protein_visualization.html", help = "Output HTML file name", metavar = "protein_visualization.html")
)

args <- parse_args(OptionParser(option_list=option_list))

# Function to read selections from a dataset file and count occurrences
read_selections_and_counts <- function(file_path) {
	data <- read.table(file_path, stringsAsFactors=FALSE)
	counts <- table(data[[1]])
	return(as.data.frame(counts, stringsAsFactors=FALSE))
}

# Read selections and counts from dataset files
data1 <- read_selections_and_counts(args$dataset1)
names(data1) <- c("Residue", "Count1")
data2 <- read_selections_and_counts(args$dataset2)
names(data2) <- c("Residue", "Count2")

# Merge data1 and data2 by residue
combined_data <- merge(data1, data2, by="Residue", all=TRUE)
combined_data[is.na(combined_data)] <- 0  # Replace NA with 0

# Convert Residue to numeric for sorting, handling non-numeric residues safely
combined_data$ResidueNum <- as.numeric(as.character(combined_data$Residue))
combined_data <- combined_data[order(combined_data$ResidueNum, na.last=NA), ]

# Read PDB file content
pdb_content <- paste(readLines(args$pdb), collapse="\\n")

# Generate the HTML content
html_content <- sprintf('
<html>
<head>
  <title>Protein Visualization</title>
  <script src="https://unpkg.com/ngl@latest/dist/ngl.js"></script>
</head>
<body>
  <div id="viewport" style="width:800px; height:600px;"></div>
  <script>
    var stage = new NGL.Stage("viewport", {backgroundColor: "white"});
    var stringBlob = new Blob(["%s"], {type: "text/plain"});
    
    stage.loadFile(stringBlob, { ext: "pdb" }).then(function(o) {
      o.addRepresentation("cartoon", { color: "gray" });
      %s
      stage.autoView();
    });

    window.addEventListener("resize", function(event){ stage.handleResize(); }, false);
  </script>
  <table border="1">
    <tr><th>Residue</th><th>%s Count</th><th>%s Count</th></tr>
    %s
  </table>
</body>
</html>
', pdb_content, 
   paste(lapply(1:nrow(combined_data), function(i) {
     residue <- combined_data[i, "Residue"]
     color <- ifelse(combined_data[i, "Count1"] > 0 & combined_data[i, "Count2"] > 0, "purple", ifelse(combined_data[i, "Count1"] > 0, args$color1, args$color2))
     sprintf('o.addRepresentation("spacefill", { sele: "%s", color: "%s" });', residue, color)
   }), collapse="\n"),
   args$name1, args$name2,
   paste(lapply(1:nrow(combined_data), function(i) {
     sprintf('<tr><td>%s</td><td>%d</td><td>%d</td></tr>', combined_data[i, "Residue"], combined_data[i, "Count1"], combined_data[i, "Count2"])
   }), collapse="\n")
)

# Write the HTML to a file
writeLines(html_content, args$output)
cat("Visualization saved to", args$output, "\n")

