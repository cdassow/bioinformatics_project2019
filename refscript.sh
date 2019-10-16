for i in {01..22} 
do
./muscle -in Private/bioinformatics_project2019/ref_sequences/hsp70gene_$i.fasta -out Private/bioinformatics_project2019/ref_sequences/hsp70aligned_$i.fasta
done;

for i in {01..18}
do
./muscle -in Private/bioinformatics_project2019/ref_sequences/mcrAgene_$i.fasta -out Private/bioinformatics_project2019/mcrAgenealigned_$i.fasta
done;
