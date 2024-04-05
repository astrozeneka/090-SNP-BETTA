#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 1-00:00:00
#SBATCH -J gstacks
#SBATCH -A proj5034

module load foss/2021b
export PATH=$PATH:/tarafs/data/project/proj5034-AGBKU/local/bin/

cat <<EOF > popmap.txt
ERR3332435	male
ERR3332436	male
SRR18231392	male
SRR18231393	male
SRR18231394	male
SRR18231395	male
SRR18231396	male
SRR18231397	male
SRR18231399	male
SRR18231401	female
SRR18231402	female
SRR18231403	male
SRR18231404	female
SRR18231405	female
EOF

mkdir -p data/gstacks
gstacks -I data/sorted-map -M popmap.txt -O data/gstacks
echo "gstacks done"

