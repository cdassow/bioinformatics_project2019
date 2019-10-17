#This script will flexibly and efficiently search genomes for the HSP70 and McrA genes and generate a summary table collating the results of all searches
# Usage: bash MasterScript.sh

############################################
# STEP 1 : ALIGNMENT #
############################################
#
# Using the muscle utility to align the desired genes.


cat ~/Private/Biocomputing/bioinformatics/bioinformatics_project2019/ref_sequences/hsp70* > hsp70_all
cat ~/Private/Biocomputing/bioinformatics/bioinformatics_project2019/ref_sequences/mcrA* > mcrA_all
./muscle -in hsp70_all -out hsp70_all_aligned
./muscle -in mcrA_all -out mcrA_all_aligned

############################################
# STEP 2 : hmmBuild #
############################################
# building a hidden markov model

./ham/bin/hmmbuild hsp70_hmm hsp70_all_aligned
./ham/bin/hmmbuild mcrA_hmm mcrA_all_aligned

############################################
# STEP 3 : hmmSearch #
############################################
# compare the constructed hmms against sequences

for microbe in {01..50}
do
  ./ham/bin/hmmsearch --tblout hsp70_tbl_$microbe hsp70_hmm ~/Private/Biocomputing/bioinformatics/bioinformatics_project2019/proteomes/proteome_$microbe.fasta
  ./ham/bin/hmmsearch --tblout mcrA_tbl_$microbe mcrA_hmm ~/Private/Biocomputing/bioinformatics/bioinformatics_project2019/proteomes/proteome_$microbe.fasta
done

############################################
# STEP 4 : CLEANIN' IT UP #
############################################
# This step compares the number of matches between hsp70 and mcrA and generates a table

echo "proteme_name hsp70_matches mcrA_matches" > Summary1.txt
for tbl in {01..50}
do
  x=$(echo proteome_$tbl)
  y=$(~/Private/Biocomputing/bioinformatics/bioinformatics_project2019/hsp70_tbl_$tbl | grep -v "#" | wc -l)
  z=$(~/Private/Biocomputing/bioinformatics/bioinformatics_project2019/mcrA_tbl_$tbl | grep -v "#" | wc -l)
  echo "$x $y $z" >> Summary1.txt
done

############################################
# STEP 5 : FINAL LIST #
############################################
# This step finds potentially pH resistant methanogens and puts them all in a list for your enjoyment

cat Summary1.txt | grep -v " 0 " | cut -d " " -f 1 > PhResistantMethanogens.txt

