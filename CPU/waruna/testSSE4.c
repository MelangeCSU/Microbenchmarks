/* Test program to figure out how to use sse4 intrinsics, datatypes and
 * compilation
 *
 */
 
#include <stdio.h>
#include <smmintrin.h>

#define _mm_extract_epi32(x, imm) \
_mm_cvtsi128_si32(_mm_srli_si128((x), 4 * (imm)))
void t_print__m128i (__m128i a);

int main () 
{
	printf("sizeof int: %d\n", sizeof(short));

	__m128i a = _mm_set_epi32(4,3,2,1);
	__m128i b = _mm_set_epi32(9,4,2,0);

	__m128i c = _mm_max_epi32(a, b);

	t_print__m128i(a);
	t_print__m128i(b);
	t_print__m128i(c);
	return 0;
} 

void t_print__m128i (__m128i a) 
{
	/*short i;
	for (i = 0; i < 4; i++) 
	{
		printf("%d = %d\n", i, _mm_extract_epi32(a, i));
	}*/
	printf("%d = %d\n", 0, _mm_extract_epi32(a, 0));
	printf("%d = %d\n", 1, _mm_extract_epi32(a, 1));
	printf("%d = %d\n", 2, _mm_extract_epi32(a, 2));
	printf("%d = %d\n", 3, _mm_extract_epi32(a, 3));
}
