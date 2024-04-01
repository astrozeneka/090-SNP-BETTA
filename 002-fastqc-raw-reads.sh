#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 1-00:00:00
#SBATCH -J fastqc-raw-reads
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

READDIR="/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/betta-cleaned/reads"

mkdir -p "data/fastqc-raw-reads"
for genome in "${genomes[@]}"; do
  echo "Running FastQC on $genome"
  fastqc "${READDIR}/${genome}_1.1.fq.gz" "${READDIR}/${genome}_2.2.fq.gz" \
    -o "data/fastqc-raw-reads"
done
echo "FastQC raw reads done"