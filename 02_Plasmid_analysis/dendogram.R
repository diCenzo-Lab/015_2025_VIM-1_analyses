# Load libraries
library("ape")
library("philentropy")
library("phangorn")

# Load the data
matrix <- read.table(file = "gene_presence_absence.Rtab", header = TRUE,
                     row.names = 1, stringsAsFactors = TRUE, sep = "\t")
transposed_matrix <- t(matrix)

# Prepare distance tree based on the pangenome
r_names <- row.names(transposed_matrix)
matrix_dist <- distance(transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_full.tre")
full_tree <- tree_bionj

# Bootstrap - 1
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
my_multiPhylo <- tree_bionj

# Bootstrap - 2-1000
for(n in 1:999) {
  sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
  sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
  r_names <- row.names(sampled_transposed_matrix)
  matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
  row.names(matrix_dist) <- r_names
  tree_bionj <- bionj(matrix_dist)
  my_multiPhylo <- c(my_multiPhylo, tree_bionj)
}

# Calculate bootstrap values
tree_with_bs <- plotBS(full_tree, my_multiPhylo, type="phylogram")
write.tree(tree_with_bs, file = "dendogram_bootstrapped.tre")



# Bootstrap - 1
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_bootstrap_1.tre")

# Bootstrap - 2
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_bootstrap_2.tre")

# Bootstrap - 3
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_bootstrap_3.tre")

# Bootstrap - 4
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_bootstrap_4.tre")

# Bootstrap - 5
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_bootstrap_5.tre")

# Bootstrap - 6
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_bootstrap_6.tre")

# Bootstrap - 7
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_bootstrap_7.tre")

# Bootstrap - 8
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_bootstrap_8.tre")

# Bootstrap - 9
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_bootstrap_9.tre")

# Bootstrap - 10
sampled_col_indices <- sample(1:ncol(transposed_matrix), size = 2648, replace = TRUE)
sampled_transposed_matrix <- transposed_matrix[, sampled_col_indices]
r_names <- row.names(sampled_transposed_matrix)
matrix_dist <- distance(sampled_transposed_matrix, method = "jaccard")
row.names(matrix_dist) <- r_names
tree_bionj <- bionj(matrix_dist)
write.tree(tree_bionj, file = "dendogram_bootstrap_10.tre")

# Calculate bootstrap values
bootstrap_trees <- read.tree(file="dendogram_bootstrap.tre")
tree_with_bs <- plotBS(full_tree, bootstrap_trees, type="phylogram")
write.tree(tree_with_bs, file = "dendogram_bootstrapped.tre")
