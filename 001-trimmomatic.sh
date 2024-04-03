#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 48:00:00
#SBATCH -J trimmomatic
#SBATCH -A proj5034

source ~/.bashrc
conda activate /tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/trimmomatic

genomes=(
  "SRR18231392"
  "SRR18231393"
  "SRR18231394"
  "SRR18231395"
  "SRR18231396"
  "SRR18231397"
  "SRR18231399"
  "SRR18231401"
  "SRR18231402"
  "SRR18231403"
  "SRR18231404"
  "SRR18231405"
  "SRR18231406"
  "SRR18231407"
  "SRR18231408"
  "SRR18231409"
  "SRR18231410"
)

READDIR="/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/betta-raw/"
ILLUMINACLIP="/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/trimmomatic/share/trimmomatic-0.39-2/adapters/TruSeq3-PE.fa"
mkdir -p data/trimmed_reads
for genome in "${genomes[@]}"; do
  echo "Trimming $genome"
  trimmomatic PE -phred33 "${READDIR}/${genome}_1.fastq" "${READDIR}/${genome}_2.fastq" \
    data/trimmed_reads/${genome}_1.trimmed.fq.gz data/trimmed_reads/${genome}_1.unpaired.fq.gz \
    data/trimmed_reads/${genome}_2.trimmed.fq.gz data/trimmed_reads/${genome}_2.unpaired.fq.gz \
    ILLUMINACLIP:${ILLUMINACLIP}:2:30:10 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:100
done
