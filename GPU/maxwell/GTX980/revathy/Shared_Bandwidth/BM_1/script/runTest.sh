##############################
#Test parameters

runsPerCase=3
#Threads
Tlow=512
Thigh=512

#Blocks
Blow=32
Bhigh=32

#Iterations
Klow=4000000
Khigh=4000000

#ValuesPerThread
Xlow=2
#Xhigh=72

OBJ=BW1
CodeGen=KernelGen
KernelFile=BM_kernel.cu

unrollLow=2
unrollHigh=8
###############################

make clean > tmp.txt
make $CodeGen > tmp.txt


for(( t=Thigh;t>=Tlow;t/=2 ))
do
   for(( b=Blow;b<=Bhigh;b+=32 )) 
   do
      for(( k=Klow;k<=Khigh;k+=20000 ))
      do
	for(( x=Xlow;x<=4096/t;x+=1 ))
	do
	  for(( u=unrollLow;u<=unrollHigh;u+=1 ))
          do
	  rm $KernelFile
	  #Generate kernel code
             $CodeGen $x $k $b $t $u > $KernelFile

             make $OBJ &> tmp.txt
	  for(( i=0; i<runsPerCase; i++ ))
	  do
	     #Run current case
	     DATE=$(date)
	     #echo "$x $k $b $t $u ${DATE}" >> time.log 
	     #RESULT=$($OBJ $x $k $b $t)
	     $OBJ $x $k $b $t $u
	     #echo "${RESULT} $u"
#	     paste <($OBJ $x $k $b $t) <(echo $u)
	  done 
		
	  make clean > tmp.txt
	  done         	   
	done
      done
   done
done

rm -rf tmp.txt
