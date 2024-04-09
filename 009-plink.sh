#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 24:00:00
#SBATCH --mem=100GB
#SBATCH -J plink
#SBATCH -A proj5034

export PATH=$PATH:/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares

mkdir -p data/plink
/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
  --geno 0.5 --mind 0.9 --maf 0.05 \
  --allow-extra-chr --make-bed --double-id --threads 96 \
  --vcf data/populations/populations.snps.vcf \
  --out data/plink/sex
echo "PLINK done"

# Override the outputted fam file
cat <<EOF > data/plink/sex.fam
ERR3332435.sorted ERR3332435.sorted 0 0 0 1
ERR3332436.sorted ERR3332436.sorted 0 0 0 1
SRR18231392.sorted SRR18231392.sorted 0 0 0 1
SRR18231393.sorted SRR18231393.sorted 0 0 0 1
SRR18231394.sorted SRR18231394.sorted 0 0 0 1
SRR18231395.sorted SRR18231395.sorted 0 0 0 1
SRR18231396.sorted SRR18231396.sorted 0 0 0 1
SRR18231397.sorted SRR18231397.sorted 0 0 0 1
SRR18231399.sorted SRR18231399.sorted 0 0 0 1
SRR18231401.sorted SRR18231401.sorted 0 0 0 2
SRR18231402.sorted SRR18231402.sorted 0 0 0 2
SRR18231403.sorted SRR18231403.sorted 0 0 0 1
SRR18231404.sorted SRR18231404.sorted 0 0 0 2
SRR18231405.sorted SRR18231405.sorted 0 0 0 2
EOF

# Write the phenotype.txt file
cat <<EOF > phenotype.txt
1
1
1
1
1
1
1
1
1
0
0
1
0
0
EOF

# calculate fisher association
/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/plink \
  --geno 0.5 --mind 0.9 --maf 0.05 \
  --allow-extra-chr \
  --bfile data/plink/sex \
  --allow-no-sex --fisher --out data/plink/sex

echo "Gemma part 1"
~/proj5057-AGBKUB/ryan/conda-envs/gemma/bin/gemma -bfile data/plink/sex \
  -gk 1 \
  -p phenotype.txt \
  -o gemma_kinship
echo "Gemma part 1 done"

echo "Gemma part 2"
~/proj5057-AGBKUB/ryan/conda-envs/gemma/bin/gemma -bfile data/plink/sex \
  -p phenotype.txt \
  -k output/gemma_kinship.cXX.txt \
  -lmm 1 \
  -o gemma_lmm1
echo "Gemma part 2 done"

# Store the results
mv output/* data/plink/
rmdir output
echo" PLINK pipeline done"
