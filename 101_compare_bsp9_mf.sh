#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 120
#SBATCH -t 48:00:00
#SBATCH --mem=250G
#SBATCH -J compare_bsp9_mf
#SBATCH -A proj5057

module purge
module load bzip2/1.0.8-GCCcore-10.2.0
module load ncurses/6.2-GCCcore-10.2.0
module load foss/2021b
source /tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/Softwares/cactus/venv/bin/activate

cat <<EOF > data/bsp9_mf.txt
bsp9_m ./data/assemblies/BSP9_m.fasta
bsp9_f ./data/assemblies/BSP9_f.fasta
EOF

cactus-pangenome ./js data/bsp9_mf.txt --outputDir data/bsp9_mf --outName bsp9 --reference bsp9_m
echo "Cactus pangenome done"

