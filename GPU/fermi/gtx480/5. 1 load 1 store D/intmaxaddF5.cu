/*Author: Swetha Varadarajan 6/10/2015
Adapted from CSU CS575 Spring 2011 
	which was based on code from the CUDA Programming Guide by David Newman
	Modified by Wim Bohm and David Newman
Changes made:
	1. Replaced cutil.h funcitons with normal timer functions adapted from CS475 assignments 
	2. Included the extern "C" in order to compile C code alongwith nvcc. 
	3. Replaced the Kernel and the header file name according to the functionality. 
	4. Kernel functionality changed from vector multiplication to max-add.	
	5. Time calculated is in seconds. So, the corresponding calculations are modified. (GOPS,GBYTES,TIME)
	6. FLOPS changed to OPS since this is an integer operation.
	7. Floats to Ints data type change for host and device vectors. 
*/

#include <stdio.h>
#include "intmaxaddF5K.h"

extern "C" {
#include "timer.h"
}

// Variables for host and device vectors.
int* h_A; 
int* h_B; 
int* h_C; 
int* d_A; 
int* d_B; 
int* d_C; 

// Utility Functions
void Cleanup(bool);
void checkCUDAError(const char *msg);

// Host code performs setup and calls the kernel.
int main(int argc, char** argv)
{
    	int ValuesPerThread; // number of values per thread
   	int N; //Vector size
	int k; // no. of repeatitions
	int gridWidth = 60;
	int blockWidth = 1;

	// Parse arguments.
    	if(argc != 5){
    		 printf("Usage: %s ValuesPerThread Iterations\n", argv[0]);
     		 printf("ValuesPerThread is the number of values added by each thread.\n");
    		 printf("Total vector size is 128 * 60 * this value.\n");
    		 printf("Iterations is the number of repeatitions done by each thread.\n");
    		 exit(0);
   		 } 
	else 	{
     		 sscanf(argv[1], "%d", &ValuesPerThread);
      		 sscanf(argv[2], "%d", &k);
       		 sscanf(argv[3], "%d", &gridWidth);
      		 sscanf(argv[4], "%d", &blockWidth);
    		}      

	int size_A = blockWidth * ValuesPerThread;
	int size_B = gridWidth * ValuesPerThread;

	printf("Size of A: %d, Size of B: %d\n", size_A, size_B);
	
    	dim3 dimGrid(gridWidth);                    
    	dim3 dimBlock(blockWidth);                 

    	// Allocate input vectors h_A and h_B in host memory
    	h_A = (int*)malloc(size_A*sizeof(int));
    	if (h_A == 0) Cleanup(false);
    	h_B = (int*)malloc(size_B*sizeof(int));
    	if (h_B == 0) Cleanup(false);
    	h_C = (int*)malloc(size_A*sizeof(int)*size_B*sizeof(int));
    	if (h_C == 0) Cleanup(false);
	

   	// Allocate vectors in device memory.
   	cudaError_t error;
    	error = cudaMalloc((void**)&d_A, size_A*sizeof(int));
    	if (error != cudaSuccess) Cleanup(false);
	
    	error = cudaMalloc((void**)&d_B, size_B*sizeof(int));
    	if (error != cudaSuccess) Cleanup(false);
	
   	error = cudaMalloc((void**)&d_C, size_A*sizeof(int)*size_B*sizeof(int));
    	if (error != cudaSuccess) Cleanup(false);


   	 // Initialize host vectors h_A and h_B
   	int i, j;
    	for(i=0; i <size_A; ++i){
    		 h_A[i] = (int)i;
   	 	}
    	for(i=0; i <size_B; ++i){
     		h_B[i] = (int)(N-i);   
    		}
	
	
    	// Copy host vectors h_A and h_B to device vectores d_A and d_B
	error = cudaMemcpy(d_A, h_A, size_A*sizeof(int), cudaMemcpyHostToDevice);
   	if (error != cudaSuccess) Cleanup(false);
    	error = cudaMemcpy(d_B, h_B, size_B*sizeof(int), cudaMemcpyHostToDevice);
    	if (error != cudaSuccess) Cleanup(false);
	

   	IntmaxaddF5<<<dimGrid, dimBlock>>>(d_A, d_B, d_C, ValuesPerThread, k);
    	error = cudaGetLastError();

  	if (error != cudaSuccess) {
		printf("W: %s\n", cudaGetErrorString(error));
		Cleanup(false);
	}
    	cudaThreadSynchronize();



    	// Initialize timer
   	double time;
   	initialize_timer();
  	start_timer();
  
    	// Invoke kernel
    	IntmaxaddF5<<<dimGrid, dimBlock>>>(d_A, d_B, d_C, ValuesPerThread, k);
    	error = cudaGetLastError();
    	if (error != cudaSuccess) {
		printf("%s\n", cudaGetErrorString(error));
		Cleanup(false);
	}


	// Compute elapsed time 
   	cudaThreadSynchronize();
	stop_timer();
   	time = elapsed_time();
        double nops = (double)size_A*(double)size_B*(double)k*(double)2 + (double)4*(double)k*(double)ValuesPerThread*(double)gridWidth*(double)blockWidth;
        float nopsPerSec = float(nops)/time;
    	float nGopsPerSec = nopsPerSec*1e-9;
	
	// Compute transfer rates.
    	int nBytes = size_A*sizeof(int) + size_B*sizeof(int) + size_A*sizeof(int)*size_B*sizeof(int); // 2N words in, N*N word out
    	float nBytesPerSec = (float)nBytes/time;
    	float nGBytesPerSec = nBytesPerSec*1e-9;

	// Report timing data.
    	printf( "Time: %f (s), Gops: %f, GBytesS: %f\n", time, nGopsPerSec, nGBytesPerSec);
     
    	// Copy result from device memory to host memory
   	error = cudaMemcpy(h_C, d_C, size_A*sizeof(int)*size_B*sizeof(int), cudaMemcpyDeviceToHost);
    	if (error != cudaSuccess) Cleanup(false);

    	// Verify & report result
    	for (i = 0; i < size_A; ++i) {
    		for (j = 0; j < size_B; ++j) {
			int val = h_C[i*size_B+j];
			if (fabs(val - h_A[i]*h_B[j]) > 1e-5) {
				printf("Result error: i=%d, j=%d, expected %d, got %d\n", i, j, h_A[i]*h_B[j], val);
				break;
			}
		}
		if (j != size_B) {
			break;
		}
    	}
    	printf("Test %s \n", (i == size_A && j == size_B) ? "PASSED" : "FAILED");

	
    	Cleanup(true);
}

void Cleanup(bool noError) {  // simplified version from CUDA SDK
    cudaError_t error;
        
    // Free device vectors
    if (d_A)
        cudaFree(d_A);
    if (d_B)
        cudaFree(d_B);
    if (d_C)
        cudaFree(d_C);

    // Free host memory
    if (h_A)
        free(h_A);
    if (h_B)
        free(h_B);
    if (h_C)
        free(h_C);
        
    error = cudaThreadExit();
    checkCUDAError("tmp"); 
    if (!noError || error != cudaSuccess)
        printf("error: %s cuda malloc or cuda thread exit failed \n", cudaGetErrorString(cudaGetLastError()));
    
    fflush( stdout);
    fflush( stderr);

    exit(0);
}

void checkCUDAError(const char *msg)
{
  cudaError_t err = cudaGetLastError();
  if( cudaSuccess != err) 
    {
		printf("Error");
      fprintf(stderr, "Cuda error: %s: %s.\n", msg, cudaGetErrorString(err) );
      exit(-1);
    }                         
}


