#alignment of sequences
#in ref_sequences directory
#loop to put all mcrA ref sequences into one file
for file in mcr*.fasta; do cat $file >> ../methanseqs.fa; done
#loop to put all hsp70 ref sequences into one file
for file in hsp*.fasta; do cat $file >> ../hspgene_seqs.fa; done

#muscle for hsp to create alignment
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/muscle -in hspgene_seqs.fa -out hsp_seqs.afa 
#muscle for mcr
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/muscle -in methanseqs.fa -out methanseqs.afa
#hmmbuild for mcrA
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/hmmer-3.2.1/hmmbuild methanseqs.hmm methanseqs.afa
#hmmbuil for hsp70
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/hmmer-3.2.1/hmmbuild hspseqs.hmm hsp_seqs.afa 


#creat file to store proteome results
echo "proteome, mcrA, hsp70" > methanresults.csv

#loop to get results of mcrA search, hsp search, and summarize results
for file in *.fasta;
do
proteome=${file}
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/hmmer-3.2.1/bin/hmmsearch --tblout ${file}.out methanseqs.hmm $file
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/hmmer-3.2.1/bin/hmmsearch --tblout ${file}hsp.out hspseqs.hmm $file
mcrA=$(cat ${file}.out | grep -v '#' | wc -l)
hsp70=$(cat ${file}hsp.out | grep -v '#' | wc -l)
echo "$proteome, $mcrA, $hsp70" >> methanresults.csv;done

#here are the best candidate pH-resistant methanogens
cat methanresults.csv | sort -n -r -k2 | head -n 16 | sort -n -r -k3 | head -4 > best_methans.txt 

