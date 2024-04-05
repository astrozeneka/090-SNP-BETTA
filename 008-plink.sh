#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J plink
#SBATCH -A proj5034

export PATH=$PATH:/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares
conda activate /tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/gemma

mkdir -p data/plink
/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
  --allow-extra-chr --make-bed --double-id --threads 96 \
  --vcf data/populations/populations.snps.vcf \
  --out data/plink/sex
echo "PLINK done"

