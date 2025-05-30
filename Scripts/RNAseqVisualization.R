library(tidyverse)
library(airway)
library(DESeq2)
library(RColorBrewer)

library(EnhancedVolcano)
library(PoiClaClu)

library(genefilter)
library(AnnotationDbi)




counts_data <- assay(airway)
col_data <- as.data.frame(colData(airway))
colnames(col_data)
rownames(col_data)
colnames(counts_data)
all(colnames(counts_data) %in% rownames(col_data))

all(colnames(counts_data) == rownames(col_data))

dds <- DESeqDataSetFromMatrix(
  countData = counts_data,
  colData = col_data,
  design = ~dex)
























