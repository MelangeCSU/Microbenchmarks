/*
 * Code to generate the device kernel where one operand and result
 * is in shared mem. Here, the main loop will have 2 loads and 1
 * store per operation.
 * Operation: integer max-plus
 *
 * Created by: Revathy
 * Last modified by: Revathy
 * Last modified: 2015-05-21
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

	printf("/** size of A = %d\n    size of B = %d\n    gridDim = %d\n    blockDim = %d\n    k= %d\n    x = %d\n**/\n\n", size_A, size_B, gridDim, blockDim, iterations, x);
	printf("__global__ void CompareAddVectors(const int* A, const int* B, int* C, int x, int k)\n{\n");
	printf("\tint size_A = x*blockDim.x;\n");
	printf("\tint B_start_index = (blockIdx.x*gridDim.y + blockIdx.y)*x;");
    
	printf("\n\n");
	
	printf("\tint t,i,j,temp;\n");

	printf("\t__shared__ int ");
	
	//Using shared memory for C
	printf("c[%d][%d]; \n", x,size_A);

	printf("\t __shared__ int ");

    //Using shared memory for A
    printf("a[%d]; \n", size_A);

	printf("\tint ");
    for (i = 0; i < x; i++) {
		if (i == x - 1) {
			printf("b_%d;\n",i);
		} else {
			printf("b_%d, ",i);
		}
    }
	printf("\n\n");

    printf("\tfor (t = 0; t < x; t++) {\n");
		printf("\t\ttemp = blockDim.x*t + threadIdx.x;\n");
		printf("\t\ta[temp] = A[temp];\n");
    printf("\t}\n");
	printf("\n\n");

    printf("\tfor (i = 0; i < x; i++) {\n");
	printf("\t\tfor (t = 0; t < x; t++) {\n");
                printf("\t\t\tc[i][blockDim.x*t + threadIdx.x] = 0;\n");
	printf("\t\t}\n");
    printf("\t}\n");
        printf("\n\n");

    printf("\t__syncthreads(); \n\n");

    for (i = 0; i < x; i++) {
		printf("\tb_%d = B[B_start_index+%d];\n",i,i);
    }
	printf("\n\n");

    
	printf("\n\n");

	//printf("\t#pragma unroll\n");
	printf("\tfor (t = 0; t < k; t++) {\n");
		for (j = 0; j < x; j++) {
			printf("\t\t#pragma unroll\n");	
			printf("\t\tfor (j = 0; j < x; j++) {\n");
				printf("\t\t\ttemp = blockDim.x*j+threadIdx.x;\n");
			//for (j = 0; j < x; j++) {
				printf("\t\t\tc[%d][temp] = max(a[temp]+b_%d, c[%d][temp]);\n",j,j,j);
		
		 	printf("\t\t}\n");
		}
	printf("\n\n");
	printf("\t\tfor (i = 0; i < x; i++) {\n");
		printf("\t\t\ttemp = blockDim.x*i+threadIdx.x;\n");
        	printf("\t\t\ta[temp] = max(a[temp]+10, a[temp]);\n");
    	printf("\t\t}\n");
    printf("\n\n");


    for (i = 0; i < x; i++) {
        printf("\t\tb_%d = max(b_%d, b_%d+10);\n",i,i,i);
    }
    printf("\n\n");

    printf("\t\t__syncthreads();\n");

    printf("\t}\n");

	printf("\n\n");

	printf("\tfor (i = 0; i < x; i++) {\n");
		printf("\t\tfor (t = 0; t < x; t++) {\n");
			printf("\t\t\ttemp = t*blockDim.x + threadIdx.x;\n");
                	printf("\t\t\tC[(x*blockIdx.x+i)*size_A + temp] = c[i][temp];\n");
		printf("\t\t}\n");
	printf("\t}\n");
        printf("\n\n");

	printf("}\n");
	
	return 1;
}
