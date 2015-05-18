#!/bin/bash

### Download FASTQ, unzip, make smaller version (remove later)
# Now just download a single fastq file (change this later to loop over all file
s)
#cd /Volummes/[...]/[...].fastq.gz [...].fastq.gz
# gunzip [...].fastq.gz

cp  941017B-31_L7.LB27_2.fastq.gz /Users/jlab/nick/patho_practice
# copies file to my pathoscope practice folder

gunzip 941017B-31_L7.LB27_2.fastq.gz

head -4000 941017B-31_L7.LB27_2.fastq > practice.fastq
# makes header file with first 1000 reads from sample fastq file

### Run pathoscope:

# define variable: FILENAME = "[...].fastq.gz"
#pathoscope MAP -U $FILENAME [....] -expTag $FILENAME  # outputs fastq1.sam (wit
hout tag, outputs outalign.sam)

pathoscope MAP -U practice.fastq -targetIndexPrefix virus_nt_ti
-indexDir ~evan/apps/genome_library -btHome /Users/evan/apps/bowtie2-2.1.0/

#pathoscope ID -alignFile [$FILENAME.sam] --noUpdatedAlign [?? check this] -expT
ag [add tag]

pathoscope ID -alignFile outalign.sam --noUpdatedAlignFile


### move a .tsv file to a results folder. remove anything except the .tsv file.

