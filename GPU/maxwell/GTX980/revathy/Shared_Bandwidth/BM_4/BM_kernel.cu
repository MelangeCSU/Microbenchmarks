/***********************************
BW Benchmark :s = A[i]
size of A,B : 393216
TILE_SIZE     : 12288

************************************/

#define TILE_SIZE 12288
#define SHARED_SIZE 12288

__global__ void BWkernel (int *C, int x)
{
	 int tId = threadIdx.x;
	 int bDim = blockDim.x*1;


	int i, t, s[1];
	
	__shared__ int s_A[SHARED_SIZE];

	//Main loop
	#pragma unroll 1
	for(t=0; t<4000000; t++)
	{
	#pragma unroll 1
	for(i=0; i<TILE_SIZE; i+=bDim)
	{
		s[0] += s_A[i+tId+0];
	
	}
	}
	
	//Store result to global memory	
if(tId<1)		C[tId] = s[tId];
	
}
