#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J plink-ld
#SBATCH -A proj5057

SLUG=$1

/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
	--threads 32 \
	--bfile data/gstacks-${SLUG}/sex \
	--allow-extra-chr \
	--r \
	--ld-window-r2 0.2 \
	--ld-window 10 \
	--ld-window-kb 1000 \
	--out data/gstacks-${SLUG}/sex
echo "PLINK LD done"
