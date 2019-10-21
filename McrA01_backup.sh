#Usage: bash McrA01.sh ~/Private/bin/muscle3.8.31_i86linux32 ~/Private/bin/bin/hmmbuild ~/Private/bin/bin/hmmsearch mcrA.afa mcrA.hmm hsp.afa hsp.hmm
#Where "$1" "$2" and "$3" are the pathways to muscle and hmmer respectively in your system
#For counting the number of McrA genes in proteome*.fasta files
muscle="$1"
hmmbuild="$2"
hmmsearch="$3"
#cat ~/Private/bioinformatics_project2019/ref_sequences/mcrAgene_*.fasta > mcrA.fasta
$muscle -in mcrA.fasta -out "$4"
$hmmbuild "$5" "$4"
#iterates over all 50 proteomes and makes 50 mcrA alignment tables
for i in {01..50}
do
$hmmsearch --tblout mcrAtable$i "$5" ~/Private/bioinformatics_project2019/proteomes/proteome_$i.fasta
done
#iterates over all 50 proteomes and makes 50 mcrA alignment tables
#can still use $4 and $5; doesn't matter if mcrA HMM builds overwritten as mcrA tables already exist
$muscle -in hsp70.fasta -out "$4"
$hmmbuild "$5" "$4"
for i in {01..50}
do
$hmmsearch --tblout hsp70table$i "$5" ~/Private/bioinformatics_project2019/proteomes/proteome_$i.fasta
done
#creating table has several steps
#1. create headers in int.txt, including gaps for clarity
#2. iterate over all 50 tables for both genes; use -v hash for only keeping lines that are hits
#3. echo the number of hits as "number copies" into int.txt via appending iterated over the 50 tables for each gene
#4. copy all hits of >0 gene copies into analysis.txt
echo "Proteome   mcrA hits  hsp70 hits" > int.txt
echo " " >> int.txt
for i in {01..50}
do
hsp70hit=$(grep -v '#' hsp70table$i | wc -l)
mcrAhit=$(grep -v '#' mcrAtable$i | wc -l)
echo "Proteome$i $mcrAhit copies $hsp70hit copies" >> int.txt
done

grep -E -v "0 copies" int.txt  >> analysis.txt
#The more gene copies, the better the proteome is to analyze
