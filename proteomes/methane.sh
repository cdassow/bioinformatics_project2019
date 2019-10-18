for number in {01..50}
do
echo proteome_$number.fasta
/afs/crc.nd.edu/user/s/slouden/Private/hmmer-3.2.1/bin/hmmsearch --tblout file$number.txt ./methane.hmm proteome_$number.fasta 
cat file$number.txt | grep "Evalue"
done
