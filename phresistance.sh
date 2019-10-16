#This program takes the an input of FASTA files and will filter them for pH resistant Methanogens.
#User must input the variable of the proteome file numbers to be analyzed. 

#mcrA reference sequence
cat ref_sequences/mcrAgene_??.fasta > mcraref.fasta
./programs/muscle -in "mcraref.fasta" -out "mcramuscle.fasta"
./programs/hmmbuild --amino "mcrabuild.fasta" "mcramuscle.fasta"
for proteome in ./proteomes/proteome_$@.fasta
do
./programs/muscle -in $proteome -out "proteomemuscle_$@.fasta"
./programs/hmmbuild --amino "proteomebuild_$@.fasta" "proteomemuscle_$@.fasta"
./programs/hmmsearch "mcrabuild.fasta" "proteomebuild_$@.fasta" > processedproteome$@
done


#hsp reference sequence
#cat ref_sequences/hsp70gene_??.fasta > hspref.fasta
#./progrmas/muscle -in "hspref.fasta" -out "hspmuscle.fasta"
#./programs/hmmbuild --amino "hspbuild.fasta" "hspmuscle.fasta"

#for
#./programs/hmmsearch "hspbuild.fasta"



