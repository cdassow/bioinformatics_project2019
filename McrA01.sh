#Usage: bash McrA01.sh ~/Private/bin/muscle3.8.31_i86linux32 ~/Private/bin/bin/hmmbuild ~/Private/bin/bin/hmmsearch ~/Private/bioinformatics_project2019/ref_sequences/mcrA*.fasta  mcrA.afa mcrA.hmm 01
#Where "$2" "$3" and "$4" are the pathways to muscle and hmmer respectively in your system
#For counting the number of McrA genes in proteome_"$7".fasta files
muscle="$1"
hmmbuild="$2"
hmmsearch="$3"
echo "$4"
cat "$4" > mcrAall.fasta
$muscle -in mcrAall.fasta -out "$5"
$hmmbuild "$6" "$5"
for $NEW in ~/Private/bioinformatics_project2019/proteomes/proteome_"$7".fasta
do
$hmmsearch --tblout mcrAsearch"$7" "$6" $NEW
done
