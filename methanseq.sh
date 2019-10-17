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
/afs/crc.nd.edu/user/c/ctalbot2/Private/bioinformatics_project2019/muscle -in hspgene_seqs.fa -out methanseqs.afa

#we need to seek out the proteomes that contain this mcr gene these are methanogens

#muscle for hsp

#from the list of proteomes that are actually methanogens, we count the number of hsp gene occurances


#now we need to get a list of which isolates HAVE this gene
#then we count how many hsp70
