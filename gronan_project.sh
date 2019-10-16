#********************************************************************************************************************
# Author: George Ronan
# Date Created: 16 October, 2019
# Date Edited: 16 October, 2019
# Description: Code for bioinformatics project for BIOS 60318 mid-semester project
#********************************************************************************************************************
# Inputs: Proteome directory (PD) to be analyzed, expected extension (PE) of proteome files, Reference proteome
#	  directory (RD) for hmmer, number of genes to be assessed (RN), expected extension of reference files (RE)
# Outputs: 
# Usage: bash gronan_project.sh <PD> <PE> <RD> <RN> <RE>
#********************************************************************************************************************

# Loop thru files in proteome directory
for fileP in $1/*.$2
do
	echo $fileP
done
