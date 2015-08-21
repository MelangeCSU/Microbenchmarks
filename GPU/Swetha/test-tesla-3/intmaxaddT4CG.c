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
	//int sl = atoi(argv[5]);
	//int vectorSize = sl * gridDim * blockDim;
	//int blockSize = sl * blockDim;
	//int N=Nn*blockDim;
	int N=120000/gridDim;
	//printf("blocksize=%d\n",blockSize);
	printf("__global__ void IntmaxaddT4(int* C, int k, int sl)\n{\n");
	printf("\n\n");
	printf("\tint i,t;\n");
	printf("\tint a=0,a2=0,b=2;\n");
	//printf("\tint sharedsize=%d;\n",N);
	printf("\tint N=120000/gridDim.x;\n");
	printf("\tint blockStartIndex  = blockIdx.x * N;\n");
	printf("\tint threadStartIndex = blockStartIndex + threadIdx.x ;\n");
	printf("\tint threadEndIndex   = blockStartIndex + N;\n");
	printf("\t__shared__ int c[%d];//array count=N\n",N);
	printf("\n\n");

    	printf("\tint count=0;\n");
	printf("\t#pragma unroll\n");
	printf("\tfor(i = threadStartIndex; i < threadEndIndex; i+=sl){\n");
	printf("\t\tc[threadIdx.x+count]=C[threadIdx.x+i];\n\tcount+=sl;}\n");

	printf("\tfor (t = 0; t < k; t++) {\n");
	printf("\t\ta=max(a,c[threadIdx.x]+10);\n\t\t#pragma unroll\n");


	//printf("\t\tfor (i = 0; i < count; i++){\n");
	printf("\t\tfor(i = threadIdx.x; i < (threadIdx.x+count); i+=sl){\n");
	printf("\t\ta2=c[i];c[i] = max(a,(c[i]+b));a=a2;\n\t}}\n");
	
	
	printf("\tcount=0;\n");
	printf("\n\t#pragma unroll\n");
	printf("\tfor(i = threadStartIndex; i < threadEndIndex; i+=sl){\n");
	printf("\t\tC[threadIdx.x+i]=c[threadIdx.x+count];\n\tcount++;}\n");
	printf("\n\n}\n");
	
	
	return 1;
}
