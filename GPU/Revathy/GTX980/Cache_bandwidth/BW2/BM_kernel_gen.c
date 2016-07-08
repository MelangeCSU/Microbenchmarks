#include <stdio.h>

int main (int argc, char **argv){
	
//Parse arguments
int x, B, T, vectorLen;
	
	// Parse arguments.
    if(argc != 4){
     printf("Usage: %s ValuesPerThread NumBlocks ThreadsPerBlock\n", argv[0]);
     printf("ValuesPerThread is the footprint of each thread in a block.\n");
     printf("NumBlocks is the number of threadblocks to be launched.\n");
     printf("ThreadsPerBlock is the number of threads in each threadblock.\n");
     printf("Total vector size is ValuesPerThread*ThreadsPerBlock*NumBlocks\n");
     return 0;
    } else {
      sscanf(argv[1], "%d", &x);
      sscanf(argv[2], "%d", &B);
      sscanf(argv[3], "%d", &T);
    }

printf("/***********************************\n");

printf("This kernel is for testing L1 and L2 cache Bandwidth\n\n");

printf("BW Benchmark :C[i] = A[i]+B[i]\n");

//printf("size of vector : %d\n", x*B*T);
//printf("Footprint     : %d\n", x*T);
printf("TILE_SIZE     : %d\n", x*T);
printf("\n");
printf("************************************/\n");
printf("\n");
printf("#define TILE_SIZE %d\n", x*T);
printf("\n");

printf("__global__ void BWkernel (int *A, int *B, int *C, int x)\n");
printf("{\n");
	printf("\t int tId = threadIdx.x;\n");
	printf("\t int bId = blockIdx.x;\n");
	printf("\t int bDim = blockDim.x;\n");
	printf("\n");
	printf("\tint start_Idx = bId*TILE_SIZE + tId;\n");
	printf("\n");
	printf("\tint i, s;\n");
	printf("\t\n");
	printf("\n");
	
	printf("\ts = 0;\n\n");

	printf("\t//Main loop\n");
	
	printf("\t#pragma unroll\n");
	printf("\tfor(i=start_Idx; i<TILE_SIZE; i+=bDim)\n");
	printf("\t{\n");
		printf("\t\tC[i] = A[i] + B[i];\n");
printf("\t\n");		
	printf("\t}\n");
	
	printf("\t\n");

	printf("\tif(tId==0) C[bId] = s; \n");
	
printf("}\n");

}
