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
  "ERR3332435"
  "ERR3332436"
)

mkdir -p "data/sorted-map"
for genome in "${genomes[@]}"; do
  echo "Sorting and indexing $genome"
  samtools sort -@ 96 "data/map/${genome}.bam" -o "data/sorted-map/${genome}.sorted.bam"
  samtools index "data/sorted-map/${genome}.sorted.bam"
done
echo "Sorting and indexing done"
