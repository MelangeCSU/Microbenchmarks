/***********************************
BW Benchmark :C += A * B
size of A,B,C : 196608
TILE_SIZE     : 6144

************************************/

#define TILE_SIZE 6144
#define SHARED_SIZE 6144

__global__ void BWkernel (int *C, int x)
{
	 int tId = threadIdx.x;
	 int bDim = blockDim.x;


	int i, t;
	
	__shared__ int s_A[SHARED_SIZE], s_C[SHARED_SIZE];

	//Main loop
	#pragma unroll 1
	for(t=0; t<7000000; t++)
	{
	#pragma unroll 1
	for(i=0; i<TILE_SIZE; i+=bDim)
	{
		s_C[i+tId] = s_A[i+tId];
	
	}
	}
	
	//Store result to global memory	
		C[tId] = s_C[tId];
	
}
