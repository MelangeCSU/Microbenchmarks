###
### Author: Revathy
### Created: 2015-05-06
###

##
## Create variables for use below
##
#CUDA_INSTALL_PATH := /usr/local/cuda-6.5
SDK_INSTALL_PATH :=  /usr/local/cuda4/sdk/C
LIB       :=  -L$(SDK_INSTALL_PATH)/lib  -lcutil_x86_64
INCLUDES  :=  -I$(SDK_INSTALL_PATH)/common/inc
OPTIONS   :=  -O3 -arch=$(CUDA_ARCH) --ptxas-options -v --maxrregcount=124

#Variables
CODEGENS := CodeGenIntMax

EXECS := intMaxAdd

#####################################################################

#Rules to create executables for Kernel Code Gen

all: $(EXECS)

allCodeGens: $(CODEGENS)

CodeGenIntMax : CodeGenInt_max.c
	gcc -o $@ $<

#######################################################################
#Rules to make CUDA executables

intKernelMax.o : intKernelMax.cu
	nvcc $< -c -o $@ $(OPTIONS)

intMaxAdd : intHostMax.cu intMax.h intKernelMax.o
	nvcc $< intKernelMax.o -o $@ $(LIB) $(INCLUDES) $(OPTIONS)

#######################################################################
#Rules to clean executables

clean:
	rm *.o $(EXECS)

clean-codeGens:
	rm $(CODEGENS)
