#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J 401-map
#SBATCH -A proj5034

module purge
module load BWA/0.7.17-intel-2019b
module load SAMtools/1.9-intel-2019b

# Only map the missing genomes
genomes=(
  "SRR18231406"	#male
  "SRR18231407"	#female
  "SRR18231408"	#female
  "SRR18231409"	#male
  "SRR18231412"	#female
  "SRR18231415"	#female
  "SRR18231416"	#female
)

READDIR="data/trimmed_reads"
for genome in "${genomes[@]}"; do
  echo "Mapping $genome"
  bwa mem -t 96 \
    data/assemblies/BSP9.gfa.fa \
    "${READDIR}/${genome}_1.trimmed_fixed.fq.gz" "${READDIR}/${genome}_2.trimmed_fixed.fq.gz" \
    | samtools view -b > "data/map/${genome}.bam"
done
echo "Done"
