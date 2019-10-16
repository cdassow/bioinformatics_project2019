#This script will flexibly and efficiently search genomes for the HSP70 and McrA genes and generate a summary table collating the results of all searches
#
############################################
# STEP 1 : ALIGNMENT #
############################################
#
# Using the muscle utility to align the desired genes.
# bash MasterScript.sh 

cat ~/Private/Biocomputing/bioinformatics/bioinformatics_project2019/ref_sequences/hsp70* > hsp70_all
cat ~/Private/Biocomputing/bioinformatics/bioinformatics_project2019/ref_sequences/mcrA* > mcrA_all
./muscle -in hsp70_all -out hsp70_all_aligned
./muscle -in mcrA_all -out mcrA_all_aligned

############################################
# STEP 2 : hmmBuild
############################################
