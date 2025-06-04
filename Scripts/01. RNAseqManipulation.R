install.packages(c("tidyverse","ggpubr","openxlsx"))
library(BiocManager)
BiocManager :: install(c("GEOquery","TGAbiolinks","DESeq2"))
library(GEOquery)
library(TGAbiolinks)
library(DESeq2)
library(tidyverse)
library(ggpubr)
library(openxlsx)

# import data
data <- read.csv("Data/GSE183947_counts.csv")
# data exploration
head(data, 10)
tail(data)
ncol(data)
nrow(data)

# missing value
sum(is.na(data))

# select single column
select(data, 1)

#select multiple column
select(data, c(1,3,6))

# select column by name
select(data, gene)


# filter
# filter using ==
filter(data, metastasis == "yes")

# filter data using (>)
filter(data, fpkm < 10)

# filter data using (>=) and (<=
filter(data, fpkm <= 10)
filter(data, fpkm >= 10)

# filter using (&)(/) 
filter(data, metastasis == "yes" & fpkm > 10)
filter(data, metastasis == "yes" | fpkm > 10)

# select and filter

new_data <- select(data, gene, metastasis, fpkm)
filter(new_data, metastasis == "yes")

# using pipe operator
data %>% 
  select(gene, metastasis, fpkm) %>% 
  filter(metastasis == "yes") %>% 
  head()
# multiple filtering criteria (%in%)
data %>% 
  filter(gene %in% c("BRCA1","BRCA2","TP53","ALK","MYCN")) %>% 
  head()

# mutate (creating new column)
data %>% 
  mutate(fpkm_log = log(fpkm)) %>% 
  head()

# grouping and summarizing
data %>% 
  filter(gene == "BRCA1" | gene == "BRCA2") %>% 
  group_by(tissue, gene) %>% 
  summarise(mean(fpkm))

# grouping and summarizing
data %>% 
  filter(gene == "BRCA1" | gene == "BRCA2") %>% 
  group_by(tissue, gene) %>% 
  summarise(mean_fpkm = mean(fpkm),
            median_fpkm = median(fpkm))

# arrange
data %>% 
  filter(gene == "BRCA1" | gene == "BRCA2") %>% 
  group_by(tissue, gene) %>% 
  summarise(mean_fpkm = mean(fpkm),
            median_fpkm = median(fpkm)) %>% 
  arrange(mean_fpkm)


data %>% 
  filter(gene == "BRCA1" | gene == "BRCA2") %>% 
  group_by(tissue, gene) %>% 
  summarise(mean_fpkm = mean(fpkm),
            median_fpkm = median(fpkm)) %>% 
  arrange(desc(mean_fpkm))



  
  
  
  
  
  
  