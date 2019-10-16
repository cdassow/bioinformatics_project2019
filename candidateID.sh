#Identifying a candidate pH-resistant methanogenic Archaea; there are 50 candidates,
#in proteomes directory how many HSP70, binary do they have/not have mcrA
#USAGE bash candidateID.sh

cat ./ref_sequences/mcrAgene_*.fasta | ../muscle -out alignedmcrA.fast
 ../hmmer3/bin/hmmbuild mcrA.hmm alignedmcrA.fasta
cat ./ref_sequences/hsp70gene_*.fasta | ../muscle -out alignedhsp70.fasta
 ../hmmer3/bin/hmmbuild hsp70.hmm alignedhsp70.fasta

for file in ./proteomes/proteome*.fasta; do ../hmmer3/bin/hmmsearch mcrA.hmm $file; done

for file in ./proteomes/proteome*.fasta; do ../hmmer3/bin/hmmsearch hsp70.hmm $file; done
