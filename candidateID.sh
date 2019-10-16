#Identifying a candidate pH-resistant methanogenic Archaea; there are 50 candidates,
#in proteomes directory how many HSP70, binary do they have/not have mcrA
#USAGE bash candidateID.sh

#align sequences and build HMM
cat ./ref_sequences/mcrAgene_*.fasta | ../muscle -out alignedmcrA.fast
 ../hmmer3/bin/hmmbuild mcrA.hmm alignedmcrA.fasta
cat ./ref_sequences/hsp70gene_*.fasta | ../muscle -out alignedhsp70.fasta
 ../hmmer3/bin/hmmbuild hsp70.hmm alignedhsp70.fasta

#search through proteomes to find matches using HMM and sort to find best matches
echo mcrA
for file in ./proteomes/proteome*.fasta
 do 
 echo $file:
 ../hmmer3/bin/hmmsearch mcrA.hmm $file | grep -E "Domain search space" | tr "\n" " "
  done
# | sort -t ":" -k2 -b -r | head -n 5

echo hsp70
for file in ./proteomes/proteome*.fasta
 do
 echo $file:
 ../hmmer3/bin/hmmsearch hsp70.hmm $file | grep -E "Domain search space" | tr "\n" " "
 done
 #| sort -t ":" -k2 -b -r | head -n 5
