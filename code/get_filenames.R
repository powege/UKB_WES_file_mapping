# Script that takes a bed file of coordinates (GRCh38), and returns the filenames 
# that cover each region

rm(list = ls())
graphics.off()

library(data.table)

#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there are two arguments: if not, return an error
if (length(args)!=2) {
  stop("Two arguments must be supplied: input bed file, output filenames file", call.=FALSE)
} 
# args <- c("../data/TTN_canonical_CDS_coordinates_GRCh38.rangefile", "../results/TTN_canonical_CDS_coordinates_GRCh38_ukb_wes_filenames.tsv")


### import ==========
dt_bed <- fread(args[1])
dt_map <- fread("../data/raw/wes_vcf_final_release_block_map.tsv")

### format =========

dt_bed <- dt_bed[,1:3]
colnames(dt_bed) <- c("chromosome", "start", "end")
dt_bed[start > end, `:=`(start = end, end = start)] # Swap 'start' and 'end' values in rows where 'start' is greater than 'end'

colnames(dt_map) <- c("filename", "chromosome", "block", "start", "end")

# set the keys
setkey(dt_bed, chromosome, start, end)
setkey(dt_map, chromosome, start, end)

# find overlapping rows in dt_map based on dt_ranges
overlapping_rows <- foverlaps(dt_bed, dt_map, type="any", which=TRUE)

# subset dt_map based on overlapping rows
dt_overlap <- dt_map[overlapping_rows$yid]
dt_overlap <- dt_overlap[complete.cases(dt_overlap)]
dt_overlap <- unique(dt_overlap)
dt_overlap <- dt_overlap[,"filename"]

### export ==========
fwrite(x = dt_overlap, file = args[2], col.names = FALSE, sep = "\t")

# ### alternate method ==========
# dt_overlap <- dt_map[dt_bed, 
#                      on = .(chromosome = chromosome,
#                             minPOS <= end,
#                             maxPOS >= start),
#                      nomatch = 0L,
#                      .(chromosome = i.chromosome, start = i.start, end = i.end, filename)]
# dt_overlap <- dt_overlap[order(start),]
# dt_filenames <- data.table(filenames = unique(dt_overlap$filename))




