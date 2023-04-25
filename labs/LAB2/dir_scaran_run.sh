#!/bin/bash
#trap read debug
shopt -s extglob


INIT_DIR=$(pwd)
echo $INIT_DIR
TARGET_DIR=$1
echo "Target Dir: $TARGET_DIR"

cd "${TARGET_DIR}";


for file in $TARGET_DIR/*;
do
	echo $file;
	if [[ -d $file && -d $file/raw ]]; then
		cd $file
		for trace_file in $file/trace/*;
		do
			TRACE_FILE=$trace_file;		
		done
		echo $TRACE_FILE
		RAW_FOLDER="${file}/raw/";	
		echo $RAW_FOLDER
		NAME=$(echo $file | awk -F . '{ print $2 }')
		echo $NAME
		cd $INIT_DIR
		pwd 
		ls
		bash ./scarab_run.sh $NAME $TRACE_FILE $RAW_FOLDER true
	else 
		echo "not a valid directory"
	fi
done


cd $INIT_DIR


