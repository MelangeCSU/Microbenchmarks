#Author : Swetha Varadarajan 

#Include and library paths

#SDK_INSTALL_PATH :=  /usr/local/cuda-6.5#/sdk/C
#LIB       :=  -L$(SDK_INSTALL_PATH)/lib  #-lcutil_x86_64
#INCLUDES  :=  -I$(SDK_INSTALL_PATH)/common/inc
OPTIONS   :=  -O3 --maxrregcount=124 --ptxas-options -v -arch=sm_13
OBJS = timer.o 
H_FILE = timer.h intmaxaddT4K.h
SEQFLAGS = -O3 
CC = gcc


# 2 executables
EXECS :=  intmaxaddT4CG intmaxaddT4
all:$(EXECS)

# Code generation for the Kernel
intmaxaddT4CG : intmaxaddT4CG.c
	gcc -o $@ $<

#Host and Kernel
timer.o: timer.c
	$(CC) $(SEQFLAGS) -o $@ -c timer.c
 
intmaxaddT4K.o : intmaxaddT4K.cu
	nvcc $< -c -o $@ $(OPTIONS)

intmaxaddT4 : intmaxaddT4.cu intmaxaddT4K.o $(OBJS) $(H_FILE) 
	nvcc $< intmaxaddT4K.o $(OBJS)-o $@  $(OPTIONS) 


#Utilities	
clean : 
	rm *.o $(EXECS)
version : 
	nvcc --version
