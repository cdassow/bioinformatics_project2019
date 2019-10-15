#This is the .sh file we shall use together to make a nice happy script
#Assumption: always in bioinformatics_project2019 directory
#Assumption: tools in bioinformatics_project2019 directory
#Convert all reference sequence files to single .fasta for both genes
#use muscle to align sequences for two genes separately 

cat ./ref_sequences/mcrAgene_*.fasta > MCRA_combo.fasta
./muscle -in MCRA_combo.fasta -out MCRA.msa
cat ./ref_sequences/hsp70gene_*.fasta > hsp70_combo.fasta
./muscle -in hsp70_combo.fasta -out hsp70.msa
./hmmbuild hsp70.hmm hsp70.msa
./hmmbuild MCRA.hmm MCRA.msa

for sample in proteomes/proteome*.fasta
do
tblname=$(echo $sample | sed 's/.fasta/mcrA/')
./hmmsearch --tblout $tblname.tbl MCRA.hmm $sample
done

for sample in proteomes/proteome*.fasta
do
tblname=$(echo $sample | sed 's/.fasta/hsp70/')
./hmmsearch --tblout $tblname.tbl hsp70.hmm $sample
done

rm *.msa
rm *.hmm
rm *.fasta
