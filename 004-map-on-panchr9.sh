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
  "ERR3332435"
  "ERR3332436"
  "ERR3332437"
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
  "SRR18231411"
  "SRR18231412"
  "SRR18231413"
  "SRR18231414"
  "SRR18231415"
  "SRR18231416"
  "SRR18231417"
  "SRR18231418"
  "SRR18231419"
  "SRR18231420"
  "SRR18231421"
)

READDIR="data/trimmed_reads"
mkdir -p "data/map"
for genome in "${genomes[@]}"; do
  echo "Mapping $genome"
  bwa mem -t 96 \
    data/assemblies/BSP9.gfa.fa \
    "${READDIR}/${genome}_1.trimmed.fq.gz" "${READDIR}/${genome}_2.trimmed.fq.gz" \
    | samtools view -b > "data/map/${genome}.bam"
  exit
done
echo "Done"