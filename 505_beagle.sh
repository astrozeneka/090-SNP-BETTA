#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 4
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J beagle
#SBATCH -A proj5057

module load BCFtools

SLUG=$1
# Reorder the vcf file by using BCFTools sort
bcftools sort data/gstacks-${SLUG}/populations.snps.vcf -o data/gstacks-${SLUG}/populations.snps.sorted.vcf

# Filter the data
cat data/gstacks-${SLUG}/populations.snps.sorted.vcf | python python/105_filter_data.py > data/gstacks-${SLUG}/populations.snps.sorted.rmdup.vcf

# Remove the duplicates using bcftools norm
bcftools norm -D data/gstacks-${SLUG}/populations.snps.sorted.rmdup.vcf -o data/gstacks-${SLUG}/populations.snps.sorted.rmdup.vcf


# Impute missing genotypes using Beagle
java -jar /tarafs/data/home/hrasoara/softwares/beagle.22Jul22.46e.jar \
	gt=data/gstacks-${SLUG}/populations.snps.sorted.rmdup.vcf \
	out=data/gstacks-${SLUG}/populations.snps.imputed.vcf

echo "Genotype imputation done"
