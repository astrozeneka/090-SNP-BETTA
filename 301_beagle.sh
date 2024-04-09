#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 4
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J beagle
#SBATCH -A proj5034

mkdir -p data/beagle

#Reorder the vcf file by using BCFTools sort
module load BCFtools
bcftools sort data/beagle/populations.snps.filtered.vcf -o data/beagle/sorted.snps.vcf

#Remove duplicates using bcftools norm
bcftools norm -D data/beagle/sorted.snps.vcf -o data/beagle/sorted.rmdup.snps.vcf

# Use beagle software to impute missing genotypes
java -jar /tarafs/data/home/hrasoara/softwares/beagle.22Jul22.46e.jar \
  gt=data/beagle/sorted.rmdup.snps.vcf out=data/beagle/imputed.snps.vcf
echo "Beagle done"
