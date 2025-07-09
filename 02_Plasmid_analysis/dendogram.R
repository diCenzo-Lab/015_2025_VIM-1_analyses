# Load libraries
library("ape")
library("philentropy")

# Load the data
matrix <- read.table(file = "gene_presence_absence.Rtab", header = TRUE,
                     row.names = 1, stringsAsFactors = TRUE)
transposed_matrix <- t(matrix)

# Prepare distance tree based on the pangenome
r_names <- row.names(transposed_matrix)
matrix_dist <- distance(transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram.tre")
