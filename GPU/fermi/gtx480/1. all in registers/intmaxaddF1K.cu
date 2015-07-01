/*Author: Swetha Varadarajan 6/10/2015
 Adapted from Waruna Ranasinghe's summer 2014 work on kpdp micro-benchmarking 
 Code generated from intmazaddF1CG.c 
 Parameters list
size of A = 2048
    size of B = 3720
    gridDim = 465
    blockDim = 256
    Iterations k= 800000
   Values per thread x = 8
*/

__global__ void IntmaxaddF1(const int* A, const int* B, int* C, int x, int k)
{
	int B_start_index = (blockIdx.x*gridDim.y + blockIdx.y)*x;
	int A_start_index = (threadIdx.x*blockDim.y + threadIdx.y)*x;
	int C_width = x*gridDim.x*gridDim.y;


	int t;
	int c_0_0, c_0_1, c_0_2, c_0_3, c_0_4, c_0_5, c_0_6, c_0_7, c_1_0, c_1_1, c_1_2, c_1_3, c_1_4, c_1_5, c_1_6, c_1_7, c_2_0, c_2_1, c_2_2, c_2_3, c_2_4, c_2_5, c_2_6, c_2_7, c_3_0, c_3_1, c_3_2, c_3_3, c_3_4, c_3_5, c_3_6, c_3_7, c_4_0, c_4_1, c_4_2, c_4_3, c_4_4, c_4_5, c_4_6, c_4_7, c_5_0, c_5_1, c_5_2, c_5_3, c_5_4, c_5_5, c_5_6, c_5_7, c_6_0, c_6_1, c_6_2, c_6_3, c_6_4, c_6_5, c_6_6, c_6_7, c_7_0, c_7_1, c_7_2, c_7_3, c_7_4, c_7_5, c_7_6, c_7_7;
	int a_0, a_1, a_2, a_3, a_4, a_5, a_6, a_7;
	int b_0, b_1, b_2, b_3, b_4, b_5, b_6, b_7;


	a_0 = A[A_start_index+0];
	a_1 = A[A_start_index+1];
	a_2 = A[A_start_index+2];
	a_3 = A[A_start_index+3];
	a_4 = A[A_start_index+4];
	a_5 = A[A_start_index+5];
	a_6 = A[A_start_index+6];
	a_7 = A[A_start_index+7];


	b_0 = B[B_start_index+0];
	b_1 = B[B_start_index+1];
	b_2 = B[B_start_index+2];
	b_3 = B[B_start_index+3];
	b_4 = B[B_start_index+4];
	b_5 = B[B_start_index+5];
	b_6 = B[B_start_index+6];
	b_7 = B[B_start_index+7];


	c_0_0 = 0;
	c_0_1 = 0;
	c_0_2 = 0;
	c_0_3 = 0;
	c_0_4 = 0;
	c_0_5 = 0;
	c_0_6 = 0;
	c_0_7 = 0;
	c_1_0 = 0;
	c_1_1 = 0;
	c_1_2 = 0;
	c_1_3 = 0;
	c_1_4 = 0;
	c_1_5 = 0;
	c_1_6 = 0;
	c_1_7 = 0;
	c_2_0 = 0;
	c_2_1 = 0;
	c_2_2 = 0;
	c_2_3 = 0;
	c_2_4 = 0;
	c_2_5 = 0;
	c_2_6 = 0;
	c_2_7 = 0;
	c_3_0 = 0;
	c_3_1 = 0;
	c_3_2 = 0;
	c_3_3 = 0;
	c_3_4 = 0;
	c_3_5 = 0;
	c_3_6 = 0;
	c_3_7 = 0;
	c_4_0 = 0;
	c_4_1 = 0;
	c_4_2 = 0;
	c_4_3 = 0;
	c_4_4 = 0;
	c_4_5 = 0;
	c_4_6 = 0;
	c_4_7 = 0;
	c_5_0 = 0;
	c_5_1 = 0;
	c_5_2 = 0;
	c_5_3 = 0;
	c_5_4 = 0;
	c_5_5 = 0;
	c_5_6 = 0;
	c_5_7 = 0;
	c_6_0 = 0;
	c_6_1 = 0;
	c_6_2 = 0;
	c_6_3 = 0;
	c_6_4 = 0;
	c_6_5 = 0;
	c_6_6 = 0;
	c_6_7 = 0;
	c_7_0 = 0;
	c_7_1 = 0;
	c_7_2 = 0;
	c_7_3 = 0;
	c_7_4 = 0;
	c_7_5 = 0;
	c_7_6 = 0;
	c_7_7 = 0;


	for (t = 0; t < k; t++) {
		c_0_0 = max(a_0,c_0_0+b_0);
		c_0_1 = max(a_0,c_0_1+b_1);
		c_0_2 = max(a_0,c_0_2+b_2);
		c_0_3 = max(a_0,c_0_3+b_3);
		c_0_4 = max(a_0,c_0_4+b_4);
		c_0_5 = max(a_0,c_0_5+b_5);
		c_0_6 = max(a_0,c_0_6+b_6);
		c_0_7 = max(a_0,c_0_7+b_7);
		c_1_0 = max(a_1,c_1_0+b_0);
		c_1_1 = max(a_1,c_1_1+b_1);
		c_1_2 = max(a_1,c_1_2+b_2);
		c_1_3 = max(a_1,c_1_3+b_3);
		c_1_4 = max(a_1,c_1_4+b_4);
		c_1_5 = max(a_1,c_1_5+b_5);
		c_1_6 = max(a_1,c_1_6+b_6);
		c_1_7 = max(a_1,c_1_7+b_7);
		c_2_0 = max(a_2,c_2_0+b_0);
		c_2_1 = max(a_2,c_2_1+b_1);
		c_2_2 = max(a_2,c_2_2+b_2);
		c_2_3 = max(a_2,c_2_3+b_3);
		c_2_4 = max(a_2,c_2_4+b_4);
		c_2_5 = max(a_2,c_2_5+b_5);
		c_2_6 = max(a_2,c_2_6+b_6);
		c_2_7 = max(a_2,c_2_7+b_7);
		c_3_0 = max(a_3,c_3_0+b_0);
		c_3_1 = max(a_3,c_3_1+b_1);
		c_3_2 = max(a_3,c_3_2+b_2);
		c_3_3 = max(a_3,c_3_3+b_3);
		c_3_4 = max(a_3,c_3_4+b_4);
		c_3_5 = max(a_3,c_3_5+b_5);
		c_3_6 = max(a_3,c_3_6+b_6);
		c_3_7 = max(a_3,c_3_7+b_7);
		c_4_0 = max(a_4,c_4_0+b_0);
		c_4_1 = max(a_4,c_4_1+b_1);
		c_4_2 = max(a_4,c_4_2+b_2);
		c_4_3 = max(a_4,c_4_3+b_3);
		c_4_4 = max(a_4,c_4_4+b_4);
		c_4_5 = max(a_4,c_4_5+b_5);
		c_4_6 = max(a_4,c_4_6+b_6);
		c_4_7 = max(a_4,c_4_7+b_7);
		c_5_0 = max(a_5,c_5_0+b_0);
		c_5_1 = max(a_5,c_5_1+b_1);
		c_5_2 = max(a_5,c_5_2+b_2);
		c_5_3 = max(a_5,c_5_3+b_3);
		c_5_4 = max(a_5,c_5_4+b_4);
		c_5_5 = max(a_5,c_5_5+b_5);
		c_5_6 = max(a_5,c_5_6+b_6);
		c_5_7 = max(a_5,c_5_7+b_7);
		c_6_0 = max(a_6,c_6_0+b_0);
		c_6_1 = max(a_6,c_6_1+b_1);
		c_6_2 = max(a_6,c_6_2+b_2);
		c_6_3 = max(a_6,c_6_3+b_3);
		c_6_4 = max(a_6,c_6_4+b_4);
		c_6_5 = max(a_6,c_6_5+b_5);
		c_6_6 = max(a_6,c_6_6+b_6);
		c_6_7 = max(a_6,c_6_7+b_7);
		c_7_0 = max(a_7,c_7_0+b_0);
		c_7_1 = max(a_7,c_7_1+b_1);
		c_7_2 = max(a_7,c_7_2+b_2);
		c_7_3 = max(a_7,c_7_3+b_3);
		c_7_4 = max(a_7,c_7_4+b_4);
		c_7_5 = max(a_7,c_7_5+b_5);
		c_7_6 = max(a_7,c_7_6+b_6);
		c_7_7 = max(a_7,c_7_7+b_7);


		a_0 = max(a_0,b_7+c_0_7);
		a_1 = max(a_1,b_6+c_1_6);
		a_2 = max(a_2,b_5+c_2_5);
		a_3 = max(a_3,b_4+c_3_4);
		a_4 = max(a_4,b_3+c_4_3);
		a_5 = max(a_5,b_2+c_5_2);
		a_6 = max(a_6,b_1+c_6_1);
		a_7 = max(a_7,b_0+c_7_0);


		b_0 =  max(b_0,a_7+c_0_7);
		b_1 =  max(b_1,a_6+c_1_6);
		b_2 =  max(b_2,a_5+c_2_5);
		b_3 =  max(b_3,a_4+c_3_4);
		b_4 =  max(b_4,a_3+c_4_3);
		b_5 =  max(b_5,a_2+c_5_2);
		b_6 =  max(b_6,a_1+c_6_1);
		b_7 =  max(b_7,a_0+c_7_0);


	}


	C[(A_start_index+0)*C_width + B_start_index+0] = c_0_0;
	C[(A_start_index+0)*C_width + B_start_index+1] = c_0_1;
	C[(A_start_index+0)*C_width + B_start_index+2] = c_0_2;
	C[(A_start_index+0)*C_width + B_start_index+3] = c_0_3;
	C[(A_start_index+0)*C_width + B_start_index+4] = c_0_4;
	C[(A_start_index+0)*C_width + B_start_index+5] = c_0_5;
	C[(A_start_index+0)*C_width + B_start_index+6] = c_0_6;
	C[(A_start_index+0)*C_width + B_start_index+7] = c_0_7;
	C[(A_start_index+1)*C_width + B_start_index+0] = c_1_0;
	C[(A_start_index+1)*C_width + B_start_index+1] = c_1_1;
	C[(A_start_index+1)*C_width + B_start_index+2] = c_1_2;
	C[(A_start_index+1)*C_width + B_start_index+3] = c_1_3;
	C[(A_start_index+1)*C_width + B_start_index+4] = c_1_4;
	C[(A_start_index+1)*C_width + B_start_index+5] = c_1_5;
	C[(A_start_index+1)*C_width + B_start_index+6] = c_1_6;
	C[(A_start_index+1)*C_width + B_start_index+7] = c_1_7;
	C[(A_start_index+2)*C_width + B_start_index+0] = c_2_0;
	C[(A_start_index+2)*C_width + B_start_index+1] = c_2_1;
	C[(A_start_index+2)*C_width + B_start_index+2] = c_2_2;
	C[(A_start_index+2)*C_width + B_start_index+3] = c_2_3;
	C[(A_start_index+2)*C_width + B_start_index+4] = c_2_4;
	C[(A_start_index+2)*C_width + B_start_index+5] = c_2_5;
	C[(A_start_index+2)*C_width + B_start_index+6] = c_2_6;
	C[(A_start_index+2)*C_width + B_start_index+7] = c_2_7;
	C[(A_start_index+3)*C_width + B_start_index+0] = c_3_0;
	C[(A_start_index+3)*C_width + B_start_index+1] = c_3_1;
	C[(A_start_index+3)*C_width + B_start_index+2] = c_3_2;
	C[(A_start_index+3)*C_width + B_start_index+3] = c_3_3;
	C[(A_start_index+3)*C_width + B_start_index+4] = c_3_4;
	C[(A_start_index+3)*C_width + B_start_index+5] = c_3_5;
	C[(A_start_index+3)*C_width + B_start_index+6] = c_3_6;
	C[(A_start_index+3)*C_width + B_start_index+7] = c_3_7;
	C[(A_start_index+4)*C_width + B_start_index+0] = c_4_0;
	C[(A_start_index+4)*C_width + B_start_index+1] = c_4_1;
	C[(A_start_index+4)*C_width + B_start_index+2] = c_4_2;
	C[(A_start_index+4)*C_width + B_start_index+3] = c_4_3;
	C[(A_start_index+4)*C_width + B_start_index+4] = c_4_4;
	C[(A_start_index+4)*C_width + B_start_index+5] = c_4_5;
	C[(A_start_index+4)*C_width + B_start_index+6] = c_4_6;
	C[(A_start_index+4)*C_width + B_start_index+7] = c_4_7;
	C[(A_start_index+5)*C_width + B_start_index+0] = c_5_0;
	C[(A_start_index+5)*C_width + B_start_index+1] = c_5_1;
	C[(A_start_index+5)*C_width + B_start_index+2] = c_5_2;
	C[(A_start_index+5)*C_width + B_start_index+3] = c_5_3;
	C[(A_start_index+5)*C_width + B_start_index+4] = c_5_4;
	C[(A_start_index+5)*C_width + B_start_index+5] = c_5_5;
	C[(A_start_index+5)*C_width + B_start_index+6] = c_5_6;
	C[(A_start_index+5)*C_width + B_start_index+7] = c_5_7;
	C[(A_start_index+6)*C_width + B_start_index+0] = c_6_0;
	C[(A_start_index+6)*C_width + B_start_index+1] = c_6_1;
	C[(A_start_index+6)*C_width + B_start_index+2] = c_6_2;
	C[(A_start_index+6)*C_width + B_start_index+3] = c_6_3;
	C[(A_start_index+6)*C_width + B_start_index+4] = c_6_4;
	C[(A_start_index+6)*C_width + B_start_index+5] = c_6_5;
	C[(A_start_index+6)*C_width + B_start_index+6] = c_6_6;
	C[(A_start_index+6)*C_width + B_start_index+7] = c_6_7;
	C[(A_start_index+7)*C_width + B_start_index+0] = c_7_0;
	C[(A_start_index+7)*C_width + B_start_index+1] = c_7_1;
	C[(A_start_index+7)*C_width + B_start_index+2] = c_7_2;
	C[(A_start_index+7)*C_width + B_start_index+3] = c_7_3;
	C[(A_start_index+7)*C_width + B_start_index+4] = c_7_4;
	C[(A_start_index+7)*C_width + B_start_index+5] = c_7_5;
	C[(A_start_index+7)*C_width + B_start_index+6] = c_7_6;
	C[(A_start_index+7)*C_width + B_start_index+7] = c_7_7;


}
