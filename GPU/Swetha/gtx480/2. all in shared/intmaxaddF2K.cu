/*Author: Swetha Varadarajan 6/10/2015
 Adapted from Waruna Ranasinghe's summer 2014 work on kpdp micro-benchmarking 
 Code generated from intmazaddF2CG.c 
 Parameters list
size of A = 2880
    size of B = 1650
    gridDim = 165
    blockDim = 288
    Iterations k= 800000
   Values per thread x = 10
*/

__global__ void IntmaxaddF2(const int* A, const int* B, int* C, int x, int k)
{
	int B_start_index = (blockIdx.x*gridDim.y + blockIdx.y)*x;
	int A_start_index = (threadIdx.x*blockDim.y + threadIdx.y)*x;
	int C_width = x*gridDim.x*gridDim.y;


	int i,j,t;
	__shared__ int c[288][10][10];
	__shared__ int a[288][10];
	__shared__ int b[10];


	a[threadIdx.x][0] = A[A_start_index+0];
	a[threadIdx.x][1] = A[A_start_index+1];
	a[threadIdx.x][2] = A[A_start_index+2];
	a[threadIdx.x][3] = A[A_start_index+3];
	a[threadIdx.x][4] = A[A_start_index+4];
	a[threadIdx.x][5] = A[A_start_index+5];
	a[threadIdx.x][6] = A[A_start_index+6];
	a[threadIdx.x][7] = A[A_start_index+7];
	a[threadIdx.x][8] = A[A_start_index+8];
	a[threadIdx.x][9] = A[A_start_index+9];


	b[0] = B[B_start_index+0];
	b[1] = B[B_start_index+1];
	b[2] = B[B_start_index+2];
	b[3] = B[B_start_index+3];
	b[4] = B[B_start_index+4];
	b[5] = B[B_start_index+5];
	b[6] = B[B_start_index+6];
	b[7] = B[B_start_index+7];
	b[8] = B[B_start_index+8];
	b[9] = B[B_start_index+9];


	#pragma unroll
	for(i=0;i<x;i++)
	{
		for(j=0;j<x;j++)
		{
			c[threadIdx.x][i][j]=0;
		}
	}


	for (t = 0; t < k; t++) {
	#pragma unroll
		for(i=0;i<x;i++)
			{
				for(j=0;j<x;j++)
			{
				c[threadIdx.x][i][j] = max(a[threadIdx.x][j],(b[j]+c[threadIdx.x][i][j]));
			}
		}


		a[threadIdx.x][0] = max(a[threadIdx.x][0],(b[0]+c[threadIdx.x][0][0]));
		a[threadIdx.x][1] = max(a[threadIdx.x][1],(b[1]+c[threadIdx.x][0][1]));
		a[threadIdx.x][2] = max(a[threadIdx.x][2],(b[2]+c[threadIdx.x][0][2]));
		a[threadIdx.x][3] = max(a[threadIdx.x][3],(b[3]+c[threadIdx.x][0][3]));
		a[threadIdx.x][4] = max(a[threadIdx.x][4],(b[4]+c[threadIdx.x][0][4]));
		a[threadIdx.x][5] = max(a[threadIdx.x][5],(b[5]+c[threadIdx.x][0][5]));
		a[threadIdx.x][6] = max(a[threadIdx.x][6],(b[6]+c[threadIdx.x][0][6]));
		a[threadIdx.x][7] = max(a[threadIdx.x][7],(b[7]+c[threadIdx.x][0][7]));
		a[threadIdx.x][8] = max(a[threadIdx.x][8],(b[8]+c[threadIdx.x][0][8]));
		a[threadIdx.x][9] = max(a[threadIdx.x][9],(b[9]+c[threadIdx.x][0][9]));


		b[0] = max(b[0],(a[threadIdx.x][9]+c[threadIdx.x][1][0]));
		b[1] = max(b[1],(a[threadIdx.x][8]+c[threadIdx.x][1][1]));
		b[2] = max(b[2],(a[threadIdx.x][7]+c[threadIdx.x][1][2]));
		b[3] = max(b[3],(a[threadIdx.x][6]+c[threadIdx.x][1][3]));
		b[4] = max(b[4],(a[threadIdx.x][5]+c[threadIdx.x][1][4]));
		b[5] = max(b[5],(a[threadIdx.x][4]+c[threadIdx.x][1][5]));
		b[6] = max(b[6],(a[threadIdx.x][3]+c[threadIdx.x][1][6]));
		b[7] = max(b[7],(a[threadIdx.x][2]+c[threadIdx.x][1][7]));
		b[8] = max(b[8],(a[threadIdx.x][1]+c[threadIdx.x][1][8]));
		b[9] = max(b[9],(a[threadIdx.x][0]+c[threadIdx.x][1][9]));




	}


	C[(A_start_index+0)*C_width + B_start_index+0] = c[threadIdx.x][0][0];
	C[(A_start_index+0)*C_width + B_start_index+1] = c[threadIdx.x][0][1];
	C[(A_start_index+0)*C_width + B_start_index+2] = c[threadIdx.x][0][2];
	C[(A_start_index+0)*C_width + B_start_index+3] = c[threadIdx.x][0][3];
	C[(A_start_index+0)*C_width + B_start_index+4] = c[threadIdx.x][0][4];
	C[(A_start_index+0)*C_width + B_start_index+5] = c[threadIdx.x][0][5];
	C[(A_start_index+0)*C_width + B_start_index+6] = c[threadIdx.x][0][6];
	C[(A_start_index+0)*C_width + B_start_index+7] = c[threadIdx.x][0][7];
	C[(A_start_index+0)*C_width + B_start_index+8] = c[threadIdx.x][0][8];
	C[(A_start_index+0)*C_width + B_start_index+9] = c[threadIdx.x][0][9];
	C[(A_start_index+1)*C_width + B_start_index+0] = c[threadIdx.x][1][0];
	C[(A_start_index+1)*C_width + B_start_index+1] = c[threadIdx.x][1][1];
	C[(A_start_index+1)*C_width + B_start_index+2] = c[threadIdx.x][1][2];
	C[(A_start_index+1)*C_width + B_start_index+3] = c[threadIdx.x][1][3];
	C[(A_start_index+1)*C_width + B_start_index+4] = c[threadIdx.x][1][4];
	C[(A_start_index+1)*C_width + B_start_index+5] = c[threadIdx.x][1][5];
	C[(A_start_index+1)*C_width + B_start_index+6] = c[threadIdx.x][1][6];
	C[(A_start_index+1)*C_width + B_start_index+7] = c[threadIdx.x][1][7];
	C[(A_start_index+1)*C_width + B_start_index+8] = c[threadIdx.x][1][8];
	C[(A_start_index+1)*C_width + B_start_index+9] = c[threadIdx.x][1][9];
	C[(A_start_index+2)*C_width + B_start_index+0] = c[threadIdx.x][2][0];
	C[(A_start_index+2)*C_width + B_start_index+1] = c[threadIdx.x][2][1];
	C[(A_start_index+2)*C_width + B_start_index+2] = c[threadIdx.x][2][2];
	C[(A_start_index+2)*C_width + B_start_index+3] = c[threadIdx.x][2][3];
	C[(A_start_index+2)*C_width + B_start_index+4] = c[threadIdx.x][2][4];
	C[(A_start_index+2)*C_width + B_start_index+5] = c[threadIdx.x][2][5];
	C[(A_start_index+2)*C_width + B_start_index+6] = c[threadIdx.x][2][6];
	C[(A_start_index+2)*C_width + B_start_index+7] = c[threadIdx.x][2][7];
	C[(A_start_index+2)*C_width + B_start_index+8] = c[threadIdx.x][2][8];
	C[(A_start_index+2)*C_width + B_start_index+9] = c[threadIdx.x][2][9];
	C[(A_start_index+3)*C_width + B_start_index+0] = c[threadIdx.x][3][0];
	C[(A_start_index+3)*C_width + B_start_index+1] = c[threadIdx.x][3][1];
	C[(A_start_index+3)*C_width + B_start_index+2] = c[threadIdx.x][3][2];
	C[(A_start_index+3)*C_width + B_start_index+3] = c[threadIdx.x][3][3];
	C[(A_start_index+3)*C_width + B_start_index+4] = c[threadIdx.x][3][4];
	C[(A_start_index+3)*C_width + B_start_index+5] = c[threadIdx.x][3][5];
	C[(A_start_index+3)*C_width + B_start_index+6] = c[threadIdx.x][3][6];
	C[(A_start_index+3)*C_width + B_start_index+7] = c[threadIdx.x][3][7];
	C[(A_start_index+3)*C_width + B_start_index+8] = c[threadIdx.x][3][8];
	C[(A_start_index+3)*C_width + B_start_index+9] = c[threadIdx.x][3][9];
	C[(A_start_index+4)*C_width + B_start_index+0] = c[threadIdx.x][4][0];
	C[(A_start_index+4)*C_width + B_start_index+1] = c[threadIdx.x][4][1];
	C[(A_start_index+4)*C_width + B_start_index+2] = c[threadIdx.x][4][2];
	C[(A_start_index+4)*C_width + B_start_index+3] = c[threadIdx.x][4][3];
	C[(A_start_index+4)*C_width + B_start_index+4] = c[threadIdx.x][4][4];
	C[(A_start_index+4)*C_width + B_start_index+5] = c[threadIdx.x][4][5];
	C[(A_start_index+4)*C_width + B_start_index+6] = c[threadIdx.x][4][6];
	C[(A_start_index+4)*C_width + B_start_index+7] = c[threadIdx.x][4][7];
	C[(A_start_index+4)*C_width + B_start_index+8] = c[threadIdx.x][4][8];
	C[(A_start_index+4)*C_width + B_start_index+9] = c[threadIdx.x][4][9];
	C[(A_start_index+5)*C_width + B_start_index+0] = c[threadIdx.x][5][0];
	C[(A_start_index+5)*C_width + B_start_index+1] = c[threadIdx.x][5][1];
	C[(A_start_index+5)*C_width + B_start_index+2] = c[threadIdx.x][5][2];
	C[(A_start_index+5)*C_width + B_start_index+3] = c[threadIdx.x][5][3];
	C[(A_start_index+5)*C_width + B_start_index+4] = c[threadIdx.x][5][4];
	C[(A_start_index+5)*C_width + B_start_index+5] = c[threadIdx.x][5][5];
	C[(A_start_index+5)*C_width + B_start_index+6] = c[threadIdx.x][5][6];
	C[(A_start_index+5)*C_width + B_start_index+7] = c[threadIdx.x][5][7];
	C[(A_start_index+5)*C_width + B_start_index+8] = c[threadIdx.x][5][8];
	C[(A_start_index+5)*C_width + B_start_index+9] = c[threadIdx.x][5][9];
	C[(A_start_index+6)*C_width + B_start_index+0] = c[threadIdx.x][6][0];
	C[(A_start_index+6)*C_width + B_start_index+1] = c[threadIdx.x][6][1];
	C[(A_start_index+6)*C_width + B_start_index+2] = c[threadIdx.x][6][2];
	C[(A_start_index+6)*C_width + B_start_index+3] = c[threadIdx.x][6][3];
	C[(A_start_index+6)*C_width + B_start_index+4] = c[threadIdx.x][6][4];
	C[(A_start_index+6)*C_width + B_start_index+5] = c[threadIdx.x][6][5];
	C[(A_start_index+6)*C_width + B_start_index+6] = c[threadIdx.x][6][6];
	C[(A_start_index+6)*C_width + B_start_index+7] = c[threadIdx.x][6][7];
	C[(A_start_index+6)*C_width + B_start_index+8] = c[threadIdx.x][6][8];
	C[(A_start_index+6)*C_width + B_start_index+9] = c[threadIdx.x][6][9];
	C[(A_start_index+7)*C_width + B_start_index+0] = c[threadIdx.x][7][0];
	C[(A_start_index+7)*C_width + B_start_index+1] = c[threadIdx.x][7][1];
	C[(A_start_index+7)*C_width + B_start_index+2] = c[threadIdx.x][7][2];
	C[(A_start_index+7)*C_width + B_start_index+3] = c[threadIdx.x][7][3];
	C[(A_start_index+7)*C_width + B_start_index+4] = c[threadIdx.x][7][4];
	C[(A_start_index+7)*C_width + B_start_index+5] = c[threadIdx.x][7][5];
	C[(A_start_index+7)*C_width + B_start_index+6] = c[threadIdx.x][7][6];
	C[(A_start_index+7)*C_width + B_start_index+7] = c[threadIdx.x][7][7];
	C[(A_start_index+7)*C_width + B_start_index+8] = c[threadIdx.x][7][8];
	C[(A_start_index+7)*C_width + B_start_index+9] = c[threadIdx.x][7][9];
	C[(A_start_index+8)*C_width + B_start_index+0] = c[threadIdx.x][8][0];
	C[(A_start_index+8)*C_width + B_start_index+1] = c[threadIdx.x][8][1];
	C[(A_start_index+8)*C_width + B_start_index+2] = c[threadIdx.x][8][2];
	C[(A_start_index+8)*C_width + B_start_index+3] = c[threadIdx.x][8][3];
	C[(A_start_index+8)*C_width + B_start_index+4] = c[threadIdx.x][8][4];
	C[(A_start_index+8)*C_width + B_start_index+5] = c[threadIdx.x][8][5];
	C[(A_start_index+8)*C_width + B_start_index+6] = c[threadIdx.x][8][6];
	C[(A_start_index+8)*C_width + B_start_index+7] = c[threadIdx.x][8][7];
	C[(A_start_index+8)*C_width + B_start_index+8] = c[threadIdx.x][8][8];
	C[(A_start_index+8)*C_width + B_start_index+9] = c[threadIdx.x][8][9];
	C[(A_start_index+9)*C_width + B_start_index+0] = c[threadIdx.x][9][0];
	C[(A_start_index+9)*C_width + B_start_index+1] = c[threadIdx.x][9][1];
	C[(A_start_index+9)*C_width + B_start_index+2] = c[threadIdx.x][9][2];
	C[(A_start_index+9)*C_width + B_start_index+3] = c[threadIdx.x][9][3];
	C[(A_start_index+9)*C_width + B_start_index+4] = c[threadIdx.x][9][4];
	C[(A_start_index+9)*C_width + B_start_index+5] = c[threadIdx.x][9][5];
	C[(A_start_index+9)*C_width + B_start_index+6] = c[threadIdx.x][9][6];
	C[(A_start_index+9)*C_width + B_start_index+7] = c[threadIdx.x][9][7];
	C[(A_start_index+9)*C_width + B_start_index+8] = c[threadIdx.x][9][8];
	C[(A_start_index+9)*C_width + B_start_index+9] = c[threadIdx.x][9][9];


}
