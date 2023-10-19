#!/bin/bash

# Script that identifies the files that overlap the regions in a given bed file.
# must be run from the code directory. 
# R and data.table package must be installed.

# set variables
INPUT_BED_FILE=<enter_file_path_here>
OUTPUT_FILENAMES_FILE=<enter_file_path_here>

# concatinate index file
Rscript ../code/get_filenames.R ${INPUT_BED_FILE} ${OUTPUT_FILENAMES_FILE}

### example:
INPUT_BED_FILE="../data/TTN_canonical_CDS_coordinates_GRCh38.rangefile"
OUTPUT_FILENAMES_FILE="../results/TTN_canonical_CDS_coordinates_GRCh38_ukb_wes_filenames.tsv"
Rscript ../code/get_filenames.R ${INPUT_BED_FILE} ${OUTPUT_FILENAMES_FILE}



