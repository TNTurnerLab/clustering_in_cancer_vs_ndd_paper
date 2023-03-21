# This directory contains the information on generating isoform-specific protein structures with AlphaFold.

## Running AlphaFold

### LSF server submission:
```
bsub -g /tychele/alphafold -oo "$protein".log -q general -G compute-tychele -a "docker(gcr.io/ris-registry-shared/alphafold:2.2.0)" -gpu "num=1:j_exclusive=yes" -R "gpuhost rusage[mem=150GB]" -M 150GB python3 /app/alphafold/run_alphafold.py --output_dir /path/to/output/ --model_preset monomer --fasta_paths /path/to/"$protein".fasta --max_template_date 2022-03-31 --db_preset reduced_dbs
```


