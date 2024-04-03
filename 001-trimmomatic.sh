#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 48:00:00
#SBATCH -J trimmomatic
#SBATCH -A proj5034

source ~/.bashrc
conda activate /tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/trimmomatic

genomes=(
  "ERR3332435"
  "ERR3332436"
  "ERR3332437"

  "SRR18231411"
  "SRR18231412"
  "SRR18231413"
  "SRR18231414"
  "SRR18231415"
  "SRR18231416"
  "SRR18231417"
  "SRR18231418"
  "SRR18231419"
  "SRR18231420"
  "SRR18231421"
  "SRR18231422"
  "SRR18231423"
  "SRR18231424"
  "SRR18231425"
  "SRR18231426"

  "SRR18231428"
  "SRR18231429"
  "SRR18231430"
  "SRR18231431"
  "SRR19508262"
  "SRR19508263"
  "SRR19508264"
  "SRR19508265"
  "SRR19508266"
  "SRR19508282"
  "SRR19508283"
  "SRR19508290"
  "SRR19508291"
  "SRR19508300"
  "SRR19508463"
  "SRR19508464"
  "SRR19508465"
  "SRR19508466"
  "SRR19508467"
  "SRR19508468"
  "SRR19508469"
  "SRR19508472"
  "SRR19508480"
  "SRR19508496"
  "SRR6251350"
  "SRR6251351"
  "SRR6251352"
  "SRR6251353"
  "SRR6251354"
  "SRR6251355"
  "SRR6251356"
  "SRR6251357"
  "SRR6251358"
  "SRR6251359"
  "SRR6251360"
  "SRR6251361"
  "SRR6251362"
  "SRR6251363"
  "SRR6251364"
  "SRR6251365"
  "SRR6251366"
  "SRR6251367"
  "SRR7062760"
  "SRR7062761"
  "SRR7062762"
  "SRR7062763"
)

READDIR="/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/betta-raw/"
ILLUMINACLIP="/tarafs/data/home/hrasoara/proj5057-AGBKUB/ryan/conda-envs/trimmomatic/share/trimmomatic-0.39-2/adapters/TruSeq3-PE.fa"
mkdir -p data/trimmed_reads
for genome in "${genomes[@]}"; do
  echo "Trimming $genome"
  trimmomatic PE -threads 96 -phred33 "${READDIR}/${genome}_1.fastq" "${READDIR}/${genome}_2.fastq" \
    data/trimmed_reads/${genome}_1.trimmed.fq.gz data/trimmed_reads/${genome}_1.unpaired.fq.gz \
    data/trimmed_reads/${genome}_2.trimmed.fq.gz data/trimmed_reads/${genome}_2.unpaired.fq.gz \
    ILLUMINACLIP:${ILLUMINACLIP}:2:30:10 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:100
done
