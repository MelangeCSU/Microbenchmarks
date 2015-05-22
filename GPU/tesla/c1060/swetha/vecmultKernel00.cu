/** size of A = 384
    size of B = 360
    gridDim = 60
    blockDim = 64
    k= 400000
    x = 6
**/

#define max(x,y)   ((x)>(y) ? (x) : (y))
__global__ void MultiplyVectors(const int* A, const int* B, int* C, int x, int k)
{
	int B_start_index = (blockIdx.x*gridDim.y + blockIdx.y)*x;
	int A_start_index = (threadIdx.x*blockDim.y + threadIdx.y)*x;
	int C_width = x*gridDim.x*gridDim.y;


	int t;
	int c_0_0, c_0_1, c_0_2, c_0_3, c_0_4, c_0_5, c_1_0, c_1_1, c_1_2, c_1_3, c_1_4, c_1_5, c_2_0, c_2_1, c_2_2, c_2_3, c_2_4, c_2_5, c_3_0, c_3_1, c_3_2, c_3_3, c_3_4, c_3_5, c_4_0, c_4_1, c_4_2, c_4_3, c_4_4, c_4_5, c_5_0, c_5_1, c_5_2, c_5_3, c_5_4, c_5_5;
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


	c_0_0 = 0;
	c_0_1 = 0;
	c_0_2 = 0;
	c_0_3 = 0;
	c_0_4 = 0;
	c_0_5 = 0;
	c_1_0 = 0;
	c_1_1 = 0;
	c_1_2 = 0;
	c_1_3 = 0;
	c_1_4 = 0;
	c_1_5 = 0;
	c_2_0 = 0;
	c_2_1 = 0;
	c_2_2 = 0;
	c_2_3 = 0;
	c_2_4 = 0;
	c_2_5 = 0;
	c_3_0 = 0;
	c_3_1 = 0;
	c_3_2 = 0;
	c_3_3 = 0;
	c_3_4 = 0;
	c_3_5 = 0;
	c_4_0 = 0;
	c_4_1 = 0;
	c_4_2 = 0;
	c_4_3 = 0;
	c_4_4 = 0;
	c_4_5 = 0;
	c_5_0 = 0;
	c_5_1 = 0;
	c_5_2 = 0;
	c_5_3 = 0;
	c_5_4 = 0;
	c_5_5 = 0;


	for (t = 0; t < 400000; t++) {
		c_0_0 = max(c_0_0 ,a_0+b_0);
		c_0_1 = max(c_0_1 ,a_0+b_1);
		c_0_2 = max(c_0_2 ,a_0+b_2);
		c_0_3 = max(c_0_3 ,a_0+b_3);
		c_0_4 = max(c_0_4 ,a_0+b_4);
		c_0_5 = max(c_0_5 ,a_0+b_5);
		c_1_0 = max(c_1_0 ,a_1+b_0);
		c_1_1 = max(c_1_1 ,a_1+b_1);
		c_1_2 = max(c_1_2 ,a_1+b_2);
		c_1_3 = max(c_1_3 ,a_1+b_3);
		c_1_4 = max(c_1_4 ,a_1+b_4);
		c_1_5 = max(c_1_5 ,a_1+b_5);
		c_2_0 = max(c_2_0 ,a_2+b_0);
		c_2_1 = max(c_2_1 ,a_2+b_1);
		c_2_2 = max(c_2_2 ,a_2+b_2);
		c_2_3 = max(c_2_3 ,a_2+b_3);
		c_2_4 = max(c_2_4 ,a_2+b_4);
		c_2_5 = max(c_2_5 ,a_2+b_5);
		c_3_0 = max(c_3_0 ,a_3+b_0);
		c_3_1 = max(c_3_1 ,a_3+b_1);
		c_3_2 = max(c_3_2 ,a_3+b_2);
		c_3_3 = max(c_3_3 ,a_3+b_3);
		c_3_4 = max(c_3_4 ,a_3+b_4);
		c_3_5 = max(c_3_5 ,a_3+b_5);
		c_4_0 = max(c_4_0 ,a_4+b_0);
		c_4_1 = max(c_4_1 ,a_4+b_1);
		c_4_2 = max(c_4_2 ,a_4+b_2);
		c_4_3 = max(c_4_3 ,a_4+b_3);
		c_4_4 = max(c_4_4 ,a_4+b_4);
		c_4_5 = max(c_4_5 ,a_4+b_5);
		c_5_0 = max(c_5_0 ,a_5+b_0);
		c_5_1 = max(c_5_1 ,a_5+b_1);
		c_5_2 = max(c_5_2 ,a_5+b_2);
		c_5_3 = max(c_5_3 ,a_5+b_3);
		c_5_4 = max(c_5_4 ,a_5+b_4);
		c_5_5 = max(c_5_5 ,a_5+b_5);


		a_0 = max(a_0,a_0+b_5);
		a_1 = max(a_1,a_1+b_4);
		a_2 = max(a_2,a_2+b_3);
		a_3 = max(a_3,a_3+b_2);
		a_4 = max(a_4,a_4+b_1);
		a_5 = max(a_5,a_5+b_0);


		b_0 =  max(b_0,b_0+a_5);
		b_1 =  max(b_1,b_1+a_4);
		b_2 =  max(b_2,b_2+a_3);
		b_3 =  max(b_3,b_3+a_2);
		b_4 =  max(b_4,b_4+a_1);
		b_5 =  max(b_5,b_5+a_0);


	}


	C[(A_start_index+0)*C_width + B_start_index+0] = c_0_0;
	C[(A_start_index+0)*C_width + B_start_index+1] = c_0_1;
	C[(A_start_index+0)*C_width + B_start_index+2] = c_0_2;
	C[(A_start_index+0)*C_width + B_start_index+3] = c_0_3;
	C[(A_start_index+0)*C_width + B_start_index+4] = c_0_4;
	C[(A_start_index+0)*C_width + B_start_index+5] = c_0_5;
	C[(A_start_index+1)*C_width + B_start_index+0] = c_1_0;
	C[(A_start_index+1)*C_width + B_start_index+1] = c_1_1;
	C[(A_start_index+1)*C_width + B_start_index+2] = c_1_2;
	C[(A_start_index+1)*C_width + B_start_index+3] = c_1_3;
	C[(A_start_index+1)*C_width + B_start_index+4] = c_1_4;
	C[(A_start_index+1)*C_width + B_start_index+5] = c_1_5;
	C[(A_start_index+2)*C_width + B_start_index+0] = c_2_0;
	C[(A_start_index+2)*C_width + B_start_index+1] = c_2_1;
	C[(A_start_index+2)*C_width + B_start_index+2] = c_2_2;
	C[(A_start_index+2)*C_width + B_start_index+3] = c_2_3;
	C[(A_start_index+2)*C_width + B_start_index+4] = c_2_4;
	C[(A_start_index+2)*C_width + B_start_index+5] = c_2_5;
	C[(A_start_index+3)*C_width + B_start_index+0] = c_3_0;
	C[(A_start_index+3)*C_width + B_start_index+1] = c_3_1;
	C[(A_start_index+3)*C_width + B_start_index+2] = c_3_2;
	C[(A_start_index+3)*C_width + B_start_index+3] = c_3_3;
	C[(A_start_index+3)*C_width + B_start_index+4] = c_3_4;
	C[(A_start_index+3)*C_width + B_start_index+5] = c_3_5;
	C[(A_start_index+4)*C_width + B_start_index+0] = c_4_0;
	C[(A_start_index+4)*C_width + B_start_index+1] = c_4_1;
	C[(A_start_index+4)*C_width + B_start_index+2] = c_4_2;
	C[(A_start_index+4)*C_width + B_start_index+3] = c_4_3;
	C[(A_start_index+4)*C_width + B_start_index+4] = c_4_4;
	C[(A_start_index+4)*C_width + B_start_index+5] = c_4_5;
	C[(A_start_index+5)*C_width + B_start_index+0] = c_5_0;
	C[(A_start_index+5)*C_width + B_start_index+1] = c_5_1;
	C[(A_start_index+5)*C_width + B_start_index+2] = c_5_2;
	C[(A_start_index+5)*C_width + B_start_index+3] = c_5_3;
	C[(A_start_index+5)*C_width + B_start_index+4] = c_5_4;
	C[(A_start_index+5)*C_width + B_start_index+5] = c_5_5;


}
