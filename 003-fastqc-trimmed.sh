#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 1-00:00:00
#SBATCH -J fastqc-trimmed
#SBATCH -A proj5034

source ~/.bashrc
conda activate fastqc

genomes=(
  "ERR3332434"
  "ERR3332435"
  "ERR3332436"
  "ERR3332437"
  "SRR18231392"
  "SRR18231393"
  "SRR18231394"
  "SRR18231395"
  "SRR18231396"
  "SRR18231397"
)

TRIMMED_READS_DIR="data/trimmed_reads"
for genomes in "${genomes[@]}":
do
  echo "Processing $genome"
  fastqc  "${TRIMMED_READS_DIR}/${genome}_1.trimmed.fq.gz" \
          "${TRIMMED_READS_DIR}/${genome}_2.trimmed.fq.gz" \
    -o "data/fastqc-trimmed"
done
echo "FastQC trimmed reads done"