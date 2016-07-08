/** This file has been generated by CodeGenInt_max.c
    size of A = 576
    size of B = 540
    gridDim = 60
    blockDim = 64
    k= 500000
    x = 9
**/

__global__ void CompareAddVectors(const int* A, const int* B, int* C, int x, int k)
{
	int B_start_index = (blockIdx.x*gridDim.y + blockIdx.y)*x;
	int A_start_index = (threadIdx.x*blockDim.y + threadIdx.y)*x;
	int C_width = x*gridDim.x*gridDim.y;


	int t;
	int c_0_0, c_0_1, c_0_2, c_0_3, c_0_4, c_0_5, c_0_6, c_0_7, c_0_8, c_1_0, c_1_1, c_1_2, c_1_3, c_1_4, c_1_5, c_1_6, c_1_7, c_1_8, c_2_0, c_2_1, c_2_2, c_2_3, c_2_4, c_2_5, c_2_6, c_2_7, c_2_8, c_3_0, c_3_1, c_3_2, c_3_3, c_3_4, c_3_5, c_3_6, c_3_7, c_3_8, c_4_0, c_4_1, c_4_2, c_4_3, c_4_4, c_4_5, c_4_6, c_4_7, c_4_8, c_5_0, c_5_1, c_5_2, c_5_3, c_5_4, c_5_5, c_5_6, c_5_7, c_5_8, c_6_0, c_6_1, c_6_2, c_6_3, c_6_4, c_6_5, c_6_6, c_6_7, c_6_8, c_7_0, c_7_1, c_7_2, c_7_3, c_7_4, c_7_5, c_7_6, c_7_7, c_7_8, c_8_0, c_8_1, c_8_2, c_8_3, c_8_4, c_8_5, c_8_6, c_8_7, c_8_8;
	int a_0, a_1, a_2, a_3, a_4, a_5, a_6, a_7, a_8;
	int b_0, b_1, b_2, b_3, b_4, b_5, b_6, b_7, b_8;


	a_0 = A[A_start_index+0];
	a_1 = A[A_start_index+1];
	a_2 = A[A_start_index+2];
	a_3 = A[A_start_index+3];
	a_4 = A[A_start_index+4];
	a_5 = A[A_start_index+5];
	a_6 = A[A_start_index+6];
	a_7 = A[A_start_index+7];
	a_8 = A[A_start_index+8];


	b_0 = B[B_start_index+0];
	b_1 = B[B_start_index+1];
	b_2 = B[B_start_index+2];
	b_3 = B[B_start_index+3];
	b_4 = B[B_start_index+4];
	b_5 = B[B_start_index+5];
	b_6 = B[B_start_index+6];
	b_7 = B[B_start_index+7];
	b_8 = B[B_start_index+8];


	c_0_0 = 0;
	c_0_1 = 0;
	c_0_2 = 0;
	c_0_3 = 0;
	c_0_4 = 0;
	c_0_5 = 0;
	c_0_6 = 0;
	c_0_7 = 0;
	c_0_8 = 0;
	c_1_0 = 0;
	c_1_1 = 0;
	c_1_2 = 0;
	c_1_3 = 0;
	c_1_4 = 0;
	c_1_5 = 0;
	c_1_6 = 0;
	c_1_7 = 0;
	c_1_8 = 0;
	c_2_0 = 0;
	c_2_1 = 0;
	c_2_2 = 0;
	c_2_3 = 0;
	c_2_4 = 0;
	c_2_5 = 0;
	c_2_6 = 0;
	c_2_7 = 0;
	c_2_8 = 0;
	c_3_0 = 0;
	c_3_1 = 0;
	c_3_2 = 0;
	c_3_3 = 0;
	c_3_4 = 0;
	c_3_5 = 0;
	c_3_6 = 0;
	c_3_7 = 0;
	c_3_8 = 0;
	c_4_0 = 0;
	c_4_1 = 0;
	c_4_2 = 0;
	c_4_3 = 0;
	c_4_4 = 0;
	c_4_5 = 0;
	c_4_6 = 0;
	c_4_7 = 0;
	c_4_8 = 0;
	c_5_0 = 0;
	c_5_1 = 0;
	c_5_2 = 0;
	c_5_3 = 0;
	c_5_4 = 0;
	c_5_5 = 0;
	c_5_6 = 0;
	c_5_7 = 0;
	c_5_8 = 0;
	c_6_0 = 0;
	c_6_1 = 0;
	c_6_2 = 0;
	c_6_3 = 0;
	c_6_4 = 0;
	c_6_5 = 0;
	c_6_6 = 0;
	c_6_7 = 0;
	c_6_8 = 0;
	c_7_0 = 0;
	c_7_1 = 0;
	c_7_2 = 0;
	c_7_3 = 0;
	c_7_4 = 0;
	c_7_5 = 0;
	c_7_6 = 0;
	c_7_7 = 0;
	c_7_8 = 0;
	c_8_0 = 0;
	c_8_1 = 0;
	c_8_2 = 0;
	c_8_3 = 0;
	c_8_4 = 0;
	c_8_5 = 0;
	c_8_6 = 0;
	c_8_7 = 0;
	c_8_8 = 0;


#pragma unroll
	for (t = 0; t < 500000; t++) {
		c_0_0 = max(c_0_0,a_0+b_0);
		c_0_1 = max(c_0_1,a_0+b_1);
		c_0_2 = max(c_0_2,a_0+b_2);
		c_0_3 = max(c_0_3,a_0+b_3);
		c_0_4 = max(c_0_4,a_0+b_4);
		c_0_5 = max(c_0_5,a_0+b_5);
		c_0_6 = max(c_0_6,a_0+b_6);
		c_0_7 = max(c_0_7,a_0+b_7);
		c_0_8 = max(c_0_8,a_0+b_8);
		c_1_0 = max(c_1_0,a_1+b_0);
		c_1_1 = max(c_1_1,a_1+b_1);
		c_1_2 = max(c_1_2,a_1+b_2);
		c_1_3 = max(c_1_3,a_1+b_3);
		c_1_4 = max(c_1_4,a_1+b_4);
		c_1_5 = max(c_1_5,a_1+b_5);
		c_1_6 = max(c_1_6,a_1+b_6);
		c_1_7 = max(c_1_7,a_1+b_7);
		c_1_8 = max(c_1_8,a_1+b_8);
		c_2_0 = max(c_2_0,a_2+b_0);
		c_2_1 = max(c_2_1,a_2+b_1);
		c_2_2 = max(c_2_2,a_2+b_2);
		c_2_3 = max(c_2_3,a_2+b_3);
		c_2_4 = max(c_2_4,a_2+b_4);
		c_2_5 = max(c_2_5,a_2+b_5);
		c_2_6 = max(c_2_6,a_2+b_6);
		c_2_7 = max(c_2_7,a_2+b_7);
		c_2_8 = max(c_2_8,a_2+b_8);
		c_3_0 = max(c_3_0,a_3+b_0);
		c_3_1 = max(c_3_1,a_3+b_1);
		c_3_2 = max(c_3_2,a_3+b_2);
		c_3_3 = max(c_3_3,a_3+b_3);
		c_3_4 = max(c_3_4,a_3+b_4);
		c_3_5 = max(c_3_5,a_3+b_5);
		c_3_6 = max(c_3_6,a_3+b_6);
		c_3_7 = max(c_3_7,a_3+b_7);
		c_3_8 = max(c_3_8,a_3+b_8);
		c_4_0 = max(c_4_0,a_4+b_0);
		c_4_1 = max(c_4_1,a_4+b_1);
		c_4_2 = max(c_4_2,a_4+b_2);
		c_4_3 = max(c_4_3,a_4+b_3);
		c_4_4 = max(c_4_4,a_4+b_4);
		c_4_5 = max(c_4_5,a_4+b_5);
		c_4_6 = max(c_4_6,a_4+b_6);
		c_4_7 = max(c_4_7,a_4+b_7);
		c_4_8 = max(c_4_8,a_4+b_8);
		c_5_0 = max(c_5_0,a_5+b_0);
		c_5_1 = max(c_5_1,a_5+b_1);
		c_5_2 = max(c_5_2,a_5+b_2);
		c_5_3 = max(c_5_3,a_5+b_3);
		c_5_4 = max(c_5_4,a_5+b_4);
		c_5_5 = max(c_5_5,a_5+b_5);
		c_5_6 = max(c_5_6,a_5+b_6);
		c_5_7 = max(c_5_7,a_5+b_7);
		c_5_8 = max(c_5_8,a_5+b_8);
		c_6_0 = max(c_6_0,a_6+b_0);
		c_6_1 = max(c_6_1,a_6+b_1);
		c_6_2 = max(c_6_2,a_6+b_2);
		c_6_3 = max(c_6_3,a_6+b_3);
		c_6_4 = max(c_6_4,a_6+b_4);
		c_6_5 = max(c_6_5,a_6+b_5);
		c_6_6 = max(c_6_6,a_6+b_6);
		c_6_7 = max(c_6_7,a_6+b_7);
		c_6_8 = max(c_6_8,a_6+b_8);
		c_7_0 = max(c_7_0,a_7+b_0);
		c_7_1 = max(c_7_1,a_7+b_1);
		c_7_2 = max(c_7_2,a_7+b_2);
		c_7_3 = max(c_7_3,a_7+b_3);
		c_7_4 = max(c_7_4,a_7+b_4);
		c_7_5 = max(c_7_5,a_7+b_5);
		c_7_6 = max(c_7_6,a_7+b_6);
		c_7_7 = max(c_7_7,a_7+b_7);
		c_7_8 = max(c_7_8,a_7+b_8);
		c_8_0 = max(c_8_0,a_8+b_0);
		c_8_1 = max(c_8_1,a_8+b_1);
		c_8_2 = max(c_8_2,a_8+b_2);
		c_8_3 = max(c_8_3,a_8+b_3);
		c_8_4 = max(c_8_4,a_8+b_4);
		c_8_5 = max(c_8_5,a_8+b_5);
		c_8_6 = max(c_8_6,a_8+b_6);
		c_8_7 = max(c_8_7,a_8+b_7);
		c_8_8 = max(c_8_8,a_8+b_8);


		a_0 = max(a_0, a_0+10);
		a_1 = max(a_1, a_1+10);
		a_2 = max(a_2, a_2+10);
		a_3 = max(a_3, a_3+10);
		a_4 = max(a_4, a_4+10);
		a_5 = max(a_5, a_5+10);
		a_6 = max(a_6, a_6+10);
		a_7 = max(a_7, a_7+10);
		a_8 = max(a_8, a_8+10);


		b_0 = max(b_0, b_0+10);
		b_1 = max(b_1, b_1+10);
		b_2 = max(b_2, b_2+10);
		b_3 = max(b_3, b_3+10);
		b_4 = max(b_4, b_4+10);
		b_5 = max(b_5, b_5+10);
		b_6 = max(b_6, b_6+10);
		b_7 = max(b_7, b_7+10);
		b_8 = max(b_8, b_8+10);


	}


	C[(A_start_index+0)*C_width + B_start_index+0] = c_0_0;
	C[(A_start_index+0)*C_width + B_start_index+1] = c_0_1;
	C[(A_start_index+0)*C_width + B_start_index+2] = c_0_2;
	C[(A_start_index+0)*C_width + B_start_index+3] = c_0_3;
	C[(A_start_index+0)*C_width + B_start_index+4] = c_0_4;
	C[(A_start_index+0)*C_width + B_start_index+5] = c_0_5;
	C[(A_start_index+0)*C_width + B_start_index+6] = c_0_6;
	C[(A_start_index+0)*C_width + B_start_index+7] = c_0_7;
	C[(A_start_index+0)*C_width + B_start_index+8] = c_0_8;
	C[(A_start_index+1)*C_width + B_start_index+0] = c_1_0;
	C[(A_start_index+1)*C_width + B_start_index+1] = c_1_1;
	C[(A_start_index+1)*C_width + B_start_index+2] = c_1_2;
	C[(A_start_index+1)*C_width + B_start_index+3] = c_1_3;
	C[(A_start_index+1)*C_width + B_start_index+4] = c_1_4;
	C[(A_start_index+1)*C_width + B_start_index+5] = c_1_5;
	C[(A_start_index+1)*C_width + B_start_index+6] = c_1_6;
	C[(A_start_index+1)*C_width + B_start_index+7] = c_1_7;
	C[(A_start_index+1)*C_width + B_start_index+8] = c_1_8;
	C[(A_start_index+2)*C_width + B_start_index+0] = c_2_0;
	C[(A_start_index+2)*C_width + B_start_index+1] = c_2_1;
	C[(A_start_index+2)*C_width + B_start_index+2] = c_2_2;
	C[(A_start_index+2)*C_width + B_start_index+3] = c_2_3;
	C[(A_start_index+2)*C_width + B_start_index+4] = c_2_4;
	C[(A_start_index+2)*C_width + B_start_index+5] = c_2_5;
	C[(A_start_index+2)*C_width + B_start_index+6] = c_2_6;
	C[(A_start_index+2)*C_width + B_start_index+7] = c_2_7;
	C[(A_start_index+2)*C_width + B_start_index+8] = c_2_8;
	C[(A_start_index+3)*C_width + B_start_index+0] = c_3_0;
	C[(A_start_index+3)*C_width + B_start_index+1] = c_3_1;
	C[(A_start_index+3)*C_width + B_start_index+2] = c_3_2;
	C[(A_start_index+3)*C_width + B_start_index+3] = c_3_3;
	C[(A_start_index+3)*C_width + B_start_index+4] = c_3_4;
	C[(A_start_index+3)*C_width + B_start_index+5] = c_3_5;
	C[(A_start_index+3)*C_width + B_start_index+6] = c_3_6;
	C[(A_start_index+3)*C_width + B_start_index+7] = c_3_7;
	C[(A_start_index+3)*C_width + B_start_index+8] = c_3_8;
	C[(A_start_index+4)*C_width + B_start_index+0] = c_4_0;
	C[(A_start_index+4)*C_width + B_start_index+1] = c_4_1;
	C[(A_start_index+4)*C_width + B_start_index+2] = c_4_2;
	C[(A_start_index+4)*C_width + B_start_index+3] = c_4_3;
	C[(A_start_index+4)*C_width + B_start_index+4] = c_4_4;
	C[(A_start_index+4)*C_width + B_start_index+5] = c_4_5;
	C[(A_start_index+4)*C_width + B_start_index+6] = c_4_6;
	C[(A_start_index+4)*C_width + B_start_index+7] = c_4_7;
	C[(A_start_index+4)*C_width + B_start_index+8] = c_4_8;
	C[(A_start_index+5)*C_width + B_start_index+0] = c_5_0;
	C[(A_start_index+5)*C_width + B_start_index+1] = c_5_1;
	C[(A_start_index+5)*C_width + B_start_index+2] = c_5_2;
	C[(A_start_index+5)*C_width + B_start_index+3] = c_5_3;
	C[(A_start_index+5)*C_width + B_start_index+4] = c_5_4;
	C[(A_start_index+5)*C_width + B_start_index+5] = c_5_5;
	C[(A_start_index+5)*C_width + B_start_index+6] = c_5_6;
	C[(A_start_index+5)*C_width + B_start_index+7] = c_5_7;
	C[(A_start_index+5)*C_width + B_start_index+8] = c_5_8;
	C[(A_start_index+6)*C_width + B_start_index+0] = c_6_0;
	C[(A_start_index+6)*C_width + B_start_index+1] = c_6_1;
	C[(A_start_index+6)*C_width + B_start_index+2] = c_6_2;
	C[(A_start_index+6)*C_width + B_start_index+3] = c_6_3;
	C[(A_start_index+6)*C_width + B_start_index+4] = c_6_4;
	C[(A_start_index+6)*C_width + B_start_index+5] = c_6_5;
	C[(A_start_index+6)*C_width + B_start_index+6] = c_6_6;
	C[(A_start_index+6)*C_width + B_start_index+7] = c_6_7;
	C[(A_start_index+6)*C_width + B_start_index+8] = c_6_8;
	C[(A_start_index+7)*C_width + B_start_index+0] = c_7_0;
	C[(A_start_index+7)*C_width + B_start_index+1] = c_7_1;
	C[(A_start_index+7)*C_width + B_start_index+2] = c_7_2;
	C[(A_start_index+7)*C_width + B_start_index+3] = c_7_3;
	C[(A_start_index+7)*C_width + B_start_index+4] = c_7_4;
	C[(A_start_index+7)*C_width + B_start_index+5] = c_7_5;
	C[(A_start_index+7)*C_width + B_start_index+6] = c_7_6;
	C[(A_start_index+7)*C_width + B_start_index+7] = c_7_7;
	C[(A_start_index+7)*C_width + B_start_index+8] = c_7_8;
	C[(A_start_index+8)*C_width + B_start_index+0] = c_8_0;
	C[(A_start_index+8)*C_width + B_start_index+1] = c_8_1;
	C[(A_start_index+8)*C_width + B_start_index+2] = c_8_2;
	C[(A_start_index+8)*C_width + B_start_index+3] = c_8_3;
	C[(A_start_index+8)*C_width + B_start_index+4] = c_8_4;
	C[(A_start_index+8)*C_width + B_start_index+5] = c_8_5;
	C[(A_start_index+8)*C_width + B_start_index+6] = c_8_6;
	C[(A_start_index+8)*C_width + B_start_index+7] = c_8_7;
	C[(A_start_index+8)*C_width + B_start_index+8] = c_8_8;


}
