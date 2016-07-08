##############################
#Test parameters

runsPerCase=3
#Threads
Tlow=64
Thigh=256

#Blocks
Blow=30
Bhigh=300

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

   for(( b=Blow;b<=Bhigh;b+=30 )) 
   do
      for(( t=Tlow;t<=Thigh;t*=2 ))
      do
	for(( x=1024/$t;x<=200000/$t;x+=1024 ))
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
