#put all mcr and hsp genes into one file each
cat ../ref_sequences/hsp*.fasta >> all_hsp_genes.fasta
cat ../ref_sequences/mcr*.fasta >> all_mcr_genes.fasta

#muscle alignments of all_hsp_genes.fasta and all_mcr_genes.fasta
../../muscle -in all_hsp_genes.ref -out aligned_hsp_genes.ref

#hmmsearch output into specific tables
for files in proteome*
do
../../hmmer-3.2.1/bin/hmmsearch --tblout mcr$files.hm ../ref_sequences/aligned_mcr_genes.hmm $files 
../../hmmer-3.2.1/bin/hmmsearch --tblout hsp$files.hm ../ref_sequences/aligned_hsp_genes.hmm $files
done

#make a file containing number of hits for hsp and mcr for each proteome
echo "proteome,mcr,hsp" > final.txt
for i in {01..50}
do  
a=$(cat hspproteome_$i.fasta.hm | grep -v "#" | wc -l)
b=$(cat mcrproteome_$i.fasta.hm | grep -v "#" | wc -l)
echo "$i,$b,$a" >> final.txt
done

#sort this file for subjects that meet our requirements
cat final.txt |grep -v ",0" > final_candidates.txt

