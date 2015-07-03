#Author : Swetha Varadarajan 

#Include and library paths

#SDK_INSTALL_PATH :=  /usr/local/cuda-6.5#/sdk/C
#LIB       :=  -L$(SDK_INSTALL_PATH)/lib  #-lcutil_x86_64
#INCLUDES  :=  -I$(SDK_INSTALL_PATH)/common/inc
OPTIONS   :=  -O3 --maxrregcount=124 --ptxas-options -v -arch=sm_21
OBJS = timer.o 
H_FILE = timer.h intmaxaddF3K.h
SEQFLAGS = -O3 
CC = gcc


# 2 executables
EXECS :=  intmaxaddF3CG intmaxaddF3
all:$(EXECS)

# Code generation for the Kernel
intmaxaddF3CG : intmaxaddF3CG.c
	gcc -o $@ $<

#Host and Kernel
timer.o: timer.c
	$(CC) $(SEQFLAGS) -o $@ -c timer.c
 
intmaxaddF3K.o : intmaxaddF3K.cu
	nvcc $< -c -o $@ $(OPTIONS)

intmaxaddF3 : intmaxaddF3.cu intmaxaddF3K.o $(OBJS) $(H_FILE) 
	nvcc $< intmaxaddF3K.o $(OBJS)-o $@  $(OPTIONS) 


#Utilities	
clean : 
	rm *.o $(EXECS)
version : 
	nvcc --version
