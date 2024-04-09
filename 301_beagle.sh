#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 4
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J beagle
#SBATCH -A proj5034

source ~/.bashrc

mkdir data/beagle

#Reorder the vcf file by using BCFTools sort
module load BCFtools
bcftools sort data/populations/populations.snps.vcf -o data/beagle/sorted.snps.vcf

# Use beagle software to impute missing genotypes
beagle gt=data/beagle/sorted.snps.vcf out=data/beagle/imputed.snps.vcf
echo "Beagle done"