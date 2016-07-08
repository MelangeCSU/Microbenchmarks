
##
## Create variables for use below
##
#CUDA_INSTALL_PATH := /usr/local/cuda-6.5
SDK_INSTALL_PATH :=  /usr/local/cuda-4.2/sdk/C
LIB       :=  -L$(SDK_INSTALL_PATH)/lib 
INCLUDES  :=  -I$(SDK_INSTALL_PATH)/common/inc
OPTIONS   :=  -O3 -arch=$(CUDA_ARCH) --ptxas-options -v --maxrregcount=63 -Xptxas -dlcm=ca

EXECS := BWTest
CODEGENS := KernelGen

#####################################################################

#Rules to create executables for Kernel Code Gen

all: $(EXECS)

#######################################################################
#Rules to make CUDA executables

BW_kernel.o : BM_kernel.cu
	nvcc $< -c -o $@ $(OPTIONS)

BWTest : BM_host.cu BW_kernel.o
	nvcc $< BW_kernel.o -o $@ $(OPTIONS)
	
#######################################################################
#Rules to generate kernel code

KernelGen : BM_kernel_gen.c
	gcc $< -o $@ -O3
	
#######################################################################
#Rules to clean executables

clean:
	rm *.o $(EXECS)
	
clean-gens:
	rm $(CODEGENS)
