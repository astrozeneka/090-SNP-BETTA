#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 1
#SBATCH -t 32:00:00
#SBATCH -J density-on-panchr9
#SBATCH -A proj5034

module purge
module load bzip2/1.0.8-GCCcore-10.2.0
module load ncurses/6.2-GCCcore-10.2.0
module load foss/2021b
export PATH=$PATH:/tarafs/data/home/hrasoara/softwares/samtools-1.18/
source venv/bin/activate

genomes=(
  "SRR18231392"
  "SRR18231393"
  "SRR18231394"
  "SRR18231395"
  "SRR18231396"
  "SRR18231397"
  "SRR18231399"
  "SRR18231401"
  "SRR18231402"
  "SRR18231403"
  "SRR18231404"
  "SRR18231405"
)

BAM_DIR="data/sorted-map"
mkdir -p data/reads_density
for genome in "${genomes[@]}"; do
  echo "Computing density for $genome"
  samtools depth -a ${BAM_DIR}/${genome}.sorted.bam \
    | python python/10_convert_depth_to_window.py --window 100 \
    > data/reads_density/${genome}.coverage.tsv
done
echo "Done computing density for ${#genomes[@]} genomes."
