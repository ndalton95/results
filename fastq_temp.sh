#!/bin/bash

#Define pathoscope location
pathoscope="/Users/evan/apps/pathoscope2/pathoscope/./pathoscope.py"

LIB_DIR="~evan/apps/genome_library"  ## I moved these out of your loop because they are always the same!
TARGET="virus_nt_ti,fungi_nt_ti,bacteria_nt_ti_0,bacteria_nt_ti_1,bacteria_nt_ti_2" ## added fungi and bacteria to the targets
FILTER="human_nt_ti_0,human_nt_ti_1" ## add Human as a filter
BT_HOME="/Users/evan/apps/bowtie2-2.1.0/"


cd /Volumes/My\ Book/RNA\ Data/20120920-W18987.FASTQs

for FILE in ./*_1.clipped.fastq.gz	#FOR CLIPPED FILES
#for FILE in ./*_1.fastq.gz	#FOR UNCLIPPED FILES
do 
	echo 'Your file path is '$FILE
	FILE_ONE=$(basename $FILE)
	FILE_TWO=${FILE_ONE//_1*}_2.clipped.fastq.gz	#FOR CLIPPED FILES
	#FILE_TWO=${FILE_ONE//_1*}_2.fastq.gz	#FOR UNCLIPPED FILES
	echo 'Your file one is '$FILE_ONE
	echo 'your file two is '$FILE_TWO
	echo 'copying both' $FILE_ONE $FILE_TWO

	cp $FILE_ONE /Users/jlab/nick/patho_practice
	cp $FILE_TWO /Users/jlab/nick/patho_practice

	cd /Users/jlab/nick/patho_practice
	echo 'unzipping'
	gunzip -f $FILE_ONE
	gunzip -f $FILE_TWO
	echo 'unzipped successfully'
	
	UNZIP_FILE_ONE=${FILE_ONE//.gz}
	UNZIP_FILE_TWO=${FILE_TWO//.gz}
	echo $UNZIP_FILE_ONE
	echo $UNZIP_FILE_TWO	

	# PathoMap
	
	#head -400 $UNZIP_FILE > shortened.fastq # to check faster
	
	echo "beginning PathoMAP"
	OUT_FILE=${FILE_ONE//_1*}.sam
	echo $OUT_FILE
	
	$pathoscope MAP -1 $UNZIP_FILE_ONE -2 $UNZIP_FILE_TWO -targetIndexPrefix $TARGET -filterIndexPrefix $FILTER -indexDir $LIB_DIR -btHome $BT_HOME -outAlign $OUT_FILE -expTag ${FILE_ONE//_1*} 
	
	# PathoID

	echo "beginning PathoID"
	$pathoscope ID -alignFile $OUT_FILE -expTag ${FILE_ONE//_1*} --noUpdatedAlignFile
	
	# Moving tsv to results
	mv *.tsv results/
	
	# Removing Files
	rm $UNZIP_FILE_ONE
	rm $UNZIP_FILE_TWO
	rm *.sam
	
	cd /Volumes/My\ Book/RNA\ Data/20120920-W18987.FASTQs #Last line

done

