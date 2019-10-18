# Makes file titled ResultsWayho.txt with proteome number, whether it matches mcrA gene or not (0/1), and number of unique HSP70 gene matches
# Also makes a file titled CandidateProteomes.txt with the candidate pH resistant methanogens (if the methanogen has at least one HSP70 gene match)

# Usage: bash MethanepHProteomes.sh

# Combines all of the reference files for each gene
cat ./ref_sequences/m*.fasta >> compiledMethaneGenes.fasta
cat ./ref_sequences/hsp*.fasta >> compiledpHGenes.fasta

# Aligns the reference files using muscle
../muscle -in compiledMethaneGenes.fasta -out alignedMethaneGenes.txt
../muscle -in compiledpHGenes.fasta -out alignedpHGenes.txt

# Makes hmm profiles of the aligned files
../hmmer-3.2.1/bin/hmmbuild methane.hmm alignedMethaneGenes.txt
../hmmer-3.2.1/bin/hmmbuild pH.hmm alignedpHGenes.txt

# Makes column titles in table
echo "Proteome Number, mcrA Gene, pH Gene" > ResultsWayho.txt

#HERE IS WHERE GOOD STUFF STARTS

for number in {01..50}
do
	# Searches proteomes for methane gene
	../hmmer-3.2.1/bin/hmmsearch --tblout proteome_match$number.txt  methane.hmm ./proteomes/proteome_$number.fasta

	# Creates a variable for mcrA presence where 0 = no presence and 1 = a presence
	mcrA=$(cat proteome_match$number.txt | grep -v '#' -m 1 | wc -l)

	# Searches proteomes for pH gene and saves number of ~unique~ matches for each proteome
  	../hmmer-3.2.1/bin/hmmsearch --tblout proteome_pHmatch$number.txt  pH.hmm ./proteomes/proteome_$number.fasta
	HSP70=$(cat proteome_pHmatch$number.txt | grep -v '#' | tr -s ' ' '\t' | cut -f 19-30  | sort -u | wc -l)
	
	# Puts results into table
	echo "$number, $mcrA, $HSP70" >> ResultsWayho.txt
done


# Makes file of the names of the candidate pH resistant methanogens
cat ResultsWayho.txt | grep -v ' 0' | cut -d ',' -f 1 > CandidateProteomes.txt

rm proteome_match*.txt
rm proteome_pHmatch*.txt
