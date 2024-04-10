#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 32
#SBATCH -t 1-00:00:00
#SBATCH -J gstacks
#SBATCH -A proj5034

module load foss/2021b
export PATH=$PATH:/tarafs/data/project/proj5034-AGBKU/local/bin/

cat <<EOF > popmap.txt
ERR3332435.sorted	male
ERR3332436.sorted	male
SRR18231392.sorted	male
SRR18231393.sorted	male
SRR18231394.sorted	male
SRR18231395.sorted	male
SRR18231396.sorted	male
SRR18231397.sorted	male
SRR18231399.sorted	male
SRR18231401.sorted	female
SRR18231402.sorted	female
SRR18231403.sorted	male
SRR18231404.sorted	female
SRR18231405.sorted	female
SRR18231406.sorted	male
SRR18231407.sorted	female
SRR18231408.sorted	female
SRR18231409.sorted	male
SRR18231412.sorted	female
SRR18231415.sorted	female
SRR18231416.sorted	female
EOF

SLUG=$1
mkdir -p data/gstacks-${SLUG}
gstacks -t 32 -I data/sorted-map-${SLUG} -M popmap.txt -O data/gstacks-${SLUG}
echo "gstacks done"