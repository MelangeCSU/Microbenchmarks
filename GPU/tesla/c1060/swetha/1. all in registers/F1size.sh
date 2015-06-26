#for x in 15 30 45 60 75 90 105 120 
#do
#	for y in 32 64 96 128 160 192 224 
#	do
#		echo "x=",$x
#		echo "y=",$y
#	        make intmaxaddF1CG
#		./intmaxaddF1CG 6 40000 $x $y > intmaxaddF1K.cu
#		make clean
#		make intmaxaddF1
#		./intmaxaddF1 6 40000 $x $y
#	done
#done
#135 150 165 180 195 210 225 240
#405 420 435 450 465 480
#255 270 285 300 315 330 345 360 375 390 
#32 64 96 128 160 192 224 


#512 480
#448 672 896

for x in 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405 420 435 450 465 480
do
	echo "x=",$x
	make intmaxaddF1CG
	./intmaxaddF1CG 6 40000 $x 256 > intmaxaddF1K.cu
	make clean
	make intmaxaddF1
	./intmaxaddF1 6 40000 $x 256
done
#done
