
for x in 1 2 3 4 5 6 7 8 9 10
        do
                echo "x=",$x
                make intmaxaddF1CG
		./intmaxaddF1CG $x 800000 465 256 > intmaxaddF1K.cu
		make clean
		make intmaxaddF1
		./intmaxaddF1 $x 800000 465 256
        done

done

