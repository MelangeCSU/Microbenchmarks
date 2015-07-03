#x=,435
#y=,160
for x in 1 2 3 4 5 6 7 8 9 10
        do
                echo "x=",$x
                make intmaxaddF4CG
		./intmaxaddF4CG $x 800000 435 160 > intmaxaddF4K.cu
		make clean
		make intmaxaddF4
		./intmaxaddF4 $x 800000 435 160
        done

done

