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
	
	printf("/*Author: Swetha Varadarajan 6/10/2015\n Adapted from Waruna Ranasinghe's summer 2014 work on kpdp micro-benchmarking \n Code generated from intmazaddF2CG.c \n Parameters list\n");
	printf("size of A = %d\n    size of B = %d\n    gridDim = %d\n    blockDim = %d\n    Iterations k= %d\n   Values per thread x = %d\n*/\n\n", size_A, size_B, gridDim, blockDim, iterations, x);

	//printf("#define max(x,y)   ((x)>(y) ? (x) : (y))\n");

	printf("__global__ void IntmaxaddF2(const int* A, const int* B, int* C, int x, int k)\n{\n");
	printf("\tint B_start_index = (blockIdx.x*gridDim.y + blockIdx.y)*x;\n");
	printf("\tint A_start_index = (threadIdx.x*blockDim.y + threadIdx.y)*x;\n");
	printf("\tint C_width = x*gridDim.x*gridDim.y;\n");
  	
	printf("\n\n");
	
	printf("\tint i,j,t;\n");

	printf("\t__shared__ int c[%d][%d][%d];\n",blockDim,x,x);
	printf("\t__shared__ int a[%d][%d];\n",blockDim,x);
	printf("\t__shared__ int b[%d];\n",x);

	
	printf("\n\n");

    	for (i = 0; i < x; i++) {
		printf("\ta[threadIdx.x][%d] = A[A_start_index+%d];\n",i,i);
    	}
	printf("\n\n");

    	for (i = 0; i < x; i++) {
		printf("\tb[%d] = B[B_start_index+%d];\n",i,i);
  	}
	printf("\n\n");

 	printf("\t#pragma unroll\n");
	printf("\tfor(i=0;i<x;i++)\n");
	printf("\t{\n\t\tfor(j=0;j<x;j++)\n\t\t{\n\t\t\tc[threadIdx.x][i][j]=0;\n\t\t}\n\t}\n");

	printf("\n\n");
	printf("\tfor (t = 0; t < k; t++) {\n");
	printf("\t#pragma unroll\n");
	printf("\t\tfor(i=0;i<x;i++)\n	\t\t{\n	\t\t\tfor(j=0;j<x;j++)\n\t\t\t{\n\t\t\t\tc[threadIdx.x][i][j] = max(a[threadIdx.x][j],(b[j]+c[threadIdx.x][i][j]));\n\t\t\t}\n\t\t}\n");
	printf("\n\n");

	for (i = 0; i < x; i++) {
	
        printf("\t\ta[threadIdx.x][%d] = max(a[threadIdx.x][%d],(b[%d]+c[threadIdx.x][%d][%d]));\n",i,i,i,0,i);
    }
    	printf("\n\n");

    	 for (i = 0; i < x; i++) {
	//make sure that C has atleast 2 rows. 
        printf("\t\tb[%d] = max(b[%d],(a[threadIdx.x][%d]+c[threadIdx.x][%d][%d]));\n",i,i,x-i-1,1,i);
	//printf("\t\tb[%d] = max(b[%d],(a[threadIdx.x][%d]+c[threadIdx.x][%d][%d]));\n",i,i,i,i,x-i-1);
    }
    printf("\n\n");
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
