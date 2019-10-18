#alignment of sequences
#in ref_sequences directory
#loop to put all mcrA ref sequences into one file
for file in mcr*.fasta; do cat $file >> ../methanseqs.fa; done
#muscle for mcr
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/muscle -in methanseqs.fa -out methanseqs.afa
#hmmbuild for mcrA
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/hmmer-3.2.1/hmmbuild methanseqs.hmm methanseqs.afa
#hmmsearch
for file in *.fasta; 
do /afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/hmmer-3.2.1/bin/hmmsearch --tblout ${file}.out methanseqs.hmm $file;
done


#get methanogens from the search (within methanresults)
for file in *.out.fasta
do
echo ${file}
if grep -E '[No hits detected that satisfy reporting thresholds]'
then
echo '0'
else
echo '1'
fi
done



#loop to put all hsp70 ref sequences into one file
for file in hsp*.fasta; do cat $file >> ../hspgene_seqs.fa; done
#muscle for hsp to create alignment
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/muscle -in hspgene_seqs.fa -out hsp_seqs.afa
  


#hmmbuild on hsp

#hmmsearch with hsp.hmm on methanogens only

#now we need a list of each methanogen and how many hsp70 genes it has
