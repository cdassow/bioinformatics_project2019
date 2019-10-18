#!/bin/sh 

# firstly, got software installed and created a folder-metadata

# create combined ref sequence files of mcrA gene and HSP70 gene
cat ref_sequences/hsp* > metadata/hsp_ref.fasta
cat ref_sequences/mcrA* > metadata/mcrA_ref.fasta

# align two ref sequence
./tools/muscle -in metadata/hsp_ref.fasta -out metadata/hsp_ref.afa
./tools/muscle -in metadata/mcrA_ref.fasta -out metadata/mcrA_ref.afa

