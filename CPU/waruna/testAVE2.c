/* Test program to figure out how to use sse4 intrinsics, datatypes and
 * compilation
 *
 */
 
#include <stdio.h>
#include <immintrin.h>

void t_print__m256i (__m256i a);

int main () 
{
	__m256i z = _mm256_set_epi32(8,7,6,5,4,3,2,1);
	__m256i b = _mm256_set_epi32(2,4,10,3,9,4,2,0);

	__m256i c = _mm256_max_epi32(z, b);

	t_print__m256i(z);
	t_print__m256i(b);
	t_print__m256i(c);
	return 0;
} 

void t_print__m256i (__m256i a) 
{
	/*short i;
	for (i = 0; i < 4; i++) 
	{
		printf("%d = %d\n", i, _mm256_extract_epi32(a, i));
	}*/
	printf("%d = %d\n", 0, _mm256_extract_epi32(a, 0));
	printf("%d = %d\n", 1, _mm256_extract_epi32(a, 1));
	printf("%d = %d\n", 2, _mm256_extract_epi32(a, 2));
	printf("%d = %d\n", 3, _mm256_extract_epi32(a, 3));
	printf("%d = %d\n", 4, _mm256_extract_epi32(a, 4));
	printf("%d = %d\n", 5, _mm256_extract_epi32(a, 5));
	printf("%d = %d\n", 6, _mm256_extract_epi32(a, 6));
	printf("%d = %d\n", 7, _mm256_extract_epi32(a, 7));
}
