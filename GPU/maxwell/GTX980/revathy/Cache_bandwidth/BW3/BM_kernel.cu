/***********************************
This kernel is for testing L1 and L2 cache Bandwidth

BW Benchmark :s += A[i]*B[i]
TILE_SIZE     : 4096

************************************/

#define TILE_SIZE 4096

__global__ void BWkernel (int *A, int *B, int *C, int x)
{
	 int tId = threadIdx.x;
	 int bId = blockIdx.x;
	 int bDim = blockDim.x;

	int start_Idx = bId*TILE_SIZE + tId;

	int i, s;
	

	s = 0;

	//Main loop
	#pragma unroll
	for(i=start_Idx; i<TILE_SIZE; i+=bDim)
	{
		s += A[i] * B[i];
	
	}
	
	if(tId==0) C[bId] = s; 
}
