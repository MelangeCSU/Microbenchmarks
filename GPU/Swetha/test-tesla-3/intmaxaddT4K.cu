__global__ void IntmaxaddT4(int* C, int k, int sl)
{


	int i,t;
	int a=0,a2=0,b=2;
	int N=120000/gridDim.x;
	int blockStartIndex  = blockIdx.x * N;
	int threadStartIndex = blockStartIndex + threadIdx.x ;
	int threadEndIndex   = blockStartIndex + N;
	__shared__ int c[500];//array count=N


	int count=0;
	#pragma unroll
	for(i = threadStartIndex; i < threadEndIndex; i+=sl){
		c[threadIdx.x+count]=C[threadIdx.x+i];
	count+=sl;}
	for (t = 0; t < k; t++) {
		a=max(a,c[threadIdx.x]+10);
		#pragma unroll
		for(i = threadIdx.x; i < (threadIdx.x+count); i+=sl){
		a2=c[i];c[i] = max(a,(c[i]+b));a=a2;
	}}
	count=0;

	#pragma unroll
	for(i = threadStartIndex; i < threadEndIndex; i+=sl){
		C[threadIdx.x+i]=c[threadIdx.x+count];
	count++;}


}
