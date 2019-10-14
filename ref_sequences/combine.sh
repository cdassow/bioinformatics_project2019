for file in hsp70*
do
cat $file >> hsp70_combined.fasta
done

for file in mcrA*
do
cat $file >> mcrA_combined.fasta
done
