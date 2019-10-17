#we could not get this to actually work yet
#it told us that we had the incorrect number of command line arguments
#we think we should run the proteomes through this, and then the ones that worked through hsp 
for files in proteome_*.fasta
do
../hmmer-3.2.1/bin/hmmsearch ref_sequences/aligned_mcr_genes.hmm proteomes/$files 
done
