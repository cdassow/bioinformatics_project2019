#This is the bash file that will tell Dr. Jones' grad student which isolate to use
#Assumption: always in bioinformatics_project2019 directory
#Assumption: tools (hmmer and muscle) in bioinformatics_project2019 directory


#Convert all reference sequence files to single .fasta for both genes
#use muscle to align sequences for two genes separately 
cat ./ref_sequences/mcrAgene_*.fasta > MCRA_combo.fasta
./muscle -in MCRA_combo.fasta -out MCRA.msa
cat ./ref_sequences/hsp70gene_*.fasta > hsp70_combo.fasta
./muscle -in hsp70_combo.fasta -out hsp70.msa


#build hmmer profiles for hsp70 and mcrA genes
./hmmbuild hsp70.hmm hsp70.msa
./hmmbuild mcrA.hmm mcrA.msa


#use hmmsearch to search the proteome genomes for the presence of mcrA sequence, based on hmmer profile created previously
#output goes to .tbl form for ease of further operation
for sample in proteomes/proteome*.fasta
do
tblname=$(echo $sample | sed 's/.fasta/mcrA/')
./hmmsearch --tblout $tblname.tbl mcrA.hmm $sample
done


#mcrA tables for each proteome have their line count measured and a list is created of the proteomes and their respective line counts
for table in proteomes/proteome_*mcrA.tbl
do
echo "$table $(cat $table | wc -l)" >> mcrAcount.txt
done


#13 lines (each standing for one proteome) are found to indicate the lack of mcrA gene, and we have no need for those proteomes; proteomes with mcrA are moved to another list
cat mcrAcount.txt | grep -v "13" > mcrAhits.txt
cat mcrAhits.txt | cut -d " " -f 1 | sed 's/mcrA.tbl/.fasta/' > onestosearch.txt


#proteomes in the new file (with mcrA) are then used in hmmsearch in order to determine how many hsp70 sequences they contain; again, output is in .tbl form
for sample in $(cat onestosearch.txt )
do
tblname=$(echo $sample | sed 's/.fasta/hsp70/')
./hmmsearch --tblout $tblname.tbl hsp70.hmm $sample
done


#similarly to how it was done above, a new list of proteomes is created wherein each proteome is accompanied by its line count (more lines indicated more hsp70s)
for file in proteomes/proteome_*hsp70.tbl
do
echo "$file $(cat $file | wc -l)" >> candidatelist.txt
done


#candidatelist.txt is sorted in reverse order so as to put the file with the greatest number of lines (i.e. most copies of hsp70 gene) at the top of the list
#FINALLIST.txt contains isolates in descending order of the best candidates for further experimentation by Dr. Jones' grad student
echo "The best isolates to move forward with are:" > FINALLIST.txt
cat candidatelist.txt | sort -k2 -r | cut -d " " -f 1 | sed 's/proteomes\///' | sed 's/hsp70.tbl//' >> FINALLIST.txt
