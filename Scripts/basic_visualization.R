library(tidyverse)

data <- read.csv("Data/GSE183947_counts.csv")


ggplot(data, aes(x = , y = )) + geom_type()

data %>% 
  filter(gene == "BRCA1") %>% 
  ggplot(aes(x = samples, y  = fpkm, fill = tissue)) +
  geom_col()

data %>% 
  filter(gene == "BRCA1") %>% 
  ggplot(aes(x = metastasis, y  = fpkm, fill = tissue)) +
  geom_boxplot()

data %>% 
  filter(gene == "BRCA1") %>% 
  ggplot(aes(x  = fpkm, fill = tissue)) +
  geom_histogram() +
  facet_wrap(~tissue)

data %>% 
  filter(gene == "BRCA1") %>% 
  ggplot(aes(x  = fpkm, fill = tissue)) +
  geom_density() +
  facet_wrap(~tissue)

data %>% 
  filter(gene == "BRCA1" | gene == "BRCA2") %>% 
  spread(key = gene, value = fpkm) %>% 
  ggplot(aes(x = BRCA1, y= BRCA2, color = tissue)) +
  geom_point()

data %>% 
  filter(gene == "BRCA1" | gene == "BRCA2") %>% 
  spread(key = gene, value = fpkm) %>% 
  ggplot(aes(x = BRCA1, y= BRCA2, color = tissue)) +
  geom_point()+
  geom_smooth(method = "lm", se = FALSE)


gene_of_interests <- c("BRCA1","BRCA2","TP53","ALK","MYCN")

data %>% 
  filter(gene %in% gene_of_interests) %>% 
  ggplot(aes(x = samples, y = gene, fill = fpkm))+
  geom_tile()+
  scale_fill_gradient(low = "white", high = "red")






