#Identifying a candidate pH-resistant methanogenic Archaea; there are 50 candidates,
#in proteomes directory how many HSP70, binary do they have/not have mcrA
#USAGE bash candidateID.sh ./proteomes/proteome_*.fasta
for proteome in "$1"
	do
	echo $proteome
	cat ./ref_sequences/mcrAgene_*.fasta | ../muscle | ../hmmr3/bin/hmmbuild | ../hmmer3/hmmsearch $proteome >> mcrA.txt
	cat ./ref_sequences/hsp70gene_*.fasta | ../muscle | ../hmmr3/bin/hmmbuild | ../hmmer3/hmmsearch $proteome >> hsp70.txt
	done

#does proteome__.fasta have mcrA gene
#how many HSP70 does proteome__fasta have?
