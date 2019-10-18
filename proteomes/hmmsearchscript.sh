#for this script to run this script needs to be in proteomes, it will not work when we try to put it anywhere else and put in paths
#for this script to run muscle and hammer need to be in the Private directory (one above bioinformatics_project2019)

#put all mcr and hsp genes into one file each
cat ../ref_sequences/hsp*.fasta >> all_hsp_genes.fasta
cat ../ref_sequences/mcr*.fasta >> all_mcr_genes.fasta

#muscle alignments of all_hsp_genes.fasta and all_mcr_genes.fasta
../../muscle -in all_hsp_genes.ref -out aligned_hsp_genes.ref

#hmmsearch both the aligned mcr and hsp gene files and output into specific files in table form
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

#search this file for subjects that meet our requirements and output the candidates that have at least 1 mcrA hit and 1 hsp hit
cat final.txt |grep -v ",0" > final_candidates.txt

#final_candidates.txt contains our suggestions for the researcher, the ones with the most hsp hits are the best
#also we are aware that there are some duplicate hits with some of the proteome files and we know that we need to use unique but we could not get it to work

