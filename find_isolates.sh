#!/bin/bash
#usage bash find_isolates.sh <muscle exe path> <hmmbuild exe path> <hmmsearch exe path> <name for hsp results> <name for mcrA results>

#warn user of upcoming deleting files
echo "WARNING this program  will overwrite any files named "hsp70gene_combined.fasta", "mcrAgene_combined.fasta", and "final_results.txt" continue? (yes/no)"
read bool_continue

#switch statement based on user input
case $bool_continue in
	yes)
		#rm any combined files that already exist
		rm ./ref_sequences/hsp70gene_combined.fasta
		rm ./ref_sequences/mcrAgene_combined.fasta

		#combine the reference sequences and proteome genome
		for file in ./ref_sequences/hsp70gene_??.fasta
		do
		cat $file >> ./ref_sequences/hsp70gene_combined.fasta
		done

		for file in ./ref_sequences/mcrAgene_??.fasta
		do
		cat $file >> ./ref_sequences/mcrAgene_combined.fasta
		done


		#allign the combined reference sequences with muscle
		$1 -in ./ref_sequences/hsp70gene_combined.fasta -out hsp70gene.musc
		$1 -in ./ref_sequences/mcrAgene_combined.fasta -out mcrAgene.musc

		#build a hmmr profile based on the previous muscle allignment
		$2 hsp70gene.hmm hsp70gene.musc
		$2 mcrAgene.hmm mcrAgene.musc 

		#loops to search the genes for matches in each proteome
		for file in ./proteomes/proteome_??.fasta
			do
			$3 --tblout $file"_hsp70_table"  hsp70gene.hmm $file
			done

		for file in ./proteomes/proteome_??.fasta
			do
			$3 --tblout $file"_mcrA_table"  mcrAgene.hmm $file
			done

			
		
		#search for the combined proteome sequences in the hmmr profile
		$3 -o $4 hsp70gene.hmm ./proteomes/proteome_combined.fasta
		$3 -o $5 mcrAgene.hmm ./proteomes/proteome_combined.fasta 

		#loop to count unique match in hsp70 table file and save count to array
		i=0
		for file in ./proteomes/*hsp70_table
			do
			hsp_count=$(cat $file | grep -v \# | uniq | wc -l)
			hsp70_array[i]=$hsp_count
			i=$i+1
			done

		#loop to count unique matches in mcrA table files and save count to array
		j=0
		for file in ./proteomes/*mcrA_table
			do
			mcrA_count=$(cat $file | grep -v \# | uniq | wc -l)
			mcrA_array[j]=$mcrA_count
			j=$j+1
			done

		#report results location
		rm final_results.txt
		echo "                 hsp70    mcrA"> final_results.txt
                for num in {1..50}
                        do
                        echo ""Proteome$(printf "%03d" "$num")"        ${hsp70_array[($num-1)]}        ${mcrA_array[($num-1)]}" >> final_results.txt
                        done
			

		
		#inform user of status of saved files
		printf "\n \n \n \n \n \n \n"
		printf "Assuming hmmr and muscle executed you can find your results in this directory in files final_results.txt \n"
	;;
	no)
	exit
	;;
esac

#Adding user options to save certain files
echo "Would you like the muscle alignment file saved? (yes/no)"
read keep_musc

echo "Would you like the hmmbuild file saved? (yes/no)"
read keep_hmmbuild

echo "Would you like the individual results tables saved in /proteomes?"
read keep_tables

#case staements to keep or rm the files
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

case $keep_tables in
	no)
		rm ./proteomes/*_table
	;;
	yes)
		printf "\nThe individual results tables in the /proteomes child directory"
	;;
esac
