# Shell Script to Analyze what proteomes from the directory "Proteomes" offers high potential as a target for future research on pH-resistant methanogentic Archaea
# This shell works when running in the directory found in: /afs/crc.nd.edu/user/p/peckard/Private/bioinformatics_project2019 on the University of Notre Dame's CRC servers
# Usage: bash projectshellPractice.sh

# This loop appends all of the files for the reference hsp70 protein sequences into a single file
for file in "./ref_sequences/hsp70gene*.fasta"
do
  	cat $file >> alignhsp70.fasta
done

# This loop appends all of the files for the reference mcrA protein sequences into a single file

for file1 in "./ref_sequences/mcrAgene*.fasta"
do
  	cat $file1 >> alignmcrA.fasta
done

# Muscle is used to align each of the appended files from above to find the conserved sequences between the reference protein sequences of both hsp70 and mcrA
./../muscle -in ./alignhsp70.fasta -out muscledhsp70.fasta
./../muscle -in ./alignmcrA.fasta -out muscledmcrA.fasta

# The hmmer program hmmbuild is used to build a hmm dataset from the aligned reference sequences so that the conserved sequences can be cross referenced with the proteomes in the next step
./../hmmer-3.2.1/bin/hmmbuild builthsp70.fasta muscledhsp70.fasta
./../hmmer-3.2.1/bin/hmmbuild builtmcrA.fasta muscledmcrA.fasta

# The next 9 lines are renaming files for proteomes 1-9 to fit the format used in the search loop that follows
mv ./proteomes/proteome_01.fasta ./proteomes/proteome_1.fasta
mv ./proteomes/proteome_02.fasta ./proteomes/proteome_2.fasta
mv ./proteomes/proteome_03.fasta ./proteomes/proteome_3.fasta
mv ./proteomes/proteome_04.fasta ./proteomes/proteome_4.fasta
mv ./proteomes/proteome_05.fasta ./proteomes/proteome_5.fasta
mv ./proteomes/proteome_06.fasta ./proteomes/proteome_6.fasta
mv ./proteomes/proteome_07.fasta ./proteomes/proteome_7.fasta
mv ./proteomes/proteome_08.fasta ./proteomes/proteome_8.fasta
mv ./proteomes/proteome_09.fasta ./proteomes/proteome_9.fasta

# numbering to be used in loop to match up the naming number with the proteome file. Also why the renaming was required because it could not match with 01
number=$(0)


# Loop to search all proteomes for the hsp70 and mcrA sequences obtained in the hmm file
# This loop loops through each of the proteomes in order (by changing the number), then searches in the proteomes and tabulates the output into a new file
# The new files are then searched to isolate the relevant information and the number of unique lines are isolated and counted and appended to a new file.
# The number of unique lines is a way to count the number of copies of each gene sequence
# The names of each of the proteomes are also appened to a different file to be used in making the data table later.
for search in ./proteomes/proteome_*
do
  	number=$(($number + 1))
        ./../hmmer-3.2.1/bin/hmmsearch --tblout tablehsp70_proteome_$number ./builthsp70.fasta $search
        ./../hmmer-3.2.1/bin/hmmsearch --tblout tablemcrA_proteome_$number ./builtmcrA.fasta $search
        echo proteome_$number >> finalName.csv
        cat tablemcrA_proteome_$number | grep -v "#" | uniq | wc -l >> finalmcrA.csv
        cat tablehsp70_proteome_$number | grep -v "#" | uniq | wc -l >> finalhsp70.csv
done

# In this loop, we are looping through all of the lines of each of the three files created from the above loop and then the corresponding lines for each proteome and number are comma delimited.
# We separated the data by commas to make the final tabulated view of the results to evaluate which proteomes have the highest potential for future research.
for i in {1..50}
do
  	Name=$(cat ./finalName.csv | head -n $i | tail -n 1)
        mcrA=$(cat ./finalmcrA.csv | head -n $i | tail -n 1)
        hsp70=$(cat ./finalhsp70.csv | head -n $i | tail -n 1)
        echo "$Name , $mcrA , $hsp70" >> FutureResearch.csv
done

# The tabulated file made in the above for loop is now given a title to describe what each column is giving information for.
# The data is then sorted first by the number of mcrA genes by reverse numerical order and then the data is further sorted within this by the number of hsp70 genes in reverse numerical order.
# This sorting yields a final table listing the most promising proteomes for future work at the top.
echo "Proteome Name, Number of mcrA, Number of hsp70" > MostPromisingProteomes.csv
sort -t "," -k 2 -r -k 3 -r -n FutureResearch.csv >> MostPromisingProteomes.csv


# Renaming the files again so the shell can be run again
mv ./proteomes/proteome_1.fasta ./proteomes/proteome_01.fasta
mv ./proteomes/proteome_2.fasta ./proteomes/proteome_02.fasta
mv ./proteomes/proteome_3.fasta ./proteomes/proteome_03.fasta
mv ./proteomes/proteome_4.fasta ./proteomes/proteome_04.fasta
mv ./proteomes/proteome_5.fasta ./proteomes/proteome_05.fasta
mv ./proteomes/proteome_6.fasta ./proteomes/proteome_06.fasta
mv ./proteomes/proteome_7.fasta ./proteomes/proteome_07.fasta
mv ./proteomes/proteome_8.fasta ./proteomes/proteome_08.fasta
mv ./proteomes/proteome_9.fasta ./proteomes/proteome_09.fasta
