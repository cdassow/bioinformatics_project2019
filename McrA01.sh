#Usage: bash McrA01.sh ~/Private/bin/muscle3.8.31_i86linux32 ~/Private/bin/bin/hmmbuild ~/Private/bin/bin/hmmsearch mcrA.afa mcrA.hmm 01
#Where "$2" "$3" and "$4" are the pathways to muscle and hmmer respectively in your system
#For counting the number of McrA genes in proteome_"$7".fasta files
muscle="$1"
hmmbuild="$2"
hmmsearch="$3"
#cat ~/Private/bioinformatics_project2019/ref_sequences/mcrAgene_*.fasta > mcrA.fasta
$muscle -in mcrA.fasta -out "$4"
$hmmbuild "$5" "$4"
for NEW in ~/Private/bioinformatics_project2019/proteomes/proteome_"$6".fasta
do
$hmmsearch --tblout mcrAsearch"$6" "$5" $NEW
done
