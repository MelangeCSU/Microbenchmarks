#!/bin/bash

a=`hostname`
lab=`grep "$a" ~info/machines | awk '{print $7}'`
LOG=${a}.vecacc_malloc.log

NUM_THREADS=8 #default sun, pomegranates

if [[ $a == "apples" ]] 
then
	NUM_THREADS=4
elif [[ ${lab} == "120-unix-lab" ]] 
then
	NUM_THREADS=16
elif [[ $a == "phire" || $a == "jaguar" || $a == "bentley" || $a == "bugatti" || $a == "ferrari" ]] 
then
	NUM_THREADS=12
fi
echo "$a :: max threads: ${NUM_THREADS}"

#echo "tsse4"
#echo "====================tsse4" >> ${LOG}
#echo "====================tsse4" >> ${LOG}.comments

echo "LOG:: REPS ARRAY_SIZE #THREADS ======" >> ${LOG}.comments

FILE_NAME="vecacc_malloc.c"

#MAX_ITR = reps * array_len
MAX_ITR=8061452288


echo "vecaccmp"
echo "====================vecaccmp" >> ${LOG}
echo "====================vecaccmp" >> ${LOG}.comments
for (( ARRAY_SIZE=32; ARRAY_SIZE<=3000; ARRAY_SIZE=ARRAY_SIZE+32 ))
do 
	((REPS=${MAX_ITR}/${ARRAY_SIZE}))
	cp $FILE_NAME.P $FILE_NAME
	sed -i "s/__ARRAY_SIZE__/${ARRAY_SIZE}/g" $FILE_NAME
	sed -i "s/__REPS__/${REPS}/g" $FILE_NAME

	echo "LOG:: ${REPS} ${ARRAY_SIZE} ======" >> ${LOG}.comments
	make clean; make vecaccmp &>> ${LOG}.comments

	echo `date` ::: ${ARRAY_SIZE} ${REPS} >> ${LOG}.trace

	#for (( t=1; t<=${NUM_THREADS}; t=t*2 )) 
	for t in 1 2 6 12 
	do 
		#export OMP_NUM_THREADS=${t}
		echo "THREADS=${t}"
		echo "THREADS=${t}" >> ${LOG}

		for (( i=0; i<5; i++ )) 
		do 
			./vecaccmp ${t} ${REPS} &>> ${LOG}
		done
	done
done

echo "DONE" &>> ${LOG}
