#include <stdio.h>
#define SHARED_SIZE 6144

int main (int argc, char **argv){
	
//Parse arguments
int x, B, T, iters, u, depth;

int i;
	
	// Parse arguments.
    if(argc != 7){
     printf("Usage: %s ValuesPerThread Repeats NumBlocks ThreadsPerBlock Depth Unroll\n", argv[0]);
     printf("ValuesPerThread is the footprint of each thread in a block.\n");
     printf("Repeats is the number of times the main loop is repeated in the kernel.");
     printf("NumBlocks is the number of threadblocks to be launched.\n");
     printf("ThreadsPerBlock is the number of threads in each threadblock.\n");
     printf("Depth is the number of scalar values computed per thread to avoid RAW dependency.\n");
     printf("Unroll is the number of timmes inner loop in kernel is unrolled.\n");
     printf("Total vector size is ValuesPerThread*ThreadsPerBlock*NumBlocks\n");
     return 0;
    } else {
      sscanf(argv[1], "%d", &x);
      sscanf(argv[2], "%d", &iters);
      sscanf(argv[3], "%d", &B);
      sscanf(argv[4], "%d", &T);
      sscanf(argv[5], "%d", &depth);
      sscanf(argv[6], "%d", &u);
    }
    
    if(x*depth*T > SHARED_SIZE){
		fprintf(stderr, "Tile size exceeds shared size.\n");
		return 0;
	}

printf("/***********************************\n");

printf("BW Benchmark :s += A * B\n");

printf("size of A,B : %d\n", x*depth*B*T);
//printf("Footprint     : %d\n", x*T);
printf("TILE_SIZE     : %d\n", x*depth*T);
printf("\n");
printf("************************************/\n");
printf("\n");
printf("#define TILE_SIZE %d\n", x*depth*T);
printf("#define SHARED_SIZE %d\n", SHARED_SIZE);
printf("\n");

printf("__global__ void BWkernel (int *C, int x)\n");
printf("{\n");
	printf("\t int tId = threadIdx.x;\n");
	//printf("\t int bId = blockIdx.x;\n");
	printf("\t int bDim = blockDim.x*%d;\n", depth);
	printf("\n");
	//printf("\tint start_Idx = bId*TILE_SIZE + tId;\n");
	printf("\n");
	printf("\tint i, t, s[%d];\n", depth);
	printf("\t\n");
	printf("\t__shared__ int s_A[SHARED_SIZE], s_B[SHARED_SIZE];\n");
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
	printf("\t#pragma unroll %d\n", u);
	printf("\tfor(i=0; i<TILE_SIZE; i+=bDim)\n");
	printf("\t{\n");
		for(i=0; i<depth; i++){
		printf("\t\ts[%d] += s_A[i+tId+%d] * s_B[i+tId+%d];\n", i, i*T, i*T);
		}
printf("\t\n");		
	printf("\t}\n");
	printf("\t}\n");
	
	printf("\t\n");
	printf("\t//Store result to global memory	\n");
	//printf("\tfor(i=tId, p=start_Idx; i<TILE_SIZE; i+=bDim, p+=bDim){\n");
	    printf("if(tId<%d)", depth);
		printf("\t\tC[tId] = s[tId];\n");
	//printf("\t}\n");
	printf("\t\n");

printf("}\n");

}
