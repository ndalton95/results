#!/bin/bash

#Define pathoscope location
pathoscope="/Users/evan/apps/pathoscope2/pathoscope/./pathoscope.py"

LIB_DIR="~evan/apps/genome_library"  ## I moved these out of your loop because they are always the same!
TARGET="virus_nt_ti,fungi_nt_ti,bacteria_nt_ti_0,bacteria_nt_ti_1,bacteria_nt_ti_2" ## added fungi and bacteria to the targets
FILTER="human_nt_ti_0,human_nt_ti_1" ## add Human as a filter
BT_HOME="/Users/evan/apps/bowtie2-2.1.0/"


cd /Volumes/My\ Book/RNA\ Data/20120920-W18987.FASTQs

for FILE in ./*.fastq.gz
do 
	echo 'Your file path is '$FILE
	NEW_FILE=$(basename $FILE)
	echo 'Your file is '$NEW_FILE
	echo 'copying' $NEW_FILE
	cp $NEW_FILE /Users/jlab/nick/patho_practice
	cd /Users/jlab/nick/patho_practice
	echo 'unzipping'
	gunzip -f $NEW_FILE
	echo 'unzipped successfully'
	UNZIP_FILE=${NEW_FILE//.gz}
	echo $UNZIP_FILE

	# PathoMap
	
	head -400 $UNZIP_FILE > shortened.fastq # to check faster
	
	echo "beginning PathoMAP"
	OUT_FILE=${UNZIP_FILE//.fastq}.sam
	echo $OUT_FILE
	
	$pathoscope MAP -U shortened.fastq -targetIndexPrefix $TARGET -filterIndexPrefix $FILTER -indexDir $LIB_DIR -btHome $BT_HOME -outAlign $OUT_FILE ## add a 
	# change "shortened.fastq" to actual file($UNZIP_FILE) after testing

	# PathoID

	#echo "beginning PathoID"
	#pathoscope ID -alignFile $OUT_FILE -outDir --noUpdatedAlignFile

	cd /Volumes/My\ Book/RNA\ Data/20120920-W18987.FASTQs #Last line


	
done

