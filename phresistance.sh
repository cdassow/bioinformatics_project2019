#This program searches fasta files for the presence of mcrA and hsp70 genes to indicate the presence of methanogens
#usage: bash phresistance.sh 'ref_sequences/mcrAgene_*.fasta' 'ref_sequences/hsp70gene_*.fasta' './proteomes/proteome_*.fasta'

#combine mcrA reference sequences into one file
cat $1 > mcraref.fasta

#align file of mcrA reference sequences using muscle
./programs/muscle -in "mcraref.fasta" -out "mcramuscle.fasta"

#form hidden markov model from muscle alignment
./programs/hmmbuild --amino "mcrabuild.hmm" "mcramuscle.fasta"

#search in each proteome for mcrA matches
for proteome in $3
do
processedfile=$(echo $proteome | sed 's/.fasta//g')
./programs/hmmsearch mcrabuild.hmm $proteome > $processedfile"mcra".txt
done


#combine hsp70 reference sequences into one file
cat $2 > hspref.fasta

#align file of hsp70 reference sequences using muscle
./programs/muscle -in "hspref.fasta" -out "hspmuscle.fasta"

#form hidden markov model from muscle alignment
./programs/hmmbuild --amino "hsp70build.hmm" "hspmuscle.fasta"

#search in each proteome for hsp70 matches
for proteome in $3
do
processedfile=$(echo $proteome | sed 's/.fasta//g')
./programs/hmmsearch hsp70build.hmm $proteome > $processedfile"hsp70".txt
done


#thoughts for table: hsp-in the reference files, chaperone dnak is the only one that appears, so count the number of those in each hsp file for proteomes
#chaperone dnak is written twice, so could do grep "-" | grep "molecular chaperone DnaK"


#must use uniq to get rid of duplicates
# var1=(proteome_$@hsp70.txt | grep -w ">>" | cut -d " " -f 2 | wc -l >> proteome_$@hsp70_number.txt)
# var2=(proteome_$@mcra.txt | grep -w ">>" | cut -d " " -f 2 | wc -1 >> )

# echo 

