
for x in 1 2 3 4 5 6 7 8 9 10
        do
                echo "x=",$x
                make intmaxaddF3CG
		./intmaxaddF3CG $x 800000 165 288 > intmaxaddF3K.cu
		make clean
		make intmaxaddF3
		./intmaxaddF3 $x 800000 165 288
        done

done

