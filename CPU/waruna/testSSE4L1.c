/* Test program to figure out how to use sse4 intrinsics, datatypes and
 * compilation
 *
 */
 
#include <stdio.h>
#include <smmintrin.h>
#include <omp.h>
#include <string.h>
#include "timer.h"


#define MAX(a,b) \
	   ({ __typeof__ (a) _a = (a); \
			       __typeof__ (b) _b = (b); \
			     _a > _b ? _a : _b; })

//#define IREPS 10000
#define REPS 100000000
//sun 20
#define ARRAY_SIZE 20
#define OUT_ARRAY_SIZE (ARRAY_SIZE)*4
#define VECTOR_ARRAY_SIZE 2

void compute (int *cc, int *aa, int *bb, int *bb_1);
void t_print__m128i (__m128i a);
void t_test (int *cc_1,  int *cc);
__m128i t_add__m128i(__m128i x, __m128i y);
void printArray(int *array, int length);
void print_diff (int *cc_1,  int *cc);
int oneThread(int threadId);

int main (int argv, char** argc) 
{
	int tds = 1;
	int nn = ARRAY_SIZE;

	if (argv > 1) {
		tds = atoi(argc[1]);
	}
	if (argv > 2) {
		nn = atoi(argc[2]);
	}

	int i = 0;

	int *sum = (int *)malloc(tds*sizeof(int));
	
	initialize_timer();
	start_timer();

	#pragma omp parallel num_threads(tds)
	{
		int tid = omp_get_thread_num();
		int rr = oneThread(tid);
		sum[omp_get_thread_num()] = rr;
	}
	
	stop_timer();
	double vector_time = elapsed_time();
	double gops = (double)((double)((double)((double)2*(double)4)*(double)REPS*(double)VECTOR_ARRAY_SIZE*(double)ARRAY_SIZE)/vector_time)/((double)1e9);
	fprintf(stdout, "time: %.2f s GOPS: %.2f\n", vector_time, gops);
	
	int out = 0;
	for(i = 0; i < tds; i++){
		out += sum[i];
	}

	printf("sum: %d\n", out);

	return 0;
} 

int oneThread(int threadId)
{
	int aa[ARRAY_SIZE];// = {1,2,3,4};
	int bb[ARRAY_SIZE];// = {0,2,4,9};
//	int bb_1[ARRAY_SIZE] = {1,3,2,1};
	int cc[OUT_ARRAY_SIZE];
	int cc_1[OUT_ARRAY_SIZE];
	//int cc_1[VECTOR_ARRAY_SIZE][OUT_ARRAY_SIZE];
	int i;
	int j;
	int k;
	int itr;

#pragma omp declare reduction( + : __m128i : \
         omp_out=t_add__m128i(omp_in,omp_out)) \
                       initializer (omp_priv=_mm_set_epi32(0,0,0,0))


	memset(&cc[0], 0, ARRAY_SIZE*4);
	memset(&cc_1[0], 0, ARRAY_SIZE);

	/*for (i=0; i<OUT_ARRAY_SIZE; i++) 
	{
		cc[i] = 0;
		cc_1[i] = 0;
		if (i>=ARRAY_SIZE)
		{
			continue;
		}
		bb[i] = i;
		aa[i] = (ARRAY_SIZE)-i;
	}
*/
	for (i=0; i<ARRAY_SIZE; i++) 
	{
		bb[i] = i;
		aa[i] = (ARRAY_SIZE)-i;
	}

  __m128i a,b[VECTOR_ARRAY_SIZE];
	__m128i c0[VECTOR_ARRAY_SIZE],c1[VECTOR_ARRAY_SIZE],c2[VECTOR_ARRAY_SIZE],c3[VECTOR_ARRAY_SIZE];

//	printArray(aa, ARRAY_SIZE);
//	printArray(bb, ARRAY_SIZE);

