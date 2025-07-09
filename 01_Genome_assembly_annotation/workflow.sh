# Genome assembly
nanopore_assembly.sh Nanopore_reads/barcode01_reads.fastq.gz Illumina_reads/F5466_S85_R1_001.fastq.gz Illumina_reads/F5466_S85_R2_001.fastq.gz F5446 20 10 # Run the genome assembly pipeline
nanopore_assembly.sh Nanopore_reads/barcode02_reads.fastq.gz Illumina_reads/F48994_S136_R1_001.fastq.gz Illumina_reads/F48994_S136_R2_001.fastq.gz F48994 20 10 # Run the genome assembly pipeline
nanopore_assembly.sh Nanopore_reads/barcode03_reads.fastq.gz Illumina_reads/H17629_S137_R1_001.fastq.gz Illumina_reads/H17629_S137_R2_001.fastq.gz H17629 20 10 # Run the genome assembly pipeline
nanopore_assembly.sh Nanopore_reads/barcode04_reads.fastq.gz Illumina_reads/H70375_S86_R1_001.fastq.gz Illumina_reads/H70375_S86_R2_001.fastq.gz H70375 20 10 # Run the genome assembly pipeline
nanopore_assembly.sh Nanopore_reads/barcode05_reads.fastq.gz Illumina_reads/T64870_S87_R1_001.fastq.gz Illumina_reads/T64870_S87_R2_001.fastq.gz T64870 20 20 # Run the genome assembly pipeline
nanopore_assembly.sh Nanopore_reads/barcode06_reads.fastq.gz Illumina_reads/S2568_S135_R1_001.fastq.gz Illumina_reads/S2568_S135_R2_001.fastq.gz S2568 20 10 # Run the genome assembly pipeline

# Check assembly quality
mkdir CheckM/ # Make directory
mkdir CheckM/genomes/ # Make directory
mkdir CheckM/output/ # Make directory
cp F5446/F5446.fasta CheckM/genomes/ # Get the genome assembly files
cp F48994/F48994.fasta CheckM/genomes/ # Get the genome assembly files
cp H17629/H17629.fasta CheckM/genomes/ # Get the genome assembly files
cp H70375/H70375.fasta CheckM/genomes/ # Get the genome assembly files
cp T64870/T64870.fasta CheckM/genomes/ # Get the genome assembly files
cp S2568/S2568.fasta CheckM/genomes/ # Get the genome assembly files
checkm lineage_wf -t 16 -x fasta CheckM/genomes/ CheckM/output/

# Annotation
mkdir Annotation/ # Make directory
# Manually created the PGAP yaml and submol.yaml files within the folder Annotation
cp F5446/F5446.fasta Annotation/ # Get the genome assembly files
cp F48994/F48994.fasta Annotation/ # Get the genome assembly files
cp H17629/H17629.fasta Annotation/ # Get the genome assembly files
cp H70375/H70375.fasta Annotation/ # Get the genome assembly files
cp T64870/T64870.fasta Annotation/ # Get the genome assembly files
cp S2568/S2568.fasta Annotation/ # Get the genome assembly files
# Manually modified the headers in the fasta files to add location (chromosome or plasmid) and plasmid names
cd Annotation/ # Change into the Annotation directory
pgap.py -c 16 -m 100g -n F5446_template.yaml -o F5446_output # Run PGAP
pgap.py -c 16 -m 100g -n F48994_template.yaml -o F48994_output # Run PGAP
pgap.py -c 16 -m 100g -n H17629_template.yaml -o H17629_output # Run PGAP
pgap.py -c 16 -m 100g -n H70375_template.yaml -o H70375_output # Run PGAP
pgap.py -c 16 -m 100g -n T64870_template.yaml -o T64870_output # Run PGAP
pgap.py -c 16 -m 100g -n S2568_template.yaml -o S2568_output # Run PGAP