#!/bin/bash

a=`hostname`
LOG=${a}.vecadd.log

NUM_THREADS=8 #default

if [[ $a == "sun" ]] 
then
	NUM_THREADS=8
elif [[ $a == "apples" ]] 
then
	NUM_THREADS=4
elif [[ $a == "concord" || $a == "eggs" || $a == "charleston" ]] 
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


FILE_NAME="vecadd.c"

MAX_ITR=32000000

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


echo "vecaddp"
echo "====================vecaddp" >> ${LOG}
echo "====================vecaddp" >> ${LOG}.comments
for (( j=8; j<=1360; j=j+8 ))
do 
	((REPS=${MAX_ITR}*512/${j}))
	cp $FILE_NAME.P $FILE_NAME
	sed -i "s/__ARRAY_SIZE__/${j}/g" $FILE_NAME
	sed -i "s/__REPS__/${REPS}/g" $FILE_NAME

	echo "LOG:: ${REPS} ${j} ======" >> ${LOG}.comments
	make clean; make vecaddp &>> ${LOG}.comments

#	for (( t=1; t<=${NUM_THREADS}; t=t+7 )) 
	for t in 1 4 8 12 16 
	do 
		#export OMP_NUM_THREADS=${t}
		echo "THREADS=${t}"
		echo "THREADS=${t}" >> ${LOG}

		for (( i=0; i<5; i++ )) 
		do 
			./vecaddp ${t} ${REPS} &>> ${LOG}
		done
	done
done
