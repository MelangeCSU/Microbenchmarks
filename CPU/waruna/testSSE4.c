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

#define IREPS 100
#define REPS 10000000

void compute (int (*cc)[16], int *aa, int *bb, int *bb_1);
void t_print__m128i (__m128i a);
void t_test (__m128i (*c)[4], int (*cc)[16]);

int main () 
{
	int aa[4] = {1,2,3,4};
	int bb[4] = {0,2,4,9};
	int bb_1[4] = {1,3,2,1};
	int cc[IREPS][16];
	int i;
	int j;
	int k;

	for (j=0; j<IREPS; j++) 
	{
		for (i=0; i<16; i++) 
		{
			cc[j][i] = i+1;
		}
	}

	__m128i c[IREPS][4];
	__m128i a = _mm_set_epi32(4,3,2,1);
	__m128i b = _mm_set_epi32(9,4,2,0);
	__m128i b_1 = _mm_set_epi32(1,2,3,1);

	for (j = 0; j < IREPS; j++) {
		c[j][0] = _mm_set_epi32(4,3,2,1);
		c[j][1] = _mm_set_epi32(8,7,6,5);
		c[j][2] = _mm_set_epi32(12,11,10,9);
		c[j][3] = _mm_set_epi32(16,15,14,13);
	}

	initialize_timer();
	start_timer();
	
	for (k = 0; k < REPS; k++) {
#pragma omp parallel for
		for (j = 0; j < IREPS; j++) {
			c[j][0] = _mm_max_epi32(_mm_add_epi32(c[j][0],a), b);
			c[j][1] = _mm_max_epi32(_mm_add_epi32(c[j][1],a), b);
			c[j][2] = _mm_max_epi32(_mm_add_epi32(c[j][2],a), b);
			c[j][3] = _mm_max_epi32(_mm_add_epi32(c[j][3],a), b);
			
		/*	b =  _mm_max_epi32(_mm_add_epi32(b_1,a), b);
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
	compute(cc, aa, bb, bb_1);
	t_test(c, cc);
	double gops = (double)((double)((double)((double)2*(double)4*(double)4*(double)IREPS)*(double)REPS)/vector_time)/((double)1e9);
	printf("time: %.2f s GOPS: %.2f\n", vector_time, gops);

	return 0;
} 

void compute (int (*cc)[16], int *aa, int *bb, int *bb_1) 
{
	int i,j,k;
	for (k=0; k<REPS; k++) 
	{
		for (j=0; j<IREPS; j++) 
		{
			for (i=0; i<16; i++) 
			{
				cc[j][i] = MAX(cc[j][i]+aa[i%4], bb[i%4]);
			}

/*			for (i=0; i<4; i++) 
			{
				bb[i] = MAX(bb_1[i]+aa[i], bb[i]);
				aa[i] = MAX(bb_1[i]+bb[i], aa[i]);
			}
*/
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

void t_test (__m128i (*c)[4], int (*cc)[16])
{
	int i=0;
	int j=0;
	for (j=0; j<IREPS; j++) 
	{
		for (i=0; i<4; i++) 
		{
			if (cc[j][i*4+0] != _mm_extract_epi32(c[j][i], 0))
			{
				printf("cc[%d][%d]:%d != c[%d][%d]:%d\n", j, i*4+0, cc[j][i*4+0], j, i*4+0, _mm_extract_epi32(c[j][i], 0));
			}
			if (cc[j][i*4+1] != _mm_extract_epi32(c[j][i], 1))
			{
				printf("cc[%d][%d]:%d != c[%d][%d]:%d\n", j, i*4+1, cc[j][i*4+1], j, i*4+1, _mm_extract_epi32(c[j][i], 1));
			}
			if (cc[j][i*4+2] != _mm_extract_epi32(c[j][i], 2))
			{
				printf("cc[%d][%d]:%d != c[%d][%d]:%d\n", j, i*4+2, cc[j][i*4+2], j, i*4+2, _mm_extract_epi32(c[j][i], 2));
			}
			if (cc[j][i*4+3] != _mm_extract_epi32(c[j][i], 3))
			{
				printf("cc[%d][%d]:%d != c[%d][%d]:%d\n", j, i*4+3, cc[j][i*4+3], j, i*4+3, _mm_extract_epi32(c[j][i], 3));
			}
		}
	}
/*	int i;
	for (i = 0; i < 4; i++) 
	{
		printf("%d = %d\n", i, cc[i]);
	}
*/
}

