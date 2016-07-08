##############################
#Test parameters

runsPerCase=3
#Threads
Tlow=128
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

OBJ=BW4
CodeGen=KernelGen
KernelFile=BM_kernel.cu

depthLow=1
depthHigh=12

#unrollLow=2
#unrollHigh=8
###############################

make clean > tmp.txt
make $CodeGen > tmp.txt


for(( t=Thigh;t>=Tlow;t/=2 ))
do
   for(( b=Blow;b<=Bhigh;b+=32 )) 
   do
      for(( k=Klow;k<=Khigh;k+=20000 ))
      do
	for(( x=Xlow;x<=12288/t;x+=1 ))
	do
	  for(( d=depthLow;(d<=depthHigh)&&(x*d*t<=12288);d+=1 ))
          do
	  rm $KernelFile
	  #Generate kernel code
             $CodeGen $x $k $b $t $d 1 > $KernelFile

             make $OBJ &> tmp.txt
	  for(( i=0; i<runsPerCase; i++ ))
	  do
	     #Run current case
	     DATE=$(date)
	     #echo "$x $k $b $t $u ${DATE}" >> time.log 
	     #RESULT=$($OBJ $x $k $b $t)
	     $OBJ $x $k $b $t $d 1
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
