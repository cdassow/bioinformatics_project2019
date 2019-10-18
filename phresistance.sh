#This program searches fasta files for the presence of mcrA and hsp70 genes to indicate the presence of pH-resistant methanogens
#usage: bash phresistance.sh 'ref_sequences/mcrAgene_*.fasta' 'ref_sequences/hsp70gene_*.fasta' './proteomes/proteome_*.fasta' ./proteomes/proteome_*mcra.txt ./proteomes/proteome_*hsp70.txt

#combine mcrA reference sequences into one file
cat $1 > mcraref.fasta

#align file of mcrA reference sequences using muscle
./programs/muscle -in "mcraref.fasta" -out "mcramuscle.fasta"

#form hidden markov model from muscle alignment
./programs/hmmbuild --amino "mcrabuild.hmm" "mcramuscle.fasta"

#search in each proteome for mcrA matches
for proteome in $3
do
processedfile=$(echo $proteome | sed 's/.fasta//g')
./programs/hmmsearch mcrabuild.hmm $proteome > $processedfile"mcra".txt
done


#combine hsp70 reference sequences into one file
cat $2 > hspref.fasta

#align file of hsp70 reference sequences using muscle
./programs/muscle -in "hspref.fasta" -out "hspmuscle.fasta"

#form hidden markov model from muscle alignment
./programs/hmmbuild --amino "hsp70build.hmm" "hspmuscle.fasta"

#search in each proteome for hsp70 matches
for proteome in $3
do
processedfile=$(echo $proteome | sed 's/.fasta//g')
./programs/hmmsearch hsp70build.hmm $proteome > $processedfile"hsp70".txt
done


#create table to organize data:

#create table header
echo "proteome name: mcrA count, hsp70 count" > ./summarytable.txt

#enter data into table
for proteome in $3
do
number=$(echo $proteome | sed 's/.fasta//g' | tr -d ./proteomes_)
echo $number >> numberfile.txt
done

for mcra in $4
do
var1=$(cat $mcra | grep '>>' | wc -l)
echo $var1 >> mcrafile.txt
done

for hsp70 in $5
do
var2=$(cat $hsp70 | grep '>>' | cut -d " " -f 3-6 | uniq | wc -l)
echo $var2 >> hsp70file.txt
done

for i in {01..50}
do
name=$(cat numberfile.txt | head -n $i | tail -n 1)
var1=$(cat mcrafile.txt | head -n $i | tail -n 1)
var2=$(cat hsp70file.txt | head -n $i | tail -n 1)
echo "proteome_$name: $var1, $var2" >> ./summarytable.txt 
done


#create list of candidate pH-resistant methanogens
echo "candidate pH-resistant methanogens, best to worst:" > candidatemethanogens.txt
cat summarytable.txt | grep "1," | sort -k 3 -nr | grep -v " 0" >> candidatemethanogens.txt
