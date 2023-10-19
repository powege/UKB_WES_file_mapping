# UKB_WES_file_mapping

This workflow enables the identification of which UKB WES final release files cover which regions. 

# Data
wes_vcf_final_release_block_map.tsv -- a file with the following columns:
1. filename (UKB WES final release filename)
2. chromosome (chromosome (with "chr" prefix)
3. block (block number)
4. minPOS (the first (lowest) variant POS in the VCF file)
5. maxPOS (the maximum possible POS in the VCF file. This is taken to be minPOS-1 of the sequential block, or the last POS for the chromosome for the final block in each chromosome).
Note, the VCF files will not cover all the POS between minPOS and maxPOS. 
   
# Code
get_filenames.R -- an R script that takes a bed file of coordinates and identifies which files cover the regions. 
1.master_identify_filenames.sh -- a file that runs get_filenames.R from the command line. An example input bed file is provided. 
