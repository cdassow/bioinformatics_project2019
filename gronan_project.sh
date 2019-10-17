#********************************************************************************************************************
# Author: George Ronan
# Date Created: 16 October, 2019
# Date Edited: 16 October, 2019
# Description: Code for bioinformatics project for BIOS 60318 mid-semester project
#********************************************************************************************************************
# Inputs: Proteome directory (PD) to be analyzed, expected extension (PE) of proteome files, Reference proteome
#	  directory (RD) for hmmer, number of genes to be assessed (RN), expected extension of reference files (RE)
# NOTE - It is recommended to use objective path to directories for minimal potential of error
# Outputs: 
# Usage: bash gronan_project.sh <PD> <PE> <RD> <RN> <RE>
# ASSUMPTIONS - both muscle (binary) and hmmer (directory) are in a 'bin' directory sharing a parent directory with
#	        location of this executable
#********************************************************************************************************************

# Loop thru files in proteome directory
echo "Starting loop"
for fileP in $1/*.$2 # Ayyyyyy it works!!!
do
	echo "Looping for $fileP"
	# Should activate muscle for each proteome file sequentially with outnames <temp_m_filename>
	#echo $fileP | xargs ../bin/muscle3.3.31 -out temp_m_$(echo $fileP | rev | cut -d "/" -f 1 | \
	#     rev | cut -d "." -f 1).txt
	echo temp_m_$(echo $fileP | rev | cut -d "/" -f 1 | rev | cut -d "." -f 1).txt
done
