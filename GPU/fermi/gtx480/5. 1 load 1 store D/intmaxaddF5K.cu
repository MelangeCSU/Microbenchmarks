/*Author: Swetha Varadarajan 6/10/2015
 Adapted from Waruna Ranasinghe's summer 2014 work on kpdp micro-benchmarking 
 Code generated from intmazaddF5CG.c 
 Parameters list
size of A = 960
    size of B = 90
    gridDim = 30
    blockDim = 320
    Iterations k= 1700000
   Values per thread x = 3
*/

__global__ void IntmaxaddF5(const int* A, const int* B, int* C, int x, int k)
{
	int B_start_index = (blockIdx.x*gridDim.y + blockIdx.y)*x;
	int A_start_index = (threadIdx.x*blockDim.y + threadIdx.y)*x;
	int C_width = x*gridDim.x*gridDim.y;


	int i,j,t;
	__shared__ int c[320][3][3];
	int a_0, a_1, a_2;
	int b_0, b_1, b_2;


	a_0 = A[A_start_index+0];
	a_1 = A[A_start_index+1];
	a_2 = A[A_start_index+2];


	b_0 = B[B_start_index+0];
	b_1 = B[B_start_index+1];
	b_2 = B[B_start_index+2];


	#pragma unroll
	for(i=0;i<x;i++)
	{
		for(j=0;j<x;j++)
		{
			c[threadIdx.x][i][j]=0;
		}
	}
	for (t = 0; t < k; t++) {
		c[threadIdx.x][0][0] = max(a_0,(c[threadIdx.x][2][2]+b_0));
		c[threadIdx.x][0][1] = max(a_0,(c[threadIdx.x][2][1]+b_1));
		c[threadIdx.x][0][2] = max(a_0,(c[threadIdx.x][2][0]+b_2));
		c[threadIdx.x][1][0] = max(a_1,(c[threadIdx.x][1][2]+b_0));
		c[threadIdx.x][1][1] = max(a_1,(c[threadIdx.x][1][1]+b_1));
		c[threadIdx.x][1][2] = max(a_1,(c[threadIdx.x][1][0]+b_2));
		c[threadIdx.x][2][0] = max(a_2,(c[threadIdx.x][0][2]+b_0));
		c[threadIdx.x][2][1] = max(a_2,(c[threadIdx.x][0][1]+b_1));
		c[threadIdx.x][2][2] = max(a_2,(c[threadIdx.x][0][0]+b_2));


		a_0 = max(a_0,(b_0+c[threadIdx.x][0][0]));
		a_1 = max(a_1,(b_1+c[threadIdx.x][0][1]));
		a_2 = max(a_2,(b_2+c[threadIdx.x][0][2]));


		b_0 =  max(b_0,(a_0+c[threadIdx.x][1][0]));
		b_1 =  max(b_1,(a_1+c[threadIdx.x][1][1]));
		b_2 =  max(b_2,(a_2+c[threadIdx.x][1][2]));


	}


	C[(A_start_index+0)*C_width + B_start_index+0] = c[threadIdx.x][0][0];
	C[(A_start_index+0)*C_width + B_start_index+1] = c[threadIdx.x][0][1];
	C[(A_start_index+0)*C_width + B_start_index+2] = c[threadIdx.x][0][2];
	C[(A_start_index+1)*C_width + B_start_index+0] = c[threadIdx.x][1][0];
	C[(A_start_index+1)*C_width + B_start_index+1] = c[threadIdx.x][1][1];
	C[(A_start_index+1)*C_width + B_start_index+2] = c[threadIdx.x][1][2];
	C[(A_start_index+2)*C_width + B_start_index+0] = c[threadIdx.x][2][0];
	C[(A_start_index+2)*C_width + B_start_index+1] = c[threadIdx.x][2][1];
	C[(A_start_index+2)*C_width + B_start_index+2] = c[threadIdx.x][2][2];


}
