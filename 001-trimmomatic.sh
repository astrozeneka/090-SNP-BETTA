#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 48:00:00
#SBATCH -J trimmomatic
#SBATCH -A proj5034

source ~/.bashrc
conda activate /tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/trimmomatic

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
ILLUMINACLIP="/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/trimmomatic/share/trimmomatic-0.39-2/adapters/TruSeq3-PE.fa"
mkdir -p data/trimmed_reads
for genome in "${genomes[@]}"; do
  echo "Trimming $genome"
  trimmomatic PE -phred33 "${READDIR}/${genome}_1.1.fq.gz" "${READDIR}/${genome}_2.2.fq.gz" \
    data/trimmed_reads/${genome}_1.trimmed.fq.gz data/trimmed_reads/${genome}_1.unpaired.fq.gz \
    data/trimmed_reads/${genome}_2.trimmed.fq.gz data/trimmed_reads/${genome}_2.unpaired.fq.gz \
    ILLUMINACLIP:${ILLUMINACLIP}:2:30:10 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
done
