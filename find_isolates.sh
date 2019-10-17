#!/bin/bash
#usage bash find_isolates.sh <muscle exe path> <hmmbuild exe path> <hmmsearch exe path> <name for hsp results> <name for mcrA results>

#warn user of upcoming deleting files
echo "WARNING this program  will delete any files named "hsp70gene_combined.fasta", "mcrAgene_combined.fasta", and "proteome_combined.fasta" continue? (yes/no)"
read bool_continue

echo "Would you like the muscle alignment file saved? (yes/no)"
read keep_musc

echo "Would you like the hmmbuild file saved? (yes/no)"
read keep_hmmbuild



#switch statement based on user input
case $bool_continue in
	yes)
		#rm any combined files that already exist
		rm ./ref_sequences/hsp70gene_combined.fasta
		rm ./ref_sequences/mcrAgene_combined.fasta
		rm ./proteomes/proteome_combined.fasta

		#combine the reference sequences and proteome genome
		for file in ./ref_sequences/hsp70gene_??.fasta
		do
		cat $file >> ./ref_sequences/hsp70gene_combined.fasta
		done

		for file in ./ref_sequences/mcrAgene_??.fasta
		do
		cat $file >> ./ref_sequences/mcrAgene_combined.fasta
		done

		for file in ./proteomes/proteome_??.fasta
		do
		cat $file >> ./proteomes/proteome_combined.fasta
		done

		#allign the combined reference sequences with muscle
		$1 -in ./ref_sequences/hsp70gene_combined.fasta -out hsp70gene.musc
		$1 -in ./ref_sequences/mcrAgene_combined.fasta -out mcrAgene.musc

		#build a hmmr profile based on the previous muscle allignment
		$2 hsp70gene.hmm hsp70gene.musc
		$2 mcrAgene.hmm mcrAgene.musc 

		#search for the combined proteome sequences in the hmmr profile
		$3 -o $4 hsp70gene.hmm ./proteomes/proteome_combined.fasta
		$3 -o $5 mcrAgene.hmm ./proteomes/proteome_combined.fasta 

		#report results location
		printf "Assuming hmmr and muscle executed you can find your results in this directory in files $4 and $5\n"
	;;
	no)
	exit
	;;
esac

case $keep_musc in
	no)
		rm hsp70gene.musc
		rm mcrAgene.musc
	;;
	yes)
		printf "The muscle files are in this directory and called: \n hsp70gene.musc \n mcrAgene.musc"
	;;
		
esac

case $keep_hmmbuild in
	no)
		rm hsp70gene.hmm
		rm mcrAgene.hmm
	;;
	yes)
		printf "\nThe hmmbuild files are in this directory and called: \n hsp70gene.hmm \n mcrAgene.hmm \n"
	;;
esac


