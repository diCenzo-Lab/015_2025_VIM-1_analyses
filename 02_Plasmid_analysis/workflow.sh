# First download the plsdb (https://ccb-microbe.cs.uni-saarland.de/plsdb2025/download) and save it in a folder called plsdb

# Create file for each of the vim-1-containing plasmids
mkdir vim_plasmids/
echo "lcl|contig_5" | pullseq -i ../01_Genome_assembly_annotation/Annotation/F48994_output/annot.fna -N > vim_plasmids/F48994_vim_plasmid.fna
echo "lcl|contig_3" | pullseq -i ../01_Genome_assembly_annotation/Annotation/F5446_output/annot.fna -N > vim_plasmids/F5446_vim_plasmid.fna
echo "lcl|contig_3" | pullseq -i ../01_Genome_assembly_annotation/Annotation/H17629_output/annot.fna -N > vim_plasmids/H17629_vim_plasmid.fna
echo "lcl|contig_4" | pullseq -i ../01_Genome_assembly_annotation/Annotation/H70375_output/annot.fna -N > vim_plasmids/H70375_vim_plasmid.fna
echo "lcl|contig_3" | pullseq -i ../01_Genome_assembly_annotation/Annotation/T64870_output/annot.fna -N > vim_plasmids/T64870_vim_plasmid.fna

# Use blast to compare plasmids to plsdb
mkdir blast_database/
makeblastdb -in plsdb/plsdb.fna -out blast_database/plsdb -title plsdb -dbtype 'nucl'
mkdir blast_output/
blastn -query vim_plasmids/F48994_vim_plasmid.fna -db blast_database/plsdb -num_threads 16 > blast_output/F48994.blast.txt # Run BLASTp to search for the Nod and Nif proteins
blastn -query vim_plasmids/F5446_vim_plasmid.fna -db blast_database/plsdb -num_threads 16 > blast_output/F5446.blast.txt # Run BLASTp to search for the Nod and Nif proteins
blastn -query vim_plasmids/H17629_vim_plasmid.fna -db blast_database/plsdb -num_threads 16 > blast_output/H17629.blast.txt # Run BLASTp to search for the Nod and Nif proteins
blastn -query vim_plasmids/H70375_vim_plasmid.fna -db blast_database/plsdb -num_threads 16 > blast_output/H70375.blast.txt # Run BLASTp to search for the Nod and Nif proteins
blastn -query vim_plasmids/T64870_vim_plasmid.fna -db blast_database/plsdb -num_threads 16 > blast_output/T64870.blast.txt # Run BLASTp to search for the Nod and Nif proteins

# Get top 20 hits for each plasmid, merge, and dereplicate
head -50 blast_output/F48994.blast.txt | grep '0\.0' | head -20 > blast_output/F48994.top20.txt
head -50 blast_output/F5446.blast.txt | grep '0\.0' | head -20 > blast_output/F5446.top20.txt
head -50 blast_output/H17629.blast.txt | grep '0\.0' | head -20 > blast_output/H17629.top20.txt
head -50 blast_output/H70375.blast.txt | grep '0\.0' | head -20 > blast_output/H70375.top20.txt
head -50 blast_output/T64870.blast.txt | grep '0\.0' | head -20 > blast_output/T64870.top20.txt
cat blast_output/*top20.txt | cut -f1 -d' ' | sort -u > blast_output/combined.top.txt

# Get all the plasmids of interest
mkdir plasmids_of_interest/
cp vim_plasmids/*.fna plasmids_of_interest/
sed -i 's/lcl|contig/F48994/' plasmids_of_interest/F48994_vim_plasmid.fna
sed -i 's/lcl|contig/F5446/' plasmids_of_interest/F5446_vim_plasmid.fna
sed -i 's/lcl|contig/H17629/' plasmids_of_interest/H17629_vim_plasmid.fna
sed -i 's/lcl|contig/H70375/' plasmids_of_interest/H70375_vim_plasmid.fna
sed -i 's/lcl|contig/T64870/' plasmids_of_interest/T64870_vim_plasmid.fna
pullseq -i plsdb/plsdb.fna -n blast_output/combined.top.txt > temp.fna
seqkit split --by-id temp.fna
rename 's/temp.id_//' temp.fna.split/*.fna
mv temp.fna.split/*.fna plasmids_of_interest/
rm -r temp.fna.split/
rm temp.fna

# Annotate all the plasmids
cd plasmids_of_interest/
for k in *.fna; do prokka $k --outdir "$k".prokka.output --prefix $k --cpus 16; echo $k; done
cd ../
mkdir annotated_plasmids/
mv plasmids_of_interest/*.prokka.output/ annotated_plasmids/
mkdir annotated_plasmids/all/
cp annotated_plasmids/*/*.gff annotated_plasmids/all/

# Determine a pangenome of the plasmids
roary -p 16 -f roary_output/ annotated_plasmids/all/*.gff
grep -f blast_output/combined.top.txt plsdb/plsdb.tsv | cut -f2,25 | cut -f1,2 -d' ' > plasmid.names.txt
while IFS=$'\t' read -r accession name
do
    sed -i "s/$accession.fna/$name ($accession)/" roary_output/gene_presence_absence.Rtab
done < plasmid.names.txt
sed -i 's/F48994_vim_plasmid.fna/Enterobacter hormaechei F48994/' roary_output/gene_presence_absence.Rtab
sed -i 's/F5446_vim_plasmid.fna/Escherichia coli F5446/' roary_output/gene_presence_absence.Rtab
sed -i 's/H17629_vim_plasmid.fna/Enterobacter hormaechei H17629/' roary_output/gene_presence_absence.Rtab
sed -i 's/H70375_vim_plasmid.fna/Enterobacter hormaechei H70375/' roary_output/gene_presence_absence.Rtab
sed -i 's/T64870_vim_plasmid.fna/Klebsiella pneumoniae T64870/' roary_output/gene_presence_absence.Rtab
# Make a dendogram using the script dendogram.R, which was run manually after downloading the Roary output to my laptop

# Identify which plasmids encode VIM-1
grep -f blast_output/combined.top.txt plsdb/plsdb.abr | grep 'VIM-1' | grep 'GU724868' | cut -f7 > plasmids_of_interest/vim-1-containing-plasmids.txt

