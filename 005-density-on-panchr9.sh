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
  "ERR3332434"
  "ERR3332435"
)

BAM_DIR="data/bam"
mkdir -p data/reads_density
for genome in "${genomes[@]}"; do
  echo "Computing density for $genome"
  samtools depth -a ${BAM_DIR}/${genome}.bam \
    | python python/10_convert_depth_to_window.py --window 100 \
    > data/reads_density/${genome}.coverage.tsv
done
echo "Done computing density for ${#genomes[@]} genomes."