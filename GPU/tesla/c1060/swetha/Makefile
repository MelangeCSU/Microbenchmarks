#Adapted from last summer work. 

#Include and library paths
#CUDA_INSTALL_PATH := /usr/local/cuda-6.5
SDK_INSTALL_PATH :=  /usr/local/cuda4/sdk/C
LIB       :=  -L$(SDK_INSTALL_PATH)/lib  -lcutil_x86_64
INCLUDES  :=  -I$(SDK_INSTALL_PATH)/common/inc
OPTIONS   :=  -O3 --maxrregcount=124 --ptxas-options -v -arch=sm_13


# 2 executables
EXECS :=  vecmultCodeGen vecmult00
all:$(EXECS)

# Code generation for the Kernel
vecmultCodeGen : vecmultCodeGen.c
	gcc -o $@ $<

#Host and Kernel 
vecmultKernel00.o : vecmultKernel00.cu
	nvcc $< -c -o $@ $(OPTIONS)
vecmult00 : vecmult.cu vecmultKernel.h vecmultKernel00.o
	nvcc $< vecmultKernel00.o -o $@ $(LIB) $(INCLUDES) $(OPTIONS)

#Utilities	
clean : 
	rm *.o $(EXECS)
version : 
	nvcc --version
