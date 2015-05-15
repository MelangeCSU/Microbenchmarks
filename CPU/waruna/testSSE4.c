/* Test program to figure out how to use sse4 intrinsics, datatypes and
 * compilation
 *
 */
 
#include <stdio.h>
#include <smmintrin.h>
#include "timer.h"

//#define _mm_extract_epi32(x, imm) \
//_mm_cvtsi128_si32(_mm_srli_si128((x), 4 * (imm)))
//

#define MAX(a,b) \
	   ({ __typeof__ (a) _a = (a); \
			       __typeof__ (b) _b = (b); \
			     _a > _b ? _a : _b; })

#define REPS 100
#define IREPS 1000000

void compute (int *cc, int *aa, int *bb);
void t_print__m128i (__m128i a);
void t_test (__m128i *c, int *cc);

int main () 
{
//	printf("sizeof int: %d\n", sizeof(short));

	int aa[4] = {1,2,3,4};
	int bb[4] = {0,2,4,9};
	int cc[16] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
	//int cc[16] = {1,2,4,9,1,2,4,9,1,2,4,9,1,2,4,9};
	int j;
	int k;

	__m128i c[4];
	__m128i a = _mm_set_epi32(4,3,2,1);
	__m128i b = _mm_set_epi32(9,4,2,0);
	__m128i b_1 = _mm_set_epi32(1,2,3,4);
	c[0] = _mm_set_epi32(0,0,0,0);
	c[1] = _mm_set_epi32(0,0,0,0);
	c[2] = _mm_set_epi32(0,0,0,0);
	c[3] = _mm_set_epi32(0,0,0,0);
	/*__m128i c0 = _mm_set_epi32(0,0,0,0);
	__m128i c1 = _mm_set_epi32(0,0,0,0);
	__m128i c2 = _mm_set_epi32(0,0,0,0);
	__m128i c3 = _mm_set_epi32(0,0,0,0);
*/
	initialize_timer();
	start_timer();
	
	for (k = 0; k < REPS; k++) {
//#pragma omp parallel for private(a,b)
		for (j = 0; j < IREPS; j++) {
			/*c[0] = _mm_max_epi32(_mm_add_epi32(b,a), b);
			c[1] = _mm_max_epi32(_mm_add_epi32(b,a), b);
			c[2] = _mm_max_epi32(_mm_add_epi32(b,a), b);
			c[3] = _mm_max_epi32(_mm_add_epi32(b,a), b);
			*/
			c[0] = _mm_max_epi32(_mm_add_epi32(c[0],a), b);
			c[1] = _mm_max_epi32(_mm_add_epi32(c[1],a), b);
			c[2] = _mm_max_epi32(_mm_add_epi32(c[2],a), b);
			c[3] = _mm_max_epi32(_mm_add_epi32(c[3],a), b);
			/*
			b =  _mm_max_epi32(_mm_add_epi32(b_1,a), b);
			a =  _mm_max_epi32(_mm_add_epi32(b_1,b), a);
			*/
		}
	}
	
	stop_timer();
	double vector_time = elapsed_time();
/*	t_print__m128i(a);
	t_print__m128i(b);
	t_print__m128i(c[0]);
	t_print__m128i(c[1]);
	t_print__m128i(c[2]);
	t_print__m128i(c[3]);
*/
	compute(cc, aa, bb);
	t_test(c, cc);

	printf("time: %f s GOPS: %f\n", vector_time, (((double)(2*4*4*IREPS)*(double)REPS)/vector_time)/(1e9));

	return 0;
} 

void compute (int *cc, int *aa, int *bb) 
{
	int i,j,k;
	for (k=0; k<REPS; k++) 
	{
		for (j=0; j<IREPS; j++) 
		{
			for (i=0; i<16; i++) 
			{
				cc[i] = MAX(cc[i]+aa[i%4], bb[i%4]);
			}
		}
	}
}

void t_print__m128i (__m128i a) 
{
	printf("%d = %d\n", 0, _mm_extract_epi32(a, 0));
	printf("%d = %d\n", 1, _mm_extract_epi32(a, 1));
	printf("%d = %d\n", 2, _mm_extract_epi32(a, 2));
	printf("%d = %d\n", 3, _mm_extract_epi32(a, 3));
	printf("\n");
}

void t_test (__m128i *c, int *cc)
{
	int i=0;
	for (i=0; i<4; i++) 
	{
		if (cc[i*4+0] != _mm_extract_epi32(c[i], 0))
		{
			printf("cc[%d]:%d != c[%d]:%d\n", i*4+0, cc[i*4+0], i*4+0, _mm_extract_epi32(c[i], 0));
		}
		if (cc[i*4+1] != _mm_extract_epi32(c[i], 1))
		{
			printf("cc[%d]:%d != c[%d]:%d\n", i*4+1, cc[i*4+1], i*4+1, _mm_extract_epi32(c[i], 1));
		}
		if (cc[i*4+2] != _mm_extract_epi32(c[i], 2))
		{
			printf("cc[%d]:%d != c[%d]:%d\n", i*4+2, cc[i*4+2], i*4+2, _mm_extract_epi32(c[i], 2));
		}
		if (cc[i*4+3] != _mm_extract_epi32(c[i], 3))
		{
			printf("cc[%d]:%d != c[%d]:%d\n", i*4+3, cc[i*4+3], i*4+3, _mm_extract_epi32(c[i], 3));
		}
	}
/*	int i;
	for (i = 0; i < 4; i++) 
	{
		printf("%d = %d\n", i, cc[i]);
	}
*/
}

