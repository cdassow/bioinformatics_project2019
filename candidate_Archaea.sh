#to properly run this script, be in the bioinformatics_project 2019 directory (code includes relative and absolute paths)
#concatenates all mcrA fasta files into a large file, to run through muscle
for file in ref_sequences/mcrAgene*.fasta
do
cat $file > mcrAtotal.fasta

#muscle the output file from the step above
./muscle -in mcrAtotal.fasta -out mtotal_align.fasta

#absolute path for hmmbuild
/afs/crc.nd.edu/user/r/rcrisman/Private/hmmer-3.2.1/bin/hmmbuild mbuild.fasta mtotal_align.fasta

#run hmmsearch, replace .fasta extension with .out extension
for file in proteomes/proteome_*.fasta
do
hmmsearch_file=$(echo $file | sed 's/.fasta/.out/')
/afs/crc.nd.edu/user/r/rcrisman/Private/hmmer-3.2.1/bin/hmmsearch --tblout $hmmsearch_file mbuild.fasta $file

#repeat the above for Hsp70
for file in ref_sequences/hsp70gene_*.fasta
do
cat $file > hsp70total.fasta
done

#muscle the output file
./muscle -in hsp70total.fasta -out htotal_align.fasta

#absolute path for hmmbuild
/afs/crc.nd.edu/user/r/rcrisman/Private/hmmer-3.2.1/bin/hmmbuild hbuild.fasta htotal_align.fasta

#run hmmsearch, replace .fasta extension with .out extension
for file in proteomes/proteome_*.fasta
do
hmmsearch_file=$(echo $file | sed 's/.fasta/.out2/')
/afs/crc.nd.edu/user/r/rcrisman/Private/hmmer-3.2.1/bin/hmmsearch --tblout $hmmsearch_file hbuild.fasta $file

#produce a csv file with mcrA matches
for file in proteomes/proteome_*.out
do
mcrA=$(cat $file | grep -v "#" | wc -l)
echo "$file, $mcrA" >> mcrAfinal.csv

#produce a csv file with hsp70 matches
for file in proteomes/proteome_*.out2
do
hsp70=$(cat $file | grep -v "#" | wc -l)
echo "$hsp70" >> hsp70final1.csv

#append the two csv files
paste -d'\t' mcrAfinal.csv hsp70final1.csv > mcrA_hsp70.csv


