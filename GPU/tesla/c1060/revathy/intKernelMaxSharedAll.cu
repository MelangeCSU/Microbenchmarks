/** size of A = 640
    size of B = 300
    gridDim = 60
    blockDim = 128
    k= 200000
    x = 5
**/

__global__ void CompareAddVectors(const int* A, const int* B, int* C, int x, int k)
{
	int size_A = x*blockDim.x;
	int B_start_index = (blockIdx.x*gridDim.y + blockIdx.y)*x;

	int t,i,j,temp;
	__shared__ int c[5][640]; 
	 __shared__ int a[640]; 
	int b_0, b_1, b_2, b_3, b_4;


	for (t = 0; t < x; t++) {
		temp = blockDim.x*t + threadIdx.x;
		a[temp] = A[temp];
	}


	for (i = 0; i < x; i++) {
		for (t = 0; t < x; t++) {
			c[i][blockDim.x*t + threadIdx.x] = 0;
		}
	}


	__syncthreads(); 

	b_0 = B[B_start_index+0];
	b_1 = B[B_start_index+1];
	b_2 = B[B_start_index+2];
	b_3 = B[B_start_index+3];
	b_4 = B[B_start_index+4];




	for (t = 0; t < k; t++) {
		#pragma unroll
		for (j = 0; j < x; j++) {
			temp = blockDim.x*j+threadIdx.x;
			c[0][temp] = max(a[temp]+b_0, c[0][temp]);
			c[1][temp] = max(a[temp]+b_1, c[1][temp]);
			c[2][temp] = max(a[temp]+b_2, c[2][temp]);
			c[3][temp] = max(a[temp]+b_3, c[3][temp]);
			c[4][temp] = max(a[temp]+b_4, c[4][temp]);
		}


		for (i = 0; i < x; i++) {
			temp = blockDim.x*i+threadIdx.x;
			a[temp] = max(a[temp]+10, a[temp]);
		}


		b_0 = max(b_0, b_0+10);
		b_1 = max(b_1, b_1+10);
		b_2 = max(b_2, b_2+10);
		b_3 = max(b_3, b_3+10);
		b_4 = max(b_4, b_4+10);


		__syncthreads();
	}


	for (i = 0; i < x; i++) {
		for (t = 0; t < x; t++) {
			temp = t*blockDim.x + threadIdx.x;
			C[(x*blockIdx.x+i)*size_A + temp] = c[i][temp];
		}
	}


}
