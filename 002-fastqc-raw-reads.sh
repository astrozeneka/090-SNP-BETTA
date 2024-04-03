#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 16
#SBATCH -t 1-00:00:00
#SBATCH -J fastqc-raw-reads
#SBATCH -A proj5034

source ~/.bashrc
conda activate fastqc

genomes=(
  "ERR3332436"
)

READDIR="/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/betta-raw"

mkdir -p "data/fastqc-raw-reads"
for genome in "${genomes[@]}"; do
  echo "Running FastQC on $genome"
  fastqc "${READDIR}/${genome}_1.fastq" "${READDIR}/${genome}_2.fastq" \
    -o "data/fastqc-raw-reads"
done
echo "FastQC raw reads done"
