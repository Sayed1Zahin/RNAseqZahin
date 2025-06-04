# install required R packages (tidyverse, ggpubr, openxlsx)
install.packages(c("tidyverse", "ggpubr", "openxlsx"))

# install required bioconductor packages
BiocManager::install(c("GEOquery", "TCGAbiolinks", "DESeq2", "airway"))



# load required packages
library(tidyverse)
library(GEOquery)
library(ggpubr)
library(openxlsx)
library(naniar)


# import data
counts_data <- read.csv("Data/GSE183947_fpkm.csv")
res <- getGEO(GEO = "GSE183947", GSEMatrix = T)
class(res)

# metadata
metadata <- pData(phenoData(res[[1]]))

# subset metadata
metadata %>% 
  head()
metadata_sub <- metadata %>% 
  select(c(1,10,11,17))

# data preprocessing
metadata_modified <- metadata_sub %>% 
  rename(tissue = characteristics_ch1, metastasis = characteristics_ch1.1) %>% 
  mutate(tissue = gsub("tissue: ", "", tissue)) %>% 
  mutate(metastasis = gsub("metastasis: ", "", metastasis))          
  

#reshaping data
counts_data_long <- counts_data %>% 
  rename(gene = X) %>%
  pivot_longer(-gene,
               names_to = "samples",
               values_to = "fpkm")

write.csv(counts_data_long, "Data/GSE183947_counts_long.csv")

# joining data
counts_final <- counts_data_long %>% 
  left_join(metadata_modified, by = c("samples" = "description"))

# export data
write.csv(counts_final,"Data/GSE183947_counts.csv", row.names = F)














