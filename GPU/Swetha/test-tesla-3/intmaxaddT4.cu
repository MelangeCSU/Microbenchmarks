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
#include "intmaxaddT4K.h"
#include <math.h>

extern "C" {
#include "timer.h"
}

// Variables for host and device vectors.
//int* h_A; 
//int* h_B; 
int* h_C; 
//int* d_A; 
//int* d_B; 
int* d_C; 

// Utility Functions
void Cleanup(bool);
void checkCUDAError(const char *msg);

// Host code performs setup and calls the kernel.
int main(int argc, char** argv)
{
    	
   	//int ValuesPerThread; //Values per thread
	int k; // no. of repeatitions
	int sl;//stride length
	int gridWidth = 60;
	int blockWidth = 1;

	// Parse arguments.
    	if(argc != 5){
    		 printf("Usage: %s Values per thread Iterations\n", argv[0]);
     		// printf("Stride-length is the sweep radius of each thread.\n");
    		 printf("Total vector size is 128 * 60 * this value.\n");
    		 printf("Iterations is the number of repeatitions done by each thread.\n");
    		 exit(0);
   		 } 
	else 	{
     		 sscanf(argv[1], "%d", &sl);
      		
		 sscanf(argv[2], "%d", &k);
       		 sscanf(argv[3], "%d", &gridWidth);
      		 sscanf(argv[4], "%d", &blockWidth);
		// sscanf(argv[5], "%d", &sl);
		 
    		}      
	//maximum shared memory size * # SMs * TPB
	// shared memory size =  16384 bytes = 4096 ints (theoretical)
	// Practical it is 4000 ints. 
	// 4000*30*threads per thread block
	int size_C = 4000* 30 * blockWidth;
        //int size_C = ValuesPerThread * blockWidth * gridWidth;
	
    	dim3 dimGrid(gridWidth);                    
    	dim3 dimBlock(blockWidth);                 

	
	h_C = (int*)malloc(size_C*sizeof(int));
    	if (h_C == 0) Cleanup(false);

   	// Allocate vectors in device memory.
   	cudaError_t error;

	error = cudaMalloc((void**)&d_C, size_C*sizeof(int));
    	if (error != cudaSuccess) Cleanup(false);


   	IntmaxaddT4<<<dimGrid, dimBlock>>>(d_C, k , sl);
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
    	IntmaxaddT4<<<dimGrid, dimBlock>>>( d_C, k , sl);
    	error = cudaGetLastError();
    	if (error != cudaSuccess) {
		printf("%s\n", cudaGetErrorString(error));
		Cleanup(false);
	}


	// Compute elapsed time 
   	cudaThreadSynchronize();
	stop_timer();
   	time = elapsed_time();
	int cal = floor((120000/(gridWidth*sl)))+1;
	//printf("cal=%d\n",cal);
      // double nops = (double)size_A*(double)size_B*(double)k*(double)2 + (double)4*(double)k*(double)ValuesPerThread*(double)gridWidth*(double)blockWidth;
	double nops = (double)cal*(double)2*(double)k*(double)blockWidth*(double)gridWidth;
	//printf("cal=%d\tnops=%lf\n",cal,nops);
        float nopsPerSec = float(nops)/time;
    	float nGopsPerSec = nopsPerSec*1e-9;
	
	// Compute transfer rates.
    //	int nBytes = size_A*sizeof(int) + size_B*sizeof(int) + size_A*sizeof(int)*size_B*sizeof(int); // 2N words in, N*N word out
	//int nBytes = size_A*sizeof(int) + size_B*sizeof(int) + size_A*sizeof(int)*size_B*sizeof(int); // 2N words in, N*N word out
    //	float nBytesPerSec = (float)nBytes/time;
    	//float nGBytesPerSec = nBytesPerSec*1e-9;

	// Report timing data.*/
    	//printf( "Time: %f (s), Gops: %f, GBytesS: %f\n", time, nGopsPerSec, nGBytesPerSec);
	printf( "Time: %f (s), Gops: %f\n", time, nGopsPerSec);
    // printf( "Time: %f (s) \n", time);
    	// Copy result from device memory to host memory
   	error = cudaMemcpy(h_C, d_C, size_C*sizeof(int), cudaMemcpyDeviceToHost);
    	if (error != cudaSuccess) Cleanup(false);


    	Cleanup(true);
}

void Cleanup(bool noError) {  // simplified version from CUDA SDK
    cudaError_t error;
  
    if (d_C)
        cudaFree(d_C);

  
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


