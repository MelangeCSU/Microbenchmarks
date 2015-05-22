###
### Author: Revathy
### Created: 2015-05-06
###

##
## Create variables for use below
##
#CUDA_INSTALL_PATH := /usr/local/cuda-6.5
SDK_INSTALL_PATH :=  /usr/local/cuda-4.2/sdk/C
LIB       :=  -L$(SDK_INSTALL_PATH)/lib  #-lcutil_x86_64
INCLUDES  :=  -I$(SDK_INSTALL_PATH)/common/inc
OPTIONS   :=  -O3 -arch=$(CUDA_ARCH) --ptxas-options -v --maxrregcount=124

#Variables
CODEGENS := CodeGenIntMax CodeGenIntSharedAllMax

EXECS := intMaxAdd intMaxAddSharedAll

#####################################################################

#Rules to create executables for Kernel Code Gen

all: $(EXECS)

allCodeGens: $(CODEGENS)

CodeGenIntMax : CodeGenInt_max.c
	gcc -o $@ $<

CodeGenIntSharedAllMax: CodeGenIntSharedAll_max.c
	gcc -o $@ $<

#######################################################################
#Rules to make CUDA executables

intKernelMax.o : intKernelMax.cu
	nvcc $< -c -o $@ $(OPTIONS)

intMaxAdd : intHostMax.cu intMax.h intKernelMax.o
	nvcc $< intKernelMax.o -o $@ $(OPTIONS)  #$(LIB) $(INCLUDES)

intKernelMaxSharedAll.o : intKernelMaxSharedAll.cu
	nvcc $< -c -o $@ $(OPTIONS)

intMaxAddSharedAll : intHostMax2.cu intMax.h intKernelMaxSharedAll.o
	 nvcc $< intKernelMaxSharedAll.o -o $@ $(OPTIONS)  #$(LIB) $(INCLUDES)

#######################################################################
#Rules to clean executables

clean:
	rm *.o $(EXECS)

clean-codeGens:
	rm $(CODEGENS)
