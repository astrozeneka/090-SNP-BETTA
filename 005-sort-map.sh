#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 1-00:00:00
#SBATCH -J sort-map
#SBATCH -A proj5034

module purge
module load BWA/0.7.17-intel-2019b
module load SAMtools/1.9-intel-2019b

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
)

mkdir -p "data/sorted-map"
for genome in "${genomes[@]}"; do
  echo "Sorting and indexing $genome"
  samtools sort -@ 96 "data/map/${genome}.bam" -o "data/sorted-map/${genome}.sorted.bam"
  samtools index "data/sorted-map/${genome}.sorted.bam"
done
echo "Sorting and indexing done"
