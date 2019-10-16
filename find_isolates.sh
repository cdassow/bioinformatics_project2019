#usage bash find_isolates.sh <muscle exe path> <path to hmmbuild exe path> <hmmsearch exe path> <name for hsp results> <name for mcrA results>

#warn user of upcoming deleting files
#echo "WARNING this program  will delete any files named "hsp70gene_combined.fasta", "mcrAgene_combined.fasta", and "proteome_combined.fasta" continue? (yes/no)"

#read continue

#if[continue="yes"]; then
#rm any combined files that already exist
rm ./ref_sequences/hsp70gene_combined.fasta
rm ./ref_sequences/mcrAgene_combined.fasta
rm ./proteomes/proteome_combined.fasta

#combine the reference sequences and proteome genome
for file in ./ref_sequences/hsp70gene_??.fasta
do
cat $file >> ./ref_sequences/hsp70gene_combined.fasta
done

for file in ./ref_sequences/mcrAgene_??.fasta
do
cat $file >> ./ref_sequences/mcrAgene_combined.fasta
done

for file in ./proteomes/proteome_??.fasta
do
cat $file >> ./proteomes/proteome_combined.fasta
done

#$1 -in ./ref_sequences/hsp70gene_combined.fasta -out hsp70gene.musc
#$1 -in ./ref_sequences/mcrAgene_combined.fasta -out mcrAgene.musc

#$2 hsp70gene.hmm hsp70gene.musc
#$2 mcrAgene.hmm mcrAgene.musc 

$3 -o $4 hsp70gene.hmm ./proteomes/proteome_combined.fasta
$3 -o $5 mcrAgene.hmm ./proteomes/proteome_combined.fasta 


#fi

