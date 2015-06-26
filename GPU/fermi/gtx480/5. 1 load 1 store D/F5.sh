
for x in 1 2 3 4 5 6 7 8 9 10
        do
                echo "x=",$x
                make intmaxaddF5CG
		./intmaxaddF5CG $x 800000 30 320 > intmaxaddF5K.cu
		make clean
		make intmaxaddF5
		./intmaxaddF5 $x 800000 30 320
        done

done

