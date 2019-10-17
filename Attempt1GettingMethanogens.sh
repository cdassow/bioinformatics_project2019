#cat ./ref_sequences/m*.fasta >> compiledMethaneGenes.fasta
#cat ./ref_sequences/hsp*.fasta >> compiledpHGenes.fasta

#../muscle -in compiledMethaneGenes.fasta -out alignedMethaneGenes.txt
#../muscle -in compiledpHGenes.fasta -out alignedpHGenes.txt

#../hmmer-3.2.1/bin/hmmbuild methane.hmm alignedMethaneGenes.txt
#../hmmer-3.2.1/bin/hmmbuild pH.hmm alignedpHGenes.txt

# Makes column titles in table
echo "Proteome Number, mcrA Gene, pH Gene" > ResultsWayho.txt

#HERE IS WHERE GOOD STUFF STARTS

for number in {01..50}
do
	# Searches proteomes for methane gene
	../hmmer-3.2.1/bin/hmmsearch --tblout proteome_match$number.txt  methane.hmm ./proteomes/proteome_$number.fasta

	#creates a variable for mcrA presence where 0 = no presence and 1 = a presence
	mcrA=$(cat proteome_match$number.txt | grep -v '#' -m 1 | wc -l)

	# Searches proteomes for pH gene and saves number of matches for each proteome to HSP70
  	../hmmer-3.2.1/bin/hmmsearch --tblout proteome_pHmatch$number.txt  pH.hmm ./proteomes/proteome_$number.fasta
	HSP70=$(cat proteome_pHmatch$number.txt | grep -v '#' | tr -s ' ' '\t' | cut -f 19,20,21,22,23,24,25,26,27,28,29,30  | sort -u | wc -l)
	
	# Here is how we'll get the results into the final table file
	echo "$number, $mcrA, $HSP70" >> ResultsWayho.txt
done


