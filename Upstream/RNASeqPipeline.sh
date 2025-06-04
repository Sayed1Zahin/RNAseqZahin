#!bin/bash

# --install SRA-toolkit
# --install salmon: conda install bioconda::salmon

# Run the script
# --Give permission: chmod 555 RNASeqPipeline.sh
# --Run the script: ./RNASeqPipeline.sh

# Declare a list containing SRA sample IDs to be downloaded
samples_to_quant=(SRR6035978 SRR6035979 SRR6035980 SRR6035981 SRR6035982 SRR6035983)

# Loop through each sample ID in the list

for sample in "${samples_to_quan[@]}"
do
  echo processing $sample
  
  #set the timer
  SECONDS = 0
  
  #execute the prefetch command to dounload the .sra into a directory named after the sample
  
  prefetch -O $sample/$sample
  prefetch_time=$SECONDS
  echo "Prefetch completed for $sample in $prefetch_time"
  
  # fasterq-dump command to convert .sra to .fastq
  SECONDS=0
  echo "starting fasterq-dump for $sample"
  fasterq-dump -e 14 -p -O $sample/$sample/$sample/$sample.sra
  fasterq_dump_time=$SECONDS
  echo "fasterq-dump completed for $sample in $fasterq_dump_time seconds"
  
  # run salmon to quantify all the samples
  SECONDS=0
  echo "starting salmon $sample"
  salmon_time=$SECONDS
  echo " salmon completed for $sample in $salmon_time"
  
  
  # calculate total time and print the total processing time for each sample
  
  total_time=$((prefetch_time+fasterq_time+salmon_time))
  echo "Total processing time nfor $sample: $total_time seconds"
  
  
  
  
  
  salmon quant -l A -1 $sample/$sample.sra_1.fastq -2 $sample/$sample.sra_2.fastq --validatemappings -i ~/hg38/salmon_partial_sa_index/default -o salmon.out/$sample -p 15
   
  
  
  
  


done