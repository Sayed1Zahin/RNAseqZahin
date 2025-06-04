#install tximport
BiocManager::install("tximport")
BiocManager::install("EnsDb.Hsapiens.v86")

#Load all required packages
library(tidyverse)
library(tximport)
library(DESeq2)
library(EnsDb.Hsapiens.v86)
library(EnhancedVolcano)
library(pheatmap)

# what are the column in the EnsDb.Hsapiens.v86?

columns(EnsDb.Hsapiens.v86)

# get the TX ID and symbol

tx2gene <- AnnotationDbi::select(EnsDb.Hsapiens.v86,
                     keys = keys(EnsDb.Hsapiens.v86),
                     columns = c('TXID','SYMBOL'))


# remove the geneID column

tx2gene <- dplyr::select(tx2gene, -GENEID)

view(tx2gene)

# get the quant files and metadata
#collect the sample quant file

samples <- list.dirs("upstream/salmon.out/",, recursive = FALSE, full.names = FALSE)

quant.files <- file.path("upstream/salmon.out/", samples, "quant.sf")

names(quant.files) <- samples
print(quant.files)

# ensure each file actually exist
file.exists(quant.files)

# metadata/col data
data.frame(
  row.names = samples,
  condition = rep(c("untreated", "dex"), 4)
)

# get the tximpor count object

tximport(files = quant.files,
         type = "salmon",
         tx2gene = tx2gene,
         ignoreTxVersion = TRUE)


# make DESeq object
dds <- DESeqDataSetFromTximport(
  txi = counts_data,
  colData = col_data,
  design = ~condition
)

# --PCA
vsd <- vst(dds)
plotPCA(dds)

# Perform DEG analysis 
dds <- DESeq(dds)

# obtain result
res <- results(dds)















































