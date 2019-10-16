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
