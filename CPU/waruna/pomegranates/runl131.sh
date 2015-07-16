#!/bin/bash

a=`hostname`
LOG=${a}.tsse4l131.log

NUM_THREADS=8 #default

if [[ $a == "sun" ]] 
then
	NUM_THREADS=8
elif [[ $a == "apples" ]] 
then
	NUM_THREADS=4
elif [[ $a == "concord" || $a == "eggs" ]] 
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

echo "tsse4"
echo "====================tsse4" >> ${LOG}
echo "====================tsse4" >> ${LOG}.comments

echo "LOG:: REPS ARRAY_SIZE #THREADS ======" >> ${LOG}.comments


FILE_NAME="testSSE4L1.2.c"

MAX_ITR=64000000000

echo "LOG:: ${REPS} ${j} 1 ======" >> ${LOG}.comments
make clean; make tsse4l131 &>> ${LOG}.comments

for (( w=16; w<=50; w=w+1 ))
do 
	for (( j=4; j<=24; j=j+1 ))
	do 
		((N=${j}*${w}*2))
		if [ ${N} -gt 1540 ]
		then
			break
		fi
		((REPS=${MAX_ITR}/(${N}/(${w}*2) - 1)))

		echo "REPS: ${REPS}"
exit
		for (( i=0; i<5; i++ )) 
		do 
			./tsse4l131 1 ${w} ${N} ${REPS} &>> ${LOG}
		done
	done
done


echo "tsse4p"
echo "====================tsse4p" >> ${LOG}
echo "====================tsse4p" >> ${LOG}.comments
echo "LOG:: ${REPS} ${j} ======" >> ${LOG}.comments
make clean; make tsse4l131p &>> ${LOG}.comments

for (( w=16; w<=50; w=w+1 ))
do 
		for (( j=64; j<=1536; j=j+64 ))
		do 
		((N=${j}*${w}*2))
		if [ ${N} -gt 1540 ]
		then
			break
		fi
		((REPS=${MAX_ITR}*((${N}/(${w}*2))-1)))

		for (( t=1; t<=${NUM_THREADS}; t++ )) 
		do 
			echo "THREADS=${t}"
			echo "THREADS=${t}" >> ${LOG}

			for (( i=0; i<5; i++ )) 
			do 
				./tsse4l131p ${t} ${w} ${N} ${REPS} &>> ${LOG}
			done
		done
	done
done
