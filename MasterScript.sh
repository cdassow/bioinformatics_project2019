#This script will flexibly and efficiently search genomes for the HSP70 and McrA genes and generate a summary table collating the results of all searches
#
############################################
# STEP 1 : ALIGNMENT #
############################################
#
#Using the muscle utility to align the desired genes. Enter your 2 desired gene types as the first two shell variables
# bash MasterScript.sh 'hsp70*.fasta' 'mcrAgene*.fasta'

for gene in ref_sequences/
do
  muscle -in $1 -out $1_aligned
done
for gene in ref_sequences/
do
  muscle -in $2 -out $2_aligned
done

############################################
# STEP 2 : THE NEXT BIT #
############################################
