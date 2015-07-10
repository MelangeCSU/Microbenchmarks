/*Author: Swetha Varadarajan 7/1/2015
Adapted from Waruna Ranasinghe's summer 2014 work on kpdp micro-benchmarking
Changed made:
	1. Float to int datatype. 
	2. Changed Kernel name.
	3. Commented max definition.
	4. All the 2 inputs and 1 ouput are in registers. 
	5. Operation is op= a max (b+c); where op=a/b/c.
		op,a and first dimension of c are to have same index(i). 
		b and second dimension of c is x-i-1.
		where x is the Values per thread.
	   This arrangement is to ensure that the compiler doesn't optimize any operation. 
	   (check the associated .ptx) 
*/

#include <stdio.h>
#include "math.h"

int main(int argc, char** argv) {
	int i,j,k;
	int sl = atoi(argv[1]);
	int iterations = atoi(argv[2]);
	int gridDim = atoi(argv[3]);
	int blockDim = atoi(argv[4]);
	int vectorSize = sl * gridDim * blockDim;
	int blockSize = sl * blockDim;

	//printf("blocksize=%d\n",blockSize);
	printf("__global__ void IntmaxaddT4(int* C, int k, int sl, int sharedsize)\n{\n");
	printf("\n\n");
	printf("\tint i,t;\n");
	printf("\tint a=0,a2=0,b=02;\n");
	printf("\tint blockStartIndex  = blockIdx.x * blockDim.x * sharedsize;\n");
	printf("\tint threadStartIndex = blockStartIndex + threadIdx.x ;\n");
	printf("\t__shared__ int c[4000];\n");
	printf("\n\n");

    
	printf("\t#pragma unroll\n");
	printf("\tfor(i = threadStartIndex; i < sharedsize; i+=sl)\n");
	printf("\t\tc[threadIdx.x+i]=C[threadIdx.x+i];\n\n");

	printf("\tfor (t = 0; t < k; t++) {\n");
	printf("\t\ta=max(a,c[threadIdx.x]+10);\n\t\t#pragma unroll\n");


	printf("\t\tfor (i = threadStartIndex+sl; i < sharedsize; i+=sl){\n");
	printf("\t\ta2=c[i];c[i] = max(a,(c[i]+b));a=a2;\n\t}}\n");
	
	
	
	printf("\n\t#pragma unroll\n");
	printf("\tfor(i = threadStartIndex; i < sharedsize; i+=sl)\n");
	printf("\t\tC[threadIdx.x+i]=c[threadIdx.x+i];\n\n");
	printf("\n\n}\n");
	
	
	return 1;
}
