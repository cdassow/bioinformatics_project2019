
#cat ./ref_sequences/m*.fasta >> compiledMethaneGenes.fasta
#cat ./ref_sequences/hsp*.fasta >> compiledpHGenes.fasta

#../muscle -in compiledMethaneGenes.fasta -out alignedMethaneGenes.txt
#../muscle -in compiledpHGenes.fasta -out alignedpHGenes.txt

#../hmmer-3.2.1/bin/hmmbuild methane.hmm alignedMethaneGenes.txt
#../hmmer-3.2.1/bin/hmmbuild pH.hmm alignedpHGenes.txt

# Makes column titles in table
echo "Proteome Number, mcrA Gene, pH Gene" > ResultsWayho.txt

#MOVED THIS DOWN INTO BIG FORLOOP Searches the proteomes for the methane gene
#for number in {01..50}
#do
#	../hmmer-3.2.1/bin/hmmsearch --tblout proteome_match$number.txt  methane.hmm ./proteomes/proteome_$number.fasta
#done


# Looks at methane matching results. Non matches have 13 lines, so we grep and get the proteome number for the hmmsearch files that have more than
# 13 lines. These proteome numbers are for the methanogens.
for number in {01..50}
do

	cat proteome_match$number.txt | wc -l >> proteomeLineCount$number.txt
done


 grep -v -l '13' proteomeLineCount*.txt | tr -d proeteomeLineCount | tr -d .txt


#HERE IS WHERE GOOD STUFF STARTS

for number in {01..50}
do
	# Gets numbers of proteomes out of files
	name=$(echo proteome_$number.fasta | tr -d proteome_ | tr -d .fasta)

	# Searches proteomes for methane gene
	../hmmer-3.2.1/bin/hmmsearch --tblout proteome_match$number.txt  methane.hmm ./proteomes/proteome_$number.fasta

	# Some how here we need to determine if there are 13 lines and assign those proteomes a value of 0, and if there are not 13 lines assign those
	# proteomes a value of 1. We will save these values to the variable $mcrA

	# Searches proteomes for pH gene and saves number of matches for each proteome to HSP70
  	../hmmer-3.2.1/bin/hmmsearch --tblout proteome_pHmatch$number.txt  pH.hmm ./proteomes/proteome_$number.fasta
	HSP70=$(cat proteome_pHmatch$number.txt | grep -E -c 'WP')

	# Here is how we'll get the results into the final table file
	echo "$name,$mcrA,$HSP70">> ResultsWayho.txt
done


