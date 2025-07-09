# Trim fastq files
bbduk.sh in=fastq_files/EcGQ0079_S172_R1_001.fastq.gz in2=fastq_files/EcGQ0079_S172_R2_001.fastq.gz ref=adapters,artifacts,phix,lambda out=fastq_files/EcGQ0079_S172_R1_001.bbduk.fastq.gz out2=fastq_files/EcGQ0079_S172_R2_001.bbduk.fastq.gz # Run BBDuk on the three sets of reads
bbduk.sh in=fastq_files/7A_S298_R1_001.fastq.gz in2=fastq_files/7A_S298_R2_001.fastq.gz ref=adapters,artifacts,phix,lambda out=fastq_files/7A_S298_R1_001.bbduk.fastq.gz out2=fastq_files/7A_S298_R2_001.bbduk.fastq.gz # Run BBDuk on the three sets of reads
bbduk.sh in=fastq_files/8A_S299_R1_001.fastq.gz in2=fastq_files/8A_S299_R2_001.fastq.gz ref=adapters,artifacts,phix,lambda out=fastq_files/8A_S299_R1_001.bbduk.fastq.gz out2=fastq_files/8A_S299_R2_001.bbduk.fastq.gz # Run BBDuk on the three sets of reads
java -jar /datadisk1/Bioinformatics_programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 16 fastq_files/EcGQ0079_S172_R1_001.bbduk.fastq.gz fastq_files/EcGQ0079_S172_R2_001.bbduk.fastq.gz fastq_files/EcGQ0079_S172_R1_001.bbduk.trimmed.fastq.gz fastq_files/EcGQ0079_S172_R1_001.bbduk.unpaired.fastq.gz fastq_files/EcGQ0079_S172_R2_001.bbduk.trimmed.fastq.gz fastq_files/EcGQ0079_S172_R2_001.bbduk.unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 # Run trimmomatic on the three sets of reads
java -jar /datadisk1/Bioinformatics_programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 16 fastq_files/7A_S298_R1_001.bbduk.fastq.gz fastq_files/7A_S298_R2_001.bbduk.fastq.gz fastq_files/7A_S298_R1_001.bbduk.trimmed.fastq.gz fastq_files/7A_S298_R1_001.bbduk.unpaired.fastq.gz fastq_files/7A_S298_R2_001.bbduk.trimmed.fastq.gz fastq_files/7A_S298_R2_001.bbduk.unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 # Run trimmomatic on the three sets of reads
java -jar /datadisk1/Bioinformatics_programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 16 fastq_files/8A_S299_R1_001.bbduk.fastq.gz fastq_files/8A_S299_R2_001.bbduk.fastq.gz fastq_files/8A_S299_R1_001.bbduk.trimmed.fastq.gz fastq_files/8A_S299_R1_001.bbduk.unpaired.fastq.gz fastq_files/8A_S299_R2_001.bbduk.trimmed.fastq.gz fastq_files/8A_S299_R2_001.bbduk.unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 # Run trimmomatic on the three sets of reads

# Assemble and annotate the reference genome
unicycler-runner.py -1 fastq_files/EcGQ0079_S172_R1_001.bbduk.trimmed.fastq.gz -2 fastq_files/EcGQ0079_S172_R2_001.bbduk.trimmed.fastq.gz -o EcGQ0079_assembly -t 16 --min_fasta_length 200 # Assemble the reference genome with unicycler
prokka --outdir EcGQ0079_assembly/prokka_assembly/ --force --prefix EcGQ0079 --cpus 16 EcGQ0079_assembly/assembly.fasta # Annotate the reference genome with prokka

# Run snippy
snippy --cpus 16 --outdir snippy_EcGQ0079 --ref EcGQ0079_assembly/prokka_assembly/EcGQ0079.gbf --R1 fastq_files/EcGQ0079_S172_R1_001.bbduk.trimmed.fastq.gz --R2 fastq_files/EcGQ0079_S172_R2_001.bbduk.trimmed.fastq.gz --force
snippy --cpus 16 --outdir snippy_7A --ref EcGQ0079_assembly/prokka_assembly/EcGQ0079.gbf --R1 fastq_files/7A_S298_R1_001.bbduk.trimmed.fastq.gz --R2 fastq_files/7A_S298_R2_001.bbduk.trimmed.fastq.gz --force
snippy --cpus 16 --outdir snippy_8A --ref EcGQ0079_assembly/prokka_assembly/EcGQ0079.gbf --R1 fastq_files/8A_S299_R1_001.bbduk.trimmed.fastq.gz --R2 fastq_files/8A_S299_R2_001.bbduk.trimmed.fastq.gz --force

# Run samtools
samtools coverage snippy_EcGQ0079/snps.bam > snippy_EcGQ0079/samtools_coverage.txt # Get coverage
samtools coverage snippy_7A/snps.bam > snippy_7A/samtools_coverage.txt # Get coverage
samtools coverage snippy_8A/snps.bam > snippy_8A/samtools_coverage.txt # Get coverage
samtools depth -a snippy_EcGQ0079/snps.bam > snippy_EcGQ0079/samtools_depth.txt # Get depth
samtools depth -a snippy_7A/snps.bam > snippy_7A/samtools_depth.txt # Get depth
samtools depth -a snippy_8A/snps.bam > snippy_8A/samtools_depth.txt # Get depth
