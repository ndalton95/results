#!/bin/bash

#Define pathoscope location
pathoscope="/Users/evan/apps/pathoscope2/pathoscope/./pathoscope.py"

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
	LIB_DIR="~evan/apps/genome_library"
	TARGET="virus_nt_ti"
	BT_HOME="/Users/evan/apps/bowtie2-2.1.0/"
	
	$pathoscope MAP -U shortened.fastq -targetIndexPrefix $TARGET -indexDir $LIB_DIR -btHome $BT_HOME -outAlign $OUT_FILE
	# change "shortened.fastq" to actual file($UNZIP_FILE) after testing

	# PathoID

	#echo "beginning PathoID"
	#pathoscope ID -alignFile $OUT_FILE -outDir --noUpdatedAlignFile

	cd /Volumes/My\ Book/RNA\ Data/20120920-W18987.FASTQs #Last line


	
done

