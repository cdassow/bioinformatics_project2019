#cat ./ref_sequences/m*.fasta >> compiledMethaneGenes.fasta

#cat ./ref_sequences/hsp*.fasta >> compiledpHGenes.fasta



#../muscle -in compiledMethaneGenes.fasta -out alignedMethaneGenes.txt

#../muscle -in compiledpHGenes.fasta -out alignedpHGenes.txt



#../hmmer-3.2.1/bin/hmmbuild methane.hmm alignedMethaneGenes.txt

#../hmmer-3.2.1/bin/hmmbuild pH.hmm alignedpHGenes.txt



# Searches the proteomes for the methane gene

for number in {01..50}

do

  	../hmmer-3.2.1/bin/hmmsearch --tblout proteome_match$number.txt  methane.hmm ./proteomes/proteome_$number.fasta

done





# Looks	at methane matching results. Non matches have 13 lines,	so we grep and get the proteome	number for the hmmsearch files that have more than   

# 13 lines. These proteome numbers are for the methanogens.

for number in {01..50}

do

  	cat proteome_match$number.txt | wc -l >> proteomeLineCount$number.txt

done



grep -v -l '13' proteomeLineCount*.txt | tr -d proeteomeLineCount | tr -d .txt > MethaneProteomeNumbers.txt





# We are trying	to pull	the proteome numbers out of the	file to	call those specific fasta files	into the hmmsearch for pH stuff, but this is not

# working

i=$(cat MethaneProteomeNumbers.txt | wc -l)



for number in {1..$i}

        a=$(cat MethaneProteomeNumbers.txt | head -n $number | tail -n 1)

        ../hmmer-3.2.1/bin/hmmsearch --tblout proteome_pHmatch$number.txt  pH.hmm ./proteomes/proteome_$a.fasta

done#cat ./ref_sequences/m*.fasta >> compiledMethaneGenes.fasta

#cat ./ref_sequences/hsp*.fasta >> compiledpHGenes.fasta



#../muscle -in compiledMethaneGenes.fasta -out alignedMethaneGenes.txt

#../muscle -in compiledpHGenes.fasta -out alignedpHGenes.txt



#../hmmer-3.2.1/bin/hmmbuild methane.hmm alignedMethaneGenes.txt

#../hmmer-3.2.1/bin/hmmbuild pH.hmm alignedpHGenes.txt



# Searches the proteomes for the methane gene

for number in {01..50}

do

  	../hmmer-3.2.1/bin/hmmsearch --tblout proteome_match$number.txt  methane.hmm ./proteomes/proteome_$number.fasta

done





# Looks	at methane matching results. Non matches have 13 lines,	so we grep and get the proteome	number for the hmmsearch files that have more than   

# 13 lines. These proteome numbers are for the methanogens.

for number in {01..50}

do

  	cat proteome_match$number.txt | wc -l >> proteomeLineCount$number.txt

done



grep -v -l '13' proteomeLineCount*.txt | tr -d proeteomeLineCount | tr -d .txt > MethaneProteomeNumbers.txt





# We are trying	to pull	the proteome numbers out of the	file to	call those specific fasta files	into the hmmsearch for pH stuff, but this is not

# working

i=$(cat MethaneProteomeNumbers.txt | wc -l)



for number in {1..$i}

        a=$(cat MethaneProteomeNumbers.txt | head -n $number | tail -n 1)

        ../hmmer-3.2.1/bin/hmmsearch --tblout proteome_pHmatch$number.txt  pH.hmm ./proteomes/proteome_$a.fasta

done
