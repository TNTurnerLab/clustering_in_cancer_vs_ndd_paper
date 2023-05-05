# This directory contains the information on generating isoform-specific protein structures with AlphaFold.

#### Author: Tychele N. Turner, Ph.D.
#### Last Update: May 5, 2023

## Getting fasta sequences for RefSeq protein isoforms

### Download the RefSeq file
```
wget https://ftp.ncbi.nlm.nih.gov/refseq/H_sapiens/annotation/GRCh38_latest/refseq_identifiers/GRCh38_latest_protein.faa.gz
```

### Get the protein fasta files
```
Rscript get_fasta_for_proteins_of_interest.R
```

## Running AlphaFold

### LSF server submission:
```
bsub -g /tychele/alphafold -oo "$protein".log -q general -G compute-tychele -a "docker(gcr.io/ris-registry-shared/alphafold:2.2.0)" -gpu "num=1:j_exclusive=yes" -R "gpuhost rusage[mem=150GB]" -M 150GB python3 /app/alphafold/run_alphafold.py --output_dir /path/to/output/ --model_preset monomer --fasta_paths /path/to/"$protein".fasta --max_template_date 2022-03-31 --db_preset reduced_dbs
```

## Preparing the AlphaFold data for submission at ModelArchive.
## In each protein directory run the python script from ModelArchive. Here is how I did for .tar.bz2 files I had for each structure
```
#!/bin/bash

#Run first
#ls *bz2  | sed 's/.tar.bz2//g' > list_of_proteins

inputFile="$1"

while read line
do 
	echo "$line"
	tar xvf "$line".tar.bz2
	sudo chmod -R 777 "$line"
	cd "$line"
	python3 ../model_archive.py 
	cd ..
	mkdir final_model_archive/"$line"/
	cp "$line"/ranked_0.pdb final_model_archive/"$line"/
	cp "$line"/ranked_0.pkl final_model_archive/"$line"/
	cp "$line"/ranking_debug.json final_model_archive/"$line"/
	rm -rf "$line"/
done < "$inputFile"
```

## Just for reference I also ran this on uncompressed folders as follows:
```
#!/bin/bash
inputFile="$1"

while read line
do 
	echo "$line"
	sudo chmod -R 777 "$line"
	cd "$line"
	python3 ../model_archive.py 
	cd ..
	mkdir final_model_archive/"$line"/
	cp "$line"/ranked_0.pdb final_model_archive/"$line"/
	cp "$line"/ranked_0.pkl final_model_archive/"$line"/
	cp "$line"/ranking_debug.json final_model_archive/"$line"/
	tar -jcvf "$line".tar.bz2 "$line"/
	rm -rf "$line"/
done < "$inputFile"
```
