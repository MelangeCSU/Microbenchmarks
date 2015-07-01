#15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240
for x in 255 270 285 300 315 330 345 360 375 390 405 420 435 450 465 480
do
	for y in 32 64 96 128 160 192 224 256 288 320 352 384 416 448 480 512 544
	do
		echo "x=",$x
		echo "y=",$y
	        make intmaxaddF2CG
		./intmaxaddF2CG 6 40000 $x $y > intmaxaddF2K.cu
		make clean
		make intmaxaddF2
		./intmaxaddF2 6 40000 $x $y
	done
done
