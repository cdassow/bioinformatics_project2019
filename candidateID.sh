#Identifying a candidate pH-resistant methanogenic Archaea
#there are 50 candidates, in proteomes directory
#how many HSP70, binary do they have/not have mcrA

cat ./ref_sequences/hsp70gene_*.fasta | ../muscle | ../hmmr3/bin/hmmbuild | ../hmmer3/hmmsearch
cat ./ref_sequences/mcrAgene_*.fasta | ../muscle -out mcrAalign ../hmmr3/bin/hmmbuild| ../hmmer3/hmmsearch


#put ref_sequences together??
#align reference sequences muscle -in FILENAME -out OUTPUT_FILE
#hmmbuild (alignment in --> hidden markov model out)
#hmmsearch (to find matches)


#for loop with grep, regex
#does proteome__.fasta have mcrA gene
#how many HSP70 does proteome__fasta have?
