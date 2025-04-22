#!/bin/bash
#SBATCH --job-name=runNF
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -c 12
#SBATCH --mem=15G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=first.last@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date

module load nextflow/24.10.5

OUTDIR=../../results/nfcoreRNAseq
mkdir -p ${OUTDIR}

cd ${OUTDIR}

SAMPLESHEET=../../metadata/samplesheet.csv
GENOME=../../genome/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.dna_sm.toplevel.fa
GTF=../../genome/Fundulus_heteroclitus.Fundulus_heteroclitus-3.0.2.112.gtf

# use xanadu profile from: https://nf-co.re/configs/xanadu/
nextflow run nf-core/rnaseq \
    --input ${SAMPLESHEET} \
    --outdir out \
    --fasta ${GENOME} \
    --gtf ${GTF} \
    -profile xanadu \
    -with-trace \
    -with-report \
    -with-timeline \
    -with-dag dag.png