#Identifying a candidate pH-resistant methanogenic Archaea; there are 50 candidates,
#in proteomes directory how many HSP70, binary do they have/not have mcrA
#USAGE bash candidateID.sh relative_pathway_to_gene1 [./ref_sequences/mcrAgene_*.fasta] relative_pathway_to_gene2 [./ref_sequences/hsp70gene_*.fasta] relative_pathway_to_proteomes [./proteomes/proteome*.fasta]

#align sequences and build HMM
cat "$1" | ../muscle -out alignedmcrA.fasta
 ../hmmer3/bin/hmmbuild mcrA.hmm alignedmcrA.fasta
cat "$2" | ../muscle -out alignedhsp70.fasta
 ../hmmer3/bin/hmmbuild hsp70.hmm alignedhsp70.fasta

#search through proteomes to find matches using HMM and sort to find best matches
for file in "$3"
 do
 shortFile=$(echo $file | cut -d '/' -f 3 | cut -d '.' -f 1)
 result=$(../hmmer3/bin/hmmsearch mcrA.hmm $file | grep -E "Domain search space" | tr "\n" " " | cut -d : -f 2 | cut -d '[' -f 1)
 echo $shortFile : $result >> mrca.txt
 done

for file in ./proteomes/proteome*.fasta
 do
 shortFile1=$(echo $file | cut -d '/' -f 3 | cut -d '.' -f 1)
 result1=$(../hmmer3/bin/hmmsearch hsp70.hmm $file | grep -E "Domain search space" | tr "\n" " " | cut -d : -f 2 | cut -d '[' -f 1)
 echo $shortFile1 : $result1 >> hsp70.txt
 done

#table refinement, shows best candidates - have mcrA and highest amounts of hsp70
paste -d ":" mrca.txt hsp70.txt > table.txt
cat table.txt | cut -d : -f 1,2,4 | sort -k2 -r | sort -k3 -r > candidateRanking.txt
cat candidateRanking.txt
