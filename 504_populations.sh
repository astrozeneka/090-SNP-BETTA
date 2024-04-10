#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 1-00:00:00
#SBATCH -J populations
#SBATCH -A proj5057

module load foss/2021b
export PATH=$PATH:/tarafs/data/project/proj5034-AGBKU/local/bin/

SLUG=$1
populations -P data/gstacks-${SLUG} \
	-M popmap.txt \
	-O data/gstacks-${SLUG} \
	--min-samples-per-pop 0.60 \
	--min-maf 0.05 \
	--max-obs-het 0.8 \
	--fstats \
	--fst-correction \
	--genepop \
	--vcf \
	--plink \
	--structure \
	--gtf \
	--fasta-loci \
	--fasta-samples \
	-t 32

echo "populations done for ${SLUG}"