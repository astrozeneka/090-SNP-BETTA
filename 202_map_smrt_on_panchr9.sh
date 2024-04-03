#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 1-00:00:00
#SBATCH -J map-smrt
#SBATCH -A proj5034

module purge
module load BWA/0.7.17-intel-2019b
module load SAMtools/1.9-intel-2019b

genomes=(
  "ERR3168368"
  "SRR11828788"
)

mkdir -p "data/map-smrt"
READ_DIR="/tarafs/data/home/hrasoara/scratch/betta-smrt"
for genome in "${genomes[@]}"; do
  echo "Mapping $genome"
  bwa mem -t 96 \
    data/assemblies/BSP9.gfa.fa \
    "${READ_DIR}/${genome}.fastq" \
    | samtools view -b > "data/map-smrt/${genome}.bam"
done
echo "Mapping long reads done"
