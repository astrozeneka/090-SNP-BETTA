#!/bin/bash
#SBATCH -p memory
#SBATCH -N 1 -c 96
#SBATCH -t 48:00:00
#SBATCH -J canu
#SBATCH -A proj5034

module purge
module load canu/1.9-GCCcore-8.3.0-Java-11

genome=$1
if [ -z "$genome" ]; then
  echo "Usage: $0 <genome>"
  exit 1
fi

READDIR="/tarafs/data/home/hrasoara/scratch/betta-smrt" # pac bio smrt reads

mkdir -p "data/canu"
canu -p $genome -d "data/canu/$genome" genomeSize=443m -pacbio-raw "${READDIR}/${genome}.fastq"
echo "CANU done"