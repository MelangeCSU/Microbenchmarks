#Author : Swetha Varadarajan 

#Include and library paths

#SDK_INSTALL_PATH :=  /usr/local/cuda-6.5#/sdk/C
#LIB       :=  -L$(SDK_INSTALL_PATH)/lib  #-lcutil_x86_64
#INCLUDES  :=  -I$(SDK_INSTALL_PATH)/common/inc
OPTIONS   :=  -O3 --maxrregcount=124 --ptxas-options -v -arch=sm_21
OBJS = timer.o 
H_FILE = timer.h intmaxaddF4K.h
SEQFLAGS = -O3 
CC = gcc


# 2 executables
EXECS :=  intmaxaddF4CG intmaxaddF4
all:$(EXECS)

# Code generation for the Kernel
intmaxaddF4CG : intmaxaddF4CG.c
	gcc -o $@ $<

#Host and Kernel
timer.o: timer.c
	$(CC) $(SEQFLAGS) -o $@ -c timer.c
 
intmaxaddF4K.o : intmaxaddF4K.cu
	nvcc $< -c -o $@ $(OPTIONS)

intmaxaddF4 : intmaxaddF4.cu intmaxaddF4K.o $(OBJS) $(H_FILE) 
	nvcc $< intmaxaddF4K.o $(OBJS)-o $@  $(OPTIONS) 


#Utilities	
clean : 
	rm *.o $(EXECS)
version : 
	nvcc --version
