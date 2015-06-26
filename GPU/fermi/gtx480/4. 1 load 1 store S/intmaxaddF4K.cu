/*Author: Swetha Varadarajan 6/10/2015
 Adapted from Waruna Ranasinghe's summer 2014 work on kpdp micro-benchmarking 
 Code generated from intmazaddF4CG.c 
 Parameters list
size of A = 3264
    size of B = 1440
    gridDim = 240
    blockDim = 544
    Iterations k= 40000
   Values per thread x = 6
*/

__global__ void IntmaxaddF4(const int* A, const int* B, int* C, int x, int k)
{
	int B_start_index = (blockIdx.x*gridDim.y + blockIdx.y)*x;
	int A_start_index = (threadIdx.x*blockDim.y + threadIdx.y)*x;
	int C_width = x*gridDim.x*gridDim.y;


	int i,j,t;
	__shared__ int c[544][6][6];
	int a_0, a_1, a_2, a_3, a_4, a_5;
	int b_0, b_1, b_2, b_3, b_4, b_5;


	a_0 = A[A_start_index+0];
	a_1 = A[A_start_index+1];
	a_2 = A[A_start_index+2];
	a_3 = A[A_start_index+3];
	a_4 = A[A_start_index+4];
	a_5 = A[A_start_index+5];


	b_0 = B[B_start_index+0];
	b_1 = B[B_start_index+1];
	b_2 = B[B_start_index+2];
	b_3 = B[B_start_index+3];
	b_4 = B[B_start_index+4];
	b_5 = B[B_start_index+5];


	#pragma unroll
	for(i=0;i<x;i++)
	{
		for(j=0;j<x;j++)
		{
			c[threadIdx.x][i][j]=0;
		}
	}
	for (t = 0; t < k; t++) {
		c[threadIdx.x][0][0] = max(a_0,(c[threadIdx.x][0][0]+b_0));
		c[threadIdx.x][0][1] = max(a_1,(c[threadIdx.x][0][1]+b_1));
		c[threadIdx.x][0][2] = max(a_2,(c[threadIdx.x][0][2]+b_2));
		c[threadIdx.x][0][3] = max(a_3,(c[threadIdx.x][0][3]+b_3));
		c[threadIdx.x][0][4] = max(a_4,(c[threadIdx.x][0][4]+b_4));
		c[threadIdx.x][0][5] = max(a_5,(c[threadIdx.x][0][5]+b_5));
		c[threadIdx.x][1][0] = max(a_0,(c[threadIdx.x][1][0]+b_0));
		c[threadIdx.x][1][1] = max(a_1,(c[threadIdx.x][1][1]+b_1));
		c[threadIdx.x][1][2] = max(a_2,(c[threadIdx.x][1][2]+b_2));
		c[threadIdx.x][1][3] = max(a_3,(c[threadIdx.x][1][3]+b_3));
		c[threadIdx.x][1][4] = max(a_4,(c[threadIdx.x][1][4]+b_4));
		c[threadIdx.x][1][5] = max(a_5,(c[threadIdx.x][1][5]+b_5));
		c[threadIdx.x][2][0] = max(a_0,(c[threadIdx.x][2][0]+b_0));
		c[threadIdx.x][2][1] = max(a_1,(c[threadIdx.x][2][1]+b_1));
		c[threadIdx.x][2][2] = max(a_2,(c[threadIdx.x][2][2]+b_2));
		c[threadIdx.x][2][3] = max(a_3,(c[threadIdx.x][2][3]+b_3));
		c[threadIdx.x][2][4] = max(a_4,(c[threadIdx.x][2][4]+b_4));
		c[threadIdx.x][2][5] = max(a_5,(c[threadIdx.x][2][5]+b_5));
		c[threadIdx.x][3][0] = max(a_0,(c[threadIdx.x][3][0]+b_0));
		c[threadIdx.x][3][1] = max(a_1,(c[threadIdx.x][3][1]+b_1));
		c[threadIdx.x][3][2] = max(a_2,(c[threadIdx.x][3][2]+b_2));
		c[threadIdx.x][3][3] = max(a_3,(c[threadIdx.x][3][3]+b_3));
		c[threadIdx.x][3][4] = max(a_4,(c[threadIdx.x][3][4]+b_4));
		c[threadIdx.x][3][5] = max(a_5,(c[threadIdx.x][3][5]+b_5));
		c[threadIdx.x][4][0] = max(a_0,(c[threadIdx.x][4][0]+b_0));
		c[threadIdx.x][4][1] = max(a_1,(c[threadIdx.x][4][1]+b_1));
		c[threadIdx.x][4][2] = max(a_2,(c[threadIdx.x][4][2]+b_2));
		c[threadIdx.x][4][3] = max(a_3,(c[threadIdx.x][4][3]+b_3));
		c[threadIdx.x][4][4] = max(a_4,(c[threadIdx.x][4][4]+b_4));
		c[threadIdx.x][4][5] = max(a_5,(c[threadIdx.x][4][5]+b_5));
		c[threadIdx.x][5][0] = max(a_0,(c[threadIdx.x][5][0]+b_0));
		c[threadIdx.x][5][1] = max(a_1,(c[threadIdx.x][5][1]+b_1));
		c[threadIdx.x][5][2] = max(a_2,(c[threadIdx.x][5][2]+b_2));
		c[threadIdx.x][5][3] = max(a_3,(c[threadIdx.x][5][3]+b_3));
		c[threadIdx.x][5][4] = max(a_4,(c[threadIdx.x][5][4]+b_4));
		c[threadIdx.x][5][5] = max(a_5,(c[threadIdx.x][5][5]+b_5));


		a_0 = max(a_0,(b_0+c[threadIdx.x][0][0]));
		a_1 = max(a_1,(b_1+c[threadIdx.x][0][1]));
		a_2 = max(a_2,(b_2+c[threadIdx.x][0][2]));
		a_3 = max(a_3,(b_3+c[threadIdx.x][0][3]));
		a_4 = max(a_4,(b_4+c[threadIdx.x][0][4]));
		a_5 = max(a_5,(b_5+c[threadIdx.x][0][5]));


		b_0 =  max(b_0,(a_0+c[threadIdx.x][1][0]));
		b_1 =  max(b_1,(a_1+c[threadIdx.x][1][1]));
		b_2 =  max(b_2,(a_2+c[threadIdx.x][1][2]));
		b_3 =  max(b_3,(a_3+c[threadIdx.x][1][3]));
		b_4 =  max(b_4,(a_4+c[threadIdx.x][1][4]));
		b_5 =  max(b_5,(a_5+c[threadIdx.x][1][5]));


	}


	C[(A_start_index+0)*C_width + B_start_index+0] = c[threadIdx.x][0][0];
	C[(A_start_index+0)*C_width + B_start_index+1] = c[threadIdx.x][0][1];
	C[(A_start_index+0)*C_width + B_start_index+2] = c[threadIdx.x][0][2];
	C[(A_start_index+0)*C_width + B_start_index+3] = c[threadIdx.x][0][3];
	C[(A_start_index+0)*C_width + B_start_index+4] = c[threadIdx.x][0][4];
	C[(A_start_index+0)*C_width + B_start_index+5] = c[threadIdx.x][0][5];
	C[(A_start_index+1)*C_width + B_start_index+0] = c[threadIdx.x][1][0];
	C[(A_start_index+1)*C_width + B_start_index+1] = c[threadIdx.x][1][1];
	C[(A_start_index+1)*C_width + B_start_index+2] = c[threadIdx.x][1][2];
	C[(A_start_index+1)*C_width + B_start_index+3] = c[threadIdx.x][1][3];
	C[(A_start_index+1)*C_width + B_start_index+4] = c[threadIdx.x][1][4];
	C[(A_start_index+1)*C_width + B_start_index+5] = c[threadIdx.x][1][5];
	C[(A_start_index+2)*C_width + B_start_index+0] = c[threadIdx.x][2][0];
	C[(A_start_index+2)*C_width + B_start_index+1] = c[threadIdx.x][2][1];
	C[(A_start_index+2)*C_width + B_start_index+2] = c[threadIdx.x][2][2];
	C[(A_start_index+2)*C_width + B_start_index+3] = c[threadIdx.x][2][3];
	C[(A_start_index+2)*C_width + B_start_index+4] = c[threadIdx.x][2][4];
	C[(A_start_index+2)*C_width + B_start_index+5] = c[threadIdx.x][2][5];
	C[(A_start_index+3)*C_width + B_start_index+0] = c[threadIdx.x][3][0];
	C[(A_start_index+3)*C_width + B_start_index+1] = c[threadIdx.x][3][1];
	C[(A_start_index+3)*C_width + B_start_index+2] = c[threadIdx.x][3][2];
	C[(A_start_index+3)*C_width + B_start_index+3] = c[threadIdx.x][3][3];
	C[(A_start_index+3)*C_width + B_start_index+4] = c[threadIdx.x][3][4];
	C[(A_start_index+3)*C_width + B_start_index+5] = c[threadIdx.x][3][5];
	C[(A_start_index+4)*C_width + B_start_index+0] = c[threadIdx.x][4][0];
	C[(A_start_index+4)*C_width + B_start_index+1] = c[threadIdx.x][4][1];
	C[(A_start_index+4)*C_width + B_start_index+2] = c[threadIdx.x][4][2];
	C[(A_start_index+4)*C_width + B_start_index+3] = c[threadIdx.x][4][3];
	C[(A_start_index+4)*C_width + B_start_index+4] = c[threadIdx.x][4][4];
	C[(A_start_index+4)*C_width + B_start_index+5] = c[threadIdx.x][4][5];
	C[(A_start_index+5)*C_width + B_start_index+0] = c[threadIdx.x][5][0];
	C[(A_start_index+5)*C_width + B_start_index+1] = c[threadIdx.x][5][1];
	C[(A_start_index+5)*C_width + B_start_index+2] = c[threadIdx.x][5][2];
	C[(A_start_index+5)*C_width + B_start_index+3] = c[threadIdx.x][5][3];
	C[(A_start_index+5)*C_width + B_start_index+4] = c[threadIdx.x][5][4];
	C[(A_start_index+5)*C_width + B_start_index+5] = c[threadIdx.x][5][5];


}
