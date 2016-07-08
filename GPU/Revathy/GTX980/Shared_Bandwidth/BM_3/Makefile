
##
## Create variables for use below
##
#CUDA_INSTALL_PATH := /usr/local/cuda-6.5
#SDK_INSTALL_PATH :=  /usr/local/cuda-4.2/sdk/C
#LIB       :=  -L$(SDK_INSTALL_PATH)/lib  #-lcutil_x86_64
#INCLUDES  :=  -I$(SDK_INSTALL_PATH)/common/inc
OPTIONS   :=  -O3 -arch=$(CUDA_ARCH) --ptxas-options -v --maxrregcount=255
KERNELOPTIONS := -Xptxas -dlcm=ca

EXECS := BW3
CODEGENS := KernelGen

#####################################################################

#Rules to create executables for Kernel Code Gen

all: $(EXECS)

#######################################################################
#Rules to make CUDA executables

BW3_kernel.o : BM_kernel.cu
	nvcc $< -c -o $@ $(OPTIONS) $(KERNELOPTIONS)

BW3 : BM_host.cu BW3_kernel.o
	nvcc $< BW3_kernel.o -o $@ $(OPTIONS)

#######################################################################
#Rules to generate kernel code

KernelGen : BM_kernel_gen.c
	gcc $< -o $@ -O3

#######################################################################
#Rules to clean executables

clean:
	rm -rf *.o $(EXECS)

clean-gens:
	rm $(CODEGENS)
