#!/bin/bash

a=`hostname`
LOG=${a}.tsse4l12_rest.log

NUM_THREADS=8 #default

if [[ $a == "sun" ]] 
then
	NUM_THREADS=8
elif [[ $a == "apples" ]] 
then
	NUM_THREADS=4
elif [[ $a == "concord" || $a == "eggs" || $a == "columbus" ]] 
then
	NUM_THREADS=16
elif [[ $a == "phire" ]] 
then
	NUM_THREADS=12
elif [[ $a == "pomegranates" ]] 
then
	NUM_THREADS=8
fi
echo "$a :: max threads: ${NUM_THREADS}"

#echo "tsse4"
#echo "====================tsse4" >> ${LOG}
#echo "====================tsse4" >> ${LOG}.comments

echo "LOG:: REPS ARRAY_SIZE #THREADS ======" >> ${LOG}.comments


FILE_NAME="testSSE4L1.2.c"

MAX_ITR=32000000000

#for (( j=1600; j<=34816; j=j+64 ))
#do 
#	((REPS=${MAX_ITR}/${j}))
#	cp $FILE_NAME.P $FILE_NAME
#	sed -i "s/__ARRAY_SIZE__/${j}/g" $FILE_NAME
#	sed -i "s/__REPS__/${REPS}/g" $FILE_NAME
#
#	echo "LOG:: ${REPS} ${j} 1 ======" >> ${LOG}.comments
#	make clean; make tsse4l12 &>> ${LOG}.comments
#
#	for (( i=0; i<5; i++ )) 
#	do 
#		./tsse4l12 &>> ${LOG}
#	done
#done


echo "tsse4p"
echo "====================tsse4p" >> ${LOG}
echo "====================tsse4p" >> ${LOG}.comments
for (( j=34816; j>=1600; j=j-64 ))
do 
	((REPS=${MAX_ITR}/${j}))
	cp $FILE_NAME.P $FILE_NAME
	sed -i "s/__ARRAY_SIZE__/${j}/g" $FILE_NAME
	sed -i "s/__REPS__/${REPS}/g" $FILE_NAME

	echo "LOG:: ${REPS} ${j} ======" >> ${LOG}.comments
	make clean; make tsse4l12p &>> ${LOG}.comments

	for (( t=1; t<=${NUM_THREADS}; t++ )) 
	do 
		#export OMP_NUM_THREADS=${t}
		echo "THREADS=${t}"
		echo "THREADS=${t}" >> ${LOG}

		for (( i=0; i<5; i++ )) 
		do 
			./tsse4l12p ${t} &>> ${LOG}
		done
	done
done
