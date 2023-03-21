# This directory contains the information on generating isoform-specific protein structures with AlphaFold.

## Getting fasta sequences for RefSeq protein isoforms

### Downlaod the RefSeq file
```
wget https://ftp.ncbi.nlm.nih.gov/refseq/H_sapiens/annotation/GRCh38_latest/refseq_identifiers/GRCh38_latest_protein.faa.gz
```

## Running AlphaFold

### LSF server submission:
```
bsub -g /tychele/alphafold -oo "$protein".log -q general -G compute-tychele -a "docker(gcr.io/ris-registry-shared/alphafold:2.2.0)" -gpu "num=1:j_exclusive=yes" -R "gpuhost rusage[mem=150GB]" -M 150GB python3 /app/alphafold/run_alphafold.py --output_dir /path/to/output/ --model_preset monomer --fasta_paths /path/to/"$protein".fasta --max_template_date 2022-03-31 --db_preset reduced_dbs
```


