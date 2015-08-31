/*Author: Swetha Varadarajan 6/10/2015
Adapted from CSU CS575 Spring 2011 
	which was based on code from the CUDA Programming Guide by David Newman
Changes made:
	1. Modified to be integers 
	2. Changed the Kernel name
	3. Included iteration "k" in the Kernel call 
*/
__global__ void IntmaxaddT4(int* C,  int k, int sl);

