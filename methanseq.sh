#alignment of sequences
#muscle must be in same directory as input file 
######I think that we need to run muscle twice: 1 time to ID the mcrA gene  and a second time to ID the hsp70 gene


#in ref_sequences directory
for file in mcr*.fasta; do cat $file >> ../methanseqs.fa; done

#muscle for mcr
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/muscle -in methanseqs.fa -out methanseqs.afa

#in hsp directory
for file in hsp*.fasta; do cat $file >> ../hspgene_seqs.fa; done
#muscle for hsp
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/muscle -in hspgene_seqs.fa -out hsp_seqs.afa

#hmmbuild
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/hmmer-3.2.1/hmmbuild methanseqs.hmm methanseqs.afa   

#hmmsearch
#Usage: bash scri
for file in *.fasta; do /afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/hmmer-3.2.1/bin/hmmsearch methanseqs.hmm $file > ${file}.out; done  

#get methanogens from the search

#hmmbuild on hsp

#hmmsearch with hsp.hmm on methanogens only

#now we need a list of each methanogen and how many hsp70 genes it has
