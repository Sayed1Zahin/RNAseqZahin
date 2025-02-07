install.packages(c("tidyverse","ggpubr","openxlsx"))
library(BiocManager)
BiocManager :: install(c("GEOquery","TGAbiolinks","DESeq2"))
library(GEOquery)
library(TGAbiolinks)
library(DESeq2)
library(tidyverse)
library(ggpubr)
library(openxlsx)


# select
data(airways)
data("airquality")
view(airquality)

select(airquality, 1)
select(airquality, 1:3)
head(airquality)
is.na(airquality)
filter(airquality, Temp > 70 & Wind > 8)
head(airquality)
airquality %>% 
  select(Ozone, Wind, Temp) %>% 
  filter(Temp > 70 & Wind > 8) %>% 
  head()
  
  
airquality %>% 
  filter(Temp %in% c("74","72")) %>% 
  head()
  
  
  
  
  
  
  
  