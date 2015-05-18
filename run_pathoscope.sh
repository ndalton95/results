### Download FASTQ, unzip, make smaller version (remove later)
# Now just download a single fastq file (change this later to loop over all file
s)
#cd /Volummes/[...]/[...].fastq.gz [...].fastq.gz
# gunzip [...].fastq.gz

### Run pathoscope:

# define variable: FILENAME = "[...].fastq.gz"
#pathoscope MAP -U $FILENAME [....] -expTag $FILENAME  # outputs fastq1.sam (wit
hout tag, outputs outalign.sam)


#pathoscope ID -alignFile [$FILENAME.sam] --noUpdatedAlign [?? check this] -expT
ag [add tag]

### move a .tsv file to a results folder. remove anything except the .tsv file.

