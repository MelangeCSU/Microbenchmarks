##############################
#Test parameters

runsPerCase=3
#Threads
Tlow=256
Thigh=256

#Blocks
Blow=90
Bhigh=120

#ValuesPerThread
Xlow=4
Xhigh=50

OBJ=BWTest
CodeGen=KernelGen
KernelFile=BM_kernel.cu

###############################

make clean > tmp.txt
make $CodeGen > tmp.txt


#let m=0

   for(( b=Blow;b<=Bhigh;b+=16 )) 
   do
      for(( t=Tlow;t<=Thigh;t*=2 ))
      do
	for(( x=4096/$t;x<=300000/$t;x+=(1024/$t) ))
	do
	  rm $KernelFile
	  #Generate kernel code
             $CodeGen $x $b $t > $KernelFile
             make $OBJ > tmp.txt
	  for(( i=0; i<runsPerCase; i++ ))
	  do
	     #Run current case
	     $OBJ $x $b $t
	  done 
		
	  make clean > tmp.txt         	   
	done
      done
   done


rm tmp.txt
