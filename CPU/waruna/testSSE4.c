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

#define IREPS 1000000
#define REPS 10000

void compute (int *cc, int *aa, int *bb, int *bb_1);
void t_print__m128i (__m128i a);
void t_test (__m128i c0,__m128i c1, __m128i c2, __m128i c3,  int *cc);
__m128i t_add__m128i(__m128i x, __m128i y);

int main () 
{
	int aa[4] = {1,2,3,4};
	int bb[4] = {0,2,4,9};
	int bb_1[4] = {1,3,2,1};
	int cc[16];
	int i;
	int j;
	int k;

//#pragma omp declare reduction( + : __m128i : \
//         omp_out=_mm_add_epi32(omp_in,omp_out)) \
//                       initializer (omp_priv=_mm_set_epi32(0,0,0,0))

#pragma omp declare reduction( + : __m128i : \
         omp_out=t_add__m128i(omp_in,omp_out)) \
                       initializer (omp_priv=_mm_set_epi32(0,0,0,0))

		for (i=0; i<16; i++) 
		{
			cc[i] = 0;
		}

	__m128i c0,c1,c2,c3;
	__m128i a = _mm_set_epi32(4,3,2,1);
	__m128i b = _mm_set_epi32(9,4,2,0);
	__m128i b_1 = _mm_set_epi32(1,2,3,1);

	/*c0 = _mm_set_epi32(4,3,2,1);
	c1 = _mm_set_epi32(8,7,6,5);
	c2 = _mm_set_epi32(12,11,10,9);
	c3 = _mm_set_epi32(16,15,14,13);*/
	c0 = _mm_set_epi32(0,0,0,0);
	c1 = _mm_set_epi32(0,0,0,0);
	c2 = _mm_set_epi32(0,0,0,0);
	c3 = _mm_set_epi32(0,0,0,0);

	initialize_timer();
	start_timer();
	
	for (k = 0; k < REPS; k++) {
//#pragma omp parallel for reduction(+:c0,c1,c2,c3)
#pragma omp parallel for
		for (j = 0; j < IREPS; j++) {
			c0 = _mm_max_epi32(_mm_add_epi32(c0,a), b);
			c1 = _mm_max_epi32(_mm_add_epi32(c1,a), b);
			c2 = _mm_max_epi32(_mm_add_epi32(c2,a), b);
			c3 = _mm_max_epi32(_mm_add_epi32(c3,a), b);
			
		/*	b =  _mm_max_epi32(_mm_add_epi32(b_1,a), b);
			a =  _mm_max_epi32(_mm_add_epi32(b_1,b), a);
			*/
		}
	}
	
	stop_timer();
	double vector_time = elapsed_time();
	t_print__m128i(a);
	t_print__m128i(b);
	t_print__m128i(c0);
	t_print__m128i(c1);
	t_print__m128i(c2);
	t_print__m128i(c3);

//	compute(cc, aa, bb, bb_1);
//	t_test(c0,c1,c2,c3, cc);
	double gops = (double)((double)((double)((double)2*(double)4*(double)4*(double)IREPS)*(double)REPS)/vector_time)/((double)1e9);
	fprintf(stdout, "time: %.2f s GOPS: %.2f\n", vector_time, gops);

	return 0;
} 

__m128i t_add__m128i(__m128i x, __m128i y)
{
	__m128i z = _mm_set_epi32(0,0,0,0);
  z = _mm_add_epi32(x,y);	
	return z;
}

void compute (int *cc, int *aa, int *bb, int *bb_1) 
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

//void t_test (__m128i *c, int *cc)
void t_test (__m128i c0,__m128i c1, __m128i c2, __m128i c3,  int *cc)
{
	int i=0;
			if (cc[0*4+0] != _mm_extract_epi32(c0, 0))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 0*4+0, cc[0*4+0], 0*4+0, _mm_extract_epi32(c0, 0));
			}
			if (cc[0*4+1] != _mm_extract_epi32(c0, 1))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 0*4+1, cc[0*4+1], 0*4+1, _mm_extract_epi32(c0, 1));
			}
			if (cc[0*4+2] != _mm_extract_epi32(c0, 2))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 0*4+2, cc[0*4+2], 0*4+2, _mm_extract_epi32(c0, 2));
			}
			if (cc[0*4+3] != _mm_extract_epi32(c0, 3))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 0*4+3, cc[0*4+3], 0*4+3, _mm_extract_epi32(c0, 3));
			}

			if (cc[1*4+0] != _mm_extract_epi32(c1, 0))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 1*4+0, cc[1*4+0], 1*4+0, _mm_extract_epi32(c1, 0));
			}
			if (cc[1*4+1] != _mm_extract_epi32(c1, 1))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 1*4+1, cc[1*4+1], 1*4+1, _mm_extract_epi32(c1, 1));
			}
			if (cc[1*4+2] != _mm_extract_epi32(c1, 2))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 1*4+2, cc[1*4+2], 1*4+2, _mm_extract_epi32(c1, 2));
			}
			if (cc[1*4+3] != _mm_extract_epi32(c1, 3))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 1*4+3, cc[1*4+3], 1*4+3, _mm_extract_epi32(c1, 3));
			}

			if (cc[2*4+0] != _mm_extract_epi32(c2, 0))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 2*4+0, cc[2*4+0], 2*4+0, _mm_extract_epi32(c2, 0));
			}
			if (cc[2*4+1] != _mm_extract_epi32(c2, 1))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 2*4+1, cc[2*4+1], 2*4+1, _mm_extract_epi32(c2, 1));
			}
			if (cc[2*4+2] != _mm_extract_epi32(c2, 2))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 2*4+2, cc[2*4+2], 2*4+2, _mm_extract_epi32(c2, 2));
			}
			if (cc[2*4+3] != _mm_extract_epi32(c2, 3))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 2*4+3, cc[2*4+3], 2*4+3, _mm_extract_epi32(c2, 3));
			}

			if (cc[3*4+0] != _mm_extract_epi32(c3, 0))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 3*4+0, cc[3*4+0], 3*4+0, _mm_extract_epi32(c3, 0));
			}
			if (cc[3*4+1] != _mm_extract_epi32(c3, 1))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 3*4+1, cc[3*4+1], 3*4+1, _mm_extract_epi32(c3, 1));
			}
			if (cc[3*4+2] != _mm_extract_epi32(c3, 2))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 3*4+2, cc[3*4+2], 3*4+2, _mm_extract_epi32(c3, 2));
			}
			if (cc[3*4+3] != _mm_extract_epi32(c3, 3))
			{
				printf("cc[%d]:%d != c[%d]:%d\n", 3*4+3, cc[3*4+3], 3*4+3, _mm_extract_epi32(c3, 3));
			}

/*	int i;
	for (i = 0; i < 4; i++) 
	{
		printf("%d = %d\n", i, cc[i]);
	}
*/
}

