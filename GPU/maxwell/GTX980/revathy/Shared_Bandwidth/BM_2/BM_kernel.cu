/***********************************
BW Benchmark :C = A + B
size of A,B,C : 32768
TILE_SIZE     : 1024

************************************/

#define TILE_SIZE 1024
#define SHARED_SIZE 4096

__global__ void BWkernel (int *C, int x)
{
	 int tId = threadIdx.x;
	 int bDim = blockDim.x;


	int i, t;
	
	__shared__ int s_A[SHARED_SIZE], s_B[SHARED_SIZE], s_C[SHARED_SIZE];

	//Main loop
	#pragma unroll 1
	for(t=0; t<4000000; t++)
	{
	#pragma unroll 2
	for(i=0; i<TILE_SIZE; i+=bDim)
	{
		s_C[i+tId] = s_A[i+tId] + s_B[i+tId];
	
	}
	}
	
	//Store result to global memory	
		C[tId] = s_C[tId];
	
}
