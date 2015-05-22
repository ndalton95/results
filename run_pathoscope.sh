#!/bin/bash

#Define pathoscope location
pathoscope=/Users/evan/apps/pathoscope2/pathoscope/./pathoscope.py

#Go to home directory:
cd /Users/jlab/nick/patho_practice

#Value Assignment
LIB_DIR='~evan/apps/genome_library'
TARGET='virus_nt_ti'
#FILTER=

### Download FASTQ, unzip, make smaller version (remove later)
# Now just download a single fastq file (change this later to loop over
# all files)

# cannot assign: FQ_DIR = "./*/*.fastq.gz"
cd /Volumes/My\ Book/RNA\ Data/20120920-W18987.FASTQs/


for FILE in ./*.fastq.gz

do
	echo 'Your file path is '$FILE
	NEW_FILE=$(basename $FILE)
	echo 'Your file is '$NEW_FILE
	echo 'copying' $NEW_FILE
	cp $NEW_FILE /Users/jlab/nick/patho_practice
	cd /Users/jlab/nick/patho_practice
	echo 'unzipping'
	gunzip $NEW_FILE
#Alignment
	echo 'beginning pathoMap'
LIB_DIR='~evan/apps/genome_library'
TARGET='virus_nt_ti'
#FILTER=	


	cp $FILE /Users/jlab/nick/patho_practice
	cd /Users/jlab/nick/patho_practice
	gunzip $FILE
	# header file for practice: head -2000 $FILE > $FILE_practice.fastq
	

# cp /Volumes/My\ Book/RNA\ Data/20120920-W18987.FASTQs/941017B-31_L7.LB27_2.fastq.gz 941017B-31_L7.LB27_2.fastq.gz #Nick note the backslashes in My\ Book and RNA\ DATA. these are needed in a directory name anytime you have spaces
# copies to correct folder under me
# gunzip -f 941017B-31_L7.LB27_2.fastq.gz # note: I added -f so it will overwrite existing destination file if it exists
# head -4000 941017B-31_L7.LB27_2.fastq > practice.fastq

### Run pathoscope:

# define variable: FILENAME = "[...].fastq.gz"
# pathoscope MAP -U $FILENAME [....] -expTag $FILENAME  # outputs fastq1.sam
#(without tag, outputs outalign.sam)

$pathoscope MAP -U practice.fastq -targetIndexPrefix virus_nt_ti -indexDir ~evan/apps/genome_library -btHome /Users/evan/apps/bowtie2-2.1.0/

# pathoscope ID -alignFile [$FILENAME.sam] --noUpdatedAlign [?? checkthis]
# -expTag [add tag]

$pathoscope ID -alignFile outalign.sam --noUpdatedAlignFile

### move a .tsv file to a results folder. remove anything except the
#.tsv file.

cp pathoid-sam-report.tsv /Users/jlab/nick/patho_practice/results

cd /Users/jlab/nick/patho_practice/results

git add pathoid-sam-report.tsv

git commit -m 'practice pathscope report by script'

git push origin master

cd ..

rm 941017B-31_L7.LB27_2.fastq practice.fastq outalign.sam
