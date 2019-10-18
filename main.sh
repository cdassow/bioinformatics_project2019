#!/bin/sh 

# firstly, got software installed and created a folder-metadata

# create combined ref sequence files of mcrA gene and HSP70 gene
cat ref_sequences/hsp* > metadata/hsp_ref.fasta
cat ref_sequences/mcrA* > metadata/mcrA_ref.fasta

# align two ref sequence
./tools/muscle -in metadata/hsp_ref.fasta -out metadata/hsp_ref.afa
./tools/muscle -in metadata/mcrA_ref.fasta -out metadata/mcrA_ref.afa

# build a profile HMM
./tools/hmmbuild metadata/hsp.hmm metadata/hsp_ref.afa
./tools/hmmbuild metadata/mcra.hmm metadata/mcrA_ref.afa

# sequence search with hmmsearch on mcrA 
for file in proteomes/prot*.fasta
do
	resultname=$(echo $file | sed 's/proteomes/metadata/' | sed 's/.fasta/_mcra.rslt/')
	./tools/hmmsearch metadata/mcra.hmm $file > $resultname
done

# make statistics whether genomes names that have hits, 1 for no hits, 0 for hits
echo "proteomes, no hits" > stat_proteomes.csv
for file in metadata/prot*mcra.rslt
do
	hits=$(grep 'No hits detected' $file | wc -l)
	ori_file=$(echo $file | sed 's/metadata/proteomes/' | sed 's/_mcra.rslt/.fasta/')
	stat="$ori_file,$hits"
	echo $stat >> stat_proteomes.csv
done

# get proteomes that have hits
cat stat_proteomes.csv | grep ", 0" | cut -d , -f 1 > hits_proteomes.csv

# sequence search with hmmsearch on hsp70
for file in proteomes/prot*.fasta
do
	resultname=$(echo $file | sed 's/proteomes/metadata/' | sed 's/fasta/_hsp.rslt/')
	./tools/hmmsearch metadata/hsp.hmm $file > $resultname
done

# make statistics on the number of hsp70 hits






