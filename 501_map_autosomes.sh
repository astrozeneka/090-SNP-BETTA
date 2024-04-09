#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 1-00:00:00
#SBATCH -J map_autosome
#SBATCH -A proj5034

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
  "SRR18231406"	#male
  "SRR18231407"	#female
  "SRR18231408"	#female
  "SRR18231409"	#male
  "SRR18231412"	#female
  "SRR18231415"	#female
  "SRR18231416"	#female
)
ASSEMBLY=$1
SLUG=$2
mkdir -p "data/map-${SLUG}"
for genome in "${genomes[@]}"; do
  echo "Mapping $genome"
  bwa mem -t 96 \
    data/assemblies/BSP9.gfa.fa \
    "${READDIR}/${genome}_1.trimmed_fixed.fq.gz" "${READDIR}/${genome}_2.trimmed_fixed.fq.gz" \
    | samtools view -b > "data/map/${genome}.bam"
done
echo "Done"