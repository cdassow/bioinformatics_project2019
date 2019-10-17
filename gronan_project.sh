#********************************************************************************************************************
# Author: George Ronan
# Date Created: 16 October, 2019
# Date Edited: 16 October, 2019
# Description: Code for bioinformatics project for BIOS 60318 mid-semester project
#********************************************************************************************************************
# Inputs: Proteome directory (PD) to be analyzed, expected extension (PE) of proteome files, Reference gene/proteome
#	  directory (RD), expected extension of references (RE)
# NOTE - It is recommended to use objective path to directories for minimal potential of error
# Outputs: 
# Usage: bash gronan_project.sh <PD> <PE> <RD> <RE>
# ASSUMPTIONS - both muscle (binary) and hmmer (directory) are in a 'bin' directory sharing a parent directory with
#	        location of this executable
#********************************************************************************************************************

# Loop thru files in proteome directory
echo "Starting loop R"
for fileR in $3/*.$4 # Loop through all proteome reference files in specified directory with specified extension
do
	filenameR=$(echo $fileR | rev | cut -d "/" -f 1 | rev | cut -d "." -f 1)
	# Should activate muscle for each proteome ref file sequentially with outnames temp_m_<filename>.txt
	../bin/muscle3.3.31 -in $fileR -out temp_m_$filenameR.msa -quiet
	../bin/hmmer-3.2/bin/hmmbuild --amino -o temp_hmm.txt temp_b_$filenameR.hmm temp_m_$filenameR.msa
	for fileP in $1/*.$2 # Loop through all proteome files in specified directory with specified extension
	do
		filenameP=$(echo $fileP | rev | cut -d "/" -f 1 | rev | cut -d "." -f 1)
		# Should activate hmmsearch for each proteome using the previously build reference file
		../bin/hmmer-3.2/bin/hmmsearch -o hmm_outs/hmm_$filenameP-$filenameR.txt --tblout results_summary.txt \
		--domtblout hits_summary_$filenameP-$filenameR.txt temp_b_$filenameR.hmm $fileP
		#echo $filenameP
	done
	rm temp_m_$filenameR.msa temp_b_$filenameR.hmm temp_hmm.txt
done
