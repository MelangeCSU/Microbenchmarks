/*Data in L1 cache but with a param to define the weight of the object
 * Array in heap
 *
 */
 
#include <stdio.h>
#include <smmintrin.h>
#include <string.h>
#include "timer.h"

#ifdef OMP
#include <omp.h>
#endif


#define MAX(a,b) \
	   ({ __typeof__ (a) _a = (a); \
			       __typeof__ (b) _b = (b); \
			     _a > _b ? _a : _b; })

//#define IREPS 10000
#define REPS 200000000
//sun 20
#define ARRAY_SIZE 320

void compute (int *cc, int *aa, int *bb, int *bb_1, int nn, long iReps);
void t_print__m128i (__m128i a);
void t_test (int *cc_1,  int *cc, int nn);
__m128i t_add__m128i(__m128i x, __m128i y);
void printArray(int *array, int length);
void print_diff (int *cc_1,  int *cc, int nn);
int oneThread(int threadId, int w, int nn, long  iReps);

int main (int argv, char** argc) 
{
	int tds = 1; // # threads
	int nn = ARRAY_SIZE; // Size of array per thread
	int w = 16; // weight
	long iReps = REPS; // repetitions of the whole computation
	if (argv > 1) {
		tds = atoi(argc[1]);
	}
	if (argv > 2) {
		w = atoi(argc[2]);
	}
	if (argv > 3) {
		nn = atoi(argc[3]);
	}
	if (argv > 4) {
		iReps = atol(argc[4]);
	}

	int w2 = 2*w;

	if (nn%w2 != 0) {
		printf("Error: Array size: %d is not a multiple of 2*weight: %d!\n", nn, w2);
		exit(-1);
	}


	int i = 0;

	int *sum = (int *)malloc(tds*sizeof(int));
	
	initialize_timer();
	start_timer();

	#pragma omp parallel num_threads(tds)
	{
		int tid = 0;
#ifdef OMP
		tid = omp_get_thread_num();
#endif
		int rr = oneThread(tid, w, nn, iReps);
		sum[tid] = rr;
	}
	
	stop_timer();
	double vector_time = elapsed_time();
	double gops = (double)((double)((double)((double)4*(double)4)*(double)iReps*((((double)nn)/(double)w2)-1.0f)*(double)tds)/vector_time)/((double)1e9);
	fprintf(stdout, "Threads: %d ArraySize: %d W: %d Reps: %ld time: %.2f s GOPS: %.2f\n", tds, nn, w, iReps, vector_time, gops);
	
	int out = 0;
	for(i = 0; i < tds; i++){
		out += sum[i];
	}

	printf("sum: %d\n", out);

	return 0;
} 

int oneThread(int threadId, int w, int nn, long iReps)
{
	int *cc;
	int i;
	long k;
	int itr;
	int w2 = 2*w;

	cc = (int *)malloc(sizeof(int)*nn);

	memset(&cc[0], 0, sizeof(int)*nn);

	if (((long)cc)%16 != 0) {
		printf("WARNING: Thread: %d has not allocated 16 aligned memory!", threadId);
	}

  __m128i a,b0,b1,b2,b3;
	__m128i c0,c1,c2,c3;

	c0 = _mm_set_epi32(0,0,0,0);
	c1 = _mm_set_epi32(0,0,0,1);
	c2 = _mm_set_epi32(0,0,1,0);
	c3 = _mm_set_epi32(0,1,0,0);
	a = _mm_set_epi32(1,2,2,1);
	c0 = _mm_load_si128((__m128i*)&cc[nn-w]);
	c1 = _mm_load_si128((__m128i*)&cc[nn-(w-4)]);	
	c2 = _mm_load_si128((__m128i*)&cc[nn-(w-8)]);	
	c3 = _mm_load_si128((__m128i*)&cc[nn-(w-12)]);	

	for (k = 0; k < iReps; k++) 
	{
		for (itr = nn; itr>w2; itr-=w2)
		{

			b0 = _mm_load_si128((__m128i*)&cc[itr-(w2)]);
			b1 = _mm_load_si128((__m128i*)&cc[itr-(w2-4)]);	
			b2 = _mm_load_si128((__m128i*)&cc[itr-(w2-8)]);	
			b3 = _mm_load_si128((__m128i*)&cc[itr-(w2-12)]);	

			c0 = _mm_max_epi32(_mm_add_epi32(c0,a), b0);
			c1 = _mm_max_epi32(_mm_add_epi32(c1,a), b1);
			c2 = _mm_max_epi32(_mm_add_epi32(c2,a), b2);
			c3 = _mm_max_epi32(_mm_add_epi32(c3,a), b3);

			_mm_store_si128((__m128i*)&cc[itr-w], c0);
			_mm_store_si128((__m128i*)&cc[itr-(w-4)], c1);	
			_mm_store_si128((__m128i*)&cc[itr-(w-8)], c2);	
			_mm_store_si128((__m128i*)&cc[itr-(w-12)], c3);	


			c0 = _mm_load_si128((__m128i*)&cc[itr-(w+w2)]);
			c1 = _mm_load_si128((__m128i*)&cc[itr-(w+w2-4)]);	
			c2 = _mm_load_si128((__m128i*)&cc[itr-(w+w2-8)]);	
			c3 = _mm_load_si128((__m128i*)&cc[itr-(w+w2-12)]);	
		
			b0 = _mm_max_epi32(_mm_add_epi32(b0,a), c0);
			b1 = _mm_max_epi32(_mm_add_epi32(b1,a), c1);
			b2 = _mm_max_epi32(_mm_add_epi32(b2,a), c2);
			b3 = _mm_max_epi32(_mm_add_epi32(b3,a), c3);

			_mm_store_si128((__m128i*)&cc[itr-w2], b0);
			_mm_store_si128((__m128i*)&cc[itr-(w2-4)], b1);	
			_mm_store_si128((__m128i*)&cc[itr-(w2-8)], b2);	
			_mm_store_si128((__m128i*)&cc[itr-(w2-12)], b3);	
		}	
		a = _mm_min_epi32(a,b0);
	}

	int count =0;
	for (i=0; i< nn; i++)
	{
		count += cc[i];	
	}

	return count;

}

void compute (int *cc, int *aa, int *bb, int *bb_1, int nn, long iReps) 
{
	int i,j,k;
	int cc_2[16];
	for (i=0; i<16; i++)
	{
		cc_2[i] = 0;
	}

	for (k=0; k<iReps; k++) 
	{
		for (j=0; j<nn>>4; j++) 
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
void t_test (int *cc_1,  int *cc, int nn)
{
	int i=0;
	for (i=0; i<nn; i++)
	{
		if (cc[i] != cc_1[i])
		{
			printf("cc[%d]:%d != cc_i[%d]:%d\n", i, cc[i], i, cc_1[i]);
		}
	}
}

void print_diff (int *cc_1,  int *cc, int nn)
{
	int i=0;
	for (i=0; i<nn; i++)
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
