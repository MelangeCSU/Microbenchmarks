#include <stdio.h>

int main (int argc, char **argv){
	
//Parse arguments
int x, B, T, vectorLen, iters;
	
	// Parse arguments.
    if(argc != 5){
     printf("Usage: %s ValuesPerThread Repeats NumBlocks ThreadsPerBlock\n", argv[0]);
     printf("ValuesPerThread is the footprint of each thread in a block.\n");
     printf("Repeats is the number of times the main loop is repeated in the kernel.");
     printf("NumBlocks is the number of threadblocks to be launched.\n");
     printf("ThreadsPerBlock is the number of threads in each threadblock.\n");
     printf("Total vector size is ValuesPerThread*ThreadsPerBlock*NumBlocks\n");
     return 0;
    } else {
      sscanf(argv[1], "%d", &x);
      sscanf(argv[2], "%d", &iters);
      sscanf(argv[3], "%d", &B);
      sscanf(argv[4], "%d", &T);
    }
    
    if(x*T > 6144){
		fprintf(stderr, "Tile size larger than shared size.\n");
	}

printf("/***********************************\n");

printf("BW Benchmark :C += A * B\n");

printf("size of A,B,C : %d\n", x*B*T);
//printf("Footprint     : %d\n", x*T);
printf("TILE_SIZE     : %d\n", x*T);
printf("\n");
printf("************************************/\n");
printf("\n");
printf("#define TILE_SIZE %d\n", x*T);
printf("#define SHARED_SIZE 6144\n");
printf("\n");

printf("__global__ void BWkernel (int *C, int x)\n");
printf("{\n");
	printf("\t int tId = threadIdx.x;\n");
	//printf("\t int bId = blockIdx.x;\n");
	printf("\t int bDim = blockDim.x;\n");
	printf("\n");
	//printf("\tint start_Idx = bId*TILE_SIZE + tId;\n");
	printf("\n");
	printf("\tint i, t;\n");
	printf("\t\n");
	printf("\t__shared__ int s_A[SHARED_SIZE], s_C[SHARED_SIZE];\n");
	printf("\n");
	
	/*
	printf("\t//Load inputs to shared memory arrays\n");
	printf("\tfor(i=tId, p=start_Idx; i<TILE_SIZE; i+=bDim, p+=bDim){\n");
		printf("\t\ts_A[i] = 1;	\n");
	printf("\t}\n");
	
	printf("\tfor(i=tId, p=start_Idx; i<TILE_SIZE; i+=bDim, p+=bDim){\n");
		printf("\t\ts_B[i] = 111;	\n");
	printf("\t}\n");

	printf("\tfor(i=tId, p=start_Idx; i<TILE_SIZE; i+=bDim, p+=bDim){\n");
                printf("\t\ts_C[i] = 0;     \n");
        printf("\t}\n");

	*/
	
	printf("\t//Main loop\n");
	
	printf("\t#pragma unroll 1\n");
	printf("\tfor(t=0; t<%d; t++)\n", iters);
	printf("\t{\n");
	printf("\t#pragma unroll 1\n");
	printf("\tfor(i=0; i<TILE_SIZE; i+=bDim)\n");
	printf("\t{\n");
		printf("\t\ts_C[i+tId] = s_A[i+tId];\n");
printf("\t\n");		
	printf("\t}\n");
	printf("\t}\n");
	
	printf("\t\n");
	printf("\t//Store result to global memory	\n");
	//printf("\tfor(i=tId, p=start_Idx; i<TILE_SIZE; i+=bDim, p+=bDim){\n");
		printf("\t\tC[tId] = s_C[tId];\n");
	//printf("\t}\n");
	printf("\t\n");

printf("}\n");

}