//	initialize_timer();
//	start_timer();
	
	for (i=0; i<VECTOR_ARRAY_SIZE; i++)
	{
		c0[i] = _mm_set_epi32(0,0,0,0);
		c1[i] = _mm_set_epi32(0,0,0,1);
		c2[i] = _mm_set_epi32(0,0,1,0);
		c3[i] = _mm_set_epi32(0,1,0,0);
	}

	for (k = 0; k < REPS; k++) 
	{
//#pragma omp parallel for 
		for (i=0; i<VECTOR_ARRAY_SIZE; i++)
		{
			for (itr = 0; itr<ARRAY_SIZE; itr+=4)
			{

				a = _mm_load_si128((__m128i*)&aa[itr]);
				b = _mm_load_si128((__m128i*)&bb[itr]);
		//		printf("itr: %d\n", itr);
	//			t_print__m128i(a); 
		//		t_print__m128i(b);

				c0[i] = _mm_max_epi32(_mm_add_epi32(c0[i],a), b);
				c1[i] = _mm_max_epi32(_mm_add_epi32(c1[i],a), b);
				c2[i] = _mm_max_epi32(_mm_add_epi32(c2[i],a), b);
				c3[i] = _mm_max_epi32(_mm_add_epi32(c3[i],a), b);

				_mm_store_si128((__m128i*)&cc_1[4*itr], c0[i]);
				_mm_store_si128((__m128i*)&cc_1[4*itr+4], c1[i]);	
				_mm_store_si128((__m128i*)&cc_1[4*itr+8], c2[i]);	
				_mm_store_si128((__m128i*)&cc_1[4*itr+12], c3[i]);	
				/*_mm_store_si128((__m128i*)&cc_1[i][4*itr], c0[i]);
				_mm_store_si128((__m128i*)&cc_1[i][4*itr+4], c1[i]);	
				_mm_store_si128((__m128i*)&cc_1[i][4*itr+8], c2[i]);	
				_mm_store_si128((__m128i*)&cc_1[i][4*itr+12], c3[i]);	*/
			}	
		}
	}

/*	stop_timer();
	double vector_time = elapsed_time();
	double gops = (double)((double)((double)((double)2*(double)4)*(double)REPS*(double)VECTOR_ARRAY_SIZE*(double)ARRAY_SIZE)/vector_time)/((double)1e9);
	fprintf(stdout, "time: %.2f s GOPS: %.2f\n", vector_time, gops);
	printf("\n======\n");
	//printArray(cc_1[1],OUT_ARRAY_SIZE);
	t_print__m128i(c0[0]);
	t_print__m128i(c1[0]);
	t_print__m128i(c2[0]);
	t_print__m128i(c3[0]);
*/
/*
	compute(cc, aa, bb, bb);
	printf("\n======\n");
//	print_diff(cc_1[2], cc);
	t_test(cc_1[3], cc);
*/
	int count =0;
	for (i=0; i< 16; i++)
	{
		count += cc_1[i];	
	}

	return count;

}

void compute (int *cc, int *aa, int *bb, int *bb_1) 
{
	int i,j,k;
	int cc_2[16];
	for (i=0; i<16; i++)
	{
		cc_2[i] = 0;
	}

	for (k=0; k<REPS; k++) 
	{
		for (j=0; j<OUT_ARRAY_SIZE>>4; j++) 
		{
			for (i=0; i<16; i++) 
			{
				cc_2[i] = MAX(cc_2[i]+aa[(i%4) + 4*j], bb[(i%4) + 4*j]);
				cc[i+j*16] = cc_2[i];
			}
		}

/*			for (i=0; i<4; i++) 
		{
			bb[i] = MAX(bb_1[i]+aa[i], bb[i]);
			aa[i] = MAX(bb_1[i]+bb[i], aa[i]);
		}
*/
	}
}

__m128i t_add__m128i(__m128i x, __m128i y)
{
	__m128i z = _mm_set_epi32(0,0,0,0);
  z = _mm_add_epi32(x,y);	
	return z;
}

void t_print__m128i (__m128i a) 
{
	printf("%d = %d\n", 0, _mm_extract_epi32(a, 0));
	printf("%d = %d\n", 1, _mm_extract_epi32(a, 1));
	printf("%d = %d\n", 2, _mm_extract_epi32(a, 2));
	printf("%d = %d\n", 3, _mm_extract_epi32(a, 3));
	printf("\n");
}

void printArray(int *array, int length) {
	int i;
	for (i=0; i<length; i++)
	{
		printf("[%d]=%d\n", i, array[i]);
	}
}

//void t_test (__m128i *c, int *cc)
void t_test (int *cc_1,  int *cc)
{
	int i=0;
	for (i=0; i<OUT_ARRAY_SIZE; i++)
	{
		if (cc[i] != cc_1[i])
		{
			printf("cc[%d]:%d != cc_i[%d]:%d\n", i, cc[i], i, cc_1[i]);
		}
	}
}

void print_diff (int *cc_1,  int *cc)
{
	int i=0;
	for (i=0; i<OUT_ARRAY_SIZE; i++)
	{
		printf("cc[%d]:%d :: cc_i[%d]:%d", i, cc[i], i, cc_1[i]);
		if (cc[i] != cc_1[i])
		{
			printf(" *\n");
		} else 
		{
			printf("\n");
		}
	}
}
