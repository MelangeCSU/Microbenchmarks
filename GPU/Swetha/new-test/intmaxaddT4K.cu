__global__ void IntmaxaddT4(int* C, int k, int sl)
{


	int i,t;
	int a=0,a2=0,b=2;
	int sharedsize=234;
	int blockStartIndex  = blockIdx.x * blockDim.x * 234;
	int threadStartIndex = blockStartIndex + threadIdx.x ;
	__shared__ int c[234];


	#pragma unroll
	for(i = threadStartIndex; i < sharedsize; i+=sl)
		c[threadIdx.x+i]=C[threadIdx.x+i];

	for (t = 0; t < k; t++) {
		a=max(a,c[threadIdx.x]+10);
		#pragma unroll
		for (i = threadStartIndex; i < sharedsize; i+=sl){
		a2=c[i];c[i] = max(a,(c[i]+b));a=a2;
	}}

	#pragma unroll
	for(i = threadStartIndex; i < sharedsize; i+=sl)
		C[threadIdx.x+i]=c[threadIdx.x+i];



}
