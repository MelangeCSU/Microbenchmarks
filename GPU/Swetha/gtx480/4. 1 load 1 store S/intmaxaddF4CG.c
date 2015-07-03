/*Author: Swetha Varadarajan 6/10/2015
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

int main(int argc, char** argv) {
	int i,j,k;
	int x = atoi(argv[1]);
	int iterations = atoi(argv[2]);
	int gridDim = atoi(argv[3]);
	int blockDim = atoi(argv[4]);
	int vectorSize = x * gridDim * blockDim;
	int blockSize = x * blockDim;
	int size_A = blockDim * x;
	int size_B = gridDim * x;
	
	printf("/*Author: Swetha Varadarajan 6/10/2015\n Adapted from Waruna Ranasinghe's summer 2014 work on kpdp micro-benchmarking \n Code generated from intmazaddF4CG.c \n Parameters list\n");
	printf("size of A = %d\n    size of B = %d\n    gridDim = %d\n    blockDim = %d\n    Iterations k= %d\n   Values per thread x = %d\n*/\n\n", size_A, size_B, gridDim, blockDim, iterations, x);

	//printf("#define max(x,y)   ((x)>(y) ? (x) : (y))\n");

	printf("__global__ void IntmaxaddF4(const int* A, const int* B, int* C, int x, int k)\n{\n");
	printf("\tint B_start_index = (blockIdx.x*gridDim.y + blockIdx.y)*x;\n");
	printf("\tint A_start_index = (threadIdx.x*blockDim.y + threadIdx.y)*x;\n");
	printf("\tint C_width = x*gridDim.x*gridDim.y;\n");
  	
	printf("\n\n");
	
	printf("\tint i,j,t;\n");

	//printf("\tint ");
	/*for (i = 0; i < x; i++) {
		for (j = 0; j < x; j++) {
			if (i == x - 1 && j == x - 1) {
				printf("c_%d_%d;\n",i,j);
			} else {
				printf("c_%d_%d, ",i,j);
			}
		}
	}*/

	printf("\t__shared__ int c[%d][%d][%d];\n",blockDim,x,x);

	printf("\tint ");
   	for (i = 0; i < x; i++) {
		if (i == x - 1) {
			printf("a_%d;\n",i);
		} else {
			printf("a_%d, ",i);
		}
	}

	printf("\tint ");
    	for (i = 0; i < x; i++) {
		if (i == x - 1) {
			printf("b_%d;\n",i);
		} else {
			printf("b_%d, ",i);
		}
    	}
	printf("\n\n");

    	for (i = 0; i < x; i++) {
		printf("\ta_%d = A[A_start_index+%d];\n",i,i);
    	}
	printf("\n\n");

    	for (i = 0; i < x; i++) {
		printf("\tb_%d = B[B_start_index+%d];\n",i,i);
  	}
	printf("\n\n");

    	/*for (i = 0; i < x; i++) {
    		for (j = 0; j < x; j++) {
			printf("\tc_%d_%d = 0;\n",i,j);
		}
	}
	printf("\n\n");*/

	printf("\t#pragma unroll\n");
	printf("\tfor(i=0;i<x;i++)\n");
	printf("\t{\n\t\tfor(j=0;j<x;j++)\n\t\t{\n\t\t\tc[threadIdx.x][i][j]=0;\n\t\t}\n\t}\n");

	printf("\tfor (t = 0; t < k; t++) {\n");	
	for (i = 0; i < x; i++) {
		for (j = 0; j < x; j++) {
			printf("\t\tc[threadIdx.x][%d][%d] = max(a_%d,(c[threadIdx.x][%d][%d]+b_%d));\n",i,j,j,i,j,j);
		}
	}
	printf("\n\n");
	for (i = 0; i < x; i++) {
	        printf("\t\ta_%d = max(a_%d,(b_%d+c[threadIdx.x][%d][%d]));\n",i,i,i,0,i);
	
    	}
    	printf("\n\n");

    	for (i = 0; i < x; i++) {
	        printf("\t\tb_%d =  max(b_%d,(a_%d+c[threadIdx.x][%d][%d]));\n",i,i,i,1,i);
	}
    	printf("\n\n");

	printf("\t}\n");

	printf("\n\n");
	
	for (i = 0; i < x; i++) {
		for (j = 0; j < x; j++) {
			printf("\tC[(A_start_index+%d)*C_width + B_start_index+%d] = c[threadIdx.x][%d][%d];\n", i,j,i,j);
		}
	}
	printf("\n\n");
	printf("}\n");
	
	return 1;
}
