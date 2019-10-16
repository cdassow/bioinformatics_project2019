#Identifying a candidate pH-resistant methanogenic Archaea; there are 50 candidates,
#in proteomes directory how many HSP70, binary do they have/not have mcrA
#USAGE bash candidateID.sh ./proteomes/proteome_*.fasta

cat ./ref_sequences/mcrAgene_*.fasta | ../muscle -out alignedmcrA.fasta
 ../hmmer3/bin/hmmbuild mcrA.hmm alignedmcrA.fasta
cat ./ref_sequences/hsp70gene_*.fasta | ../muscle -out alignedhsp70.fasta
 ../hmmer3/bin/hmmbuild hsp70.hmm alignedhsp70.fasta

for file in "$1"
	do 
	../hmmer3/bin/hmmsearch mcrA.hmm $file
	done
for file in "$1"                         
        do
        ../hmmer3/bin/hmmsearch hsp70.hmm $file      
        done

#does proteome__.fasta have mcrA gene
#how many HSP70 does proteome__fasta have?
