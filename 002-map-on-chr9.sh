#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 1-00:00:00
#SBATCH -J MAPjob_ryan
#SBATCH -A proj5034

module purge
module load BWA/0.7.17-intel-2019b
module load SAMtools/1.9-intel-2019b

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
mkdir -p "data/map"
for genome in "${genomes[@]}"; do
  echo "Mapping $genome"
  bwa mem -t 96 \
    data/assemblies/BSP9.fna \
    "${READDIR}/${genome}_1.1.fq.gz" "${READDIR}/${genome}_2.2.fq.gz" \
    samtools view -b - > data/map/${genome}.bam
done
echo "Done"