
for x in 1 2 3 4 5 6 7 8 9 10
        do
                echo "x=",$x
                make intmaxaddF2CG
		./intmaxaddF2CG $x 800000 165 288 > intmaxaddF2K.cu
		make clean
		make intmaxaddF2
		./intmaxaddF2 $x 800000 165 288
        done

done

