
//
/// File: intHostMax.cu
/// 
/// Host code for microbenchmarks to measure calibrate
/// GPU capability for integer max-plus operation.
///
/// Last Modified by: Revathy
/// Last Modified: 2015-05-07
/// 

// Includes
#include <stdio.h>
//#include <cutil.h>
#include "intMax.h"

#define    MAX(x,y)   ((x)>(y) ? (x) : (y))

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
    } else {
      sscanf(argv[1], "%d", &ValuesPerThread);
      sscanf(argv[2], "%d", &k);
      sscanf(argv[3], "%d", &gridWidth);
      sscanf(argv[4], "%d", &blockWidth);
    }      

	int size_A = blockWidth * ValuesPerThread;
	int size_B = gridWidth * ValuesPerThread;

	printf("Size of A: %d, Size of B: %d\n", size_A, size_B);

   // Determine the number of threads .
   // N is the total number of values to be in a vector
   //N = ValuesPerThread * gridWidth * blockWidth;

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
     h_A[i] = i;
    }
    for(i=0; i <size_B; ++i){
     h_B[i] =(N-i);   
    }

    // Copy host vectors h_A and h_B to device vectores d_A and d_B
    error = cudaMemcpy(d_A, h_A, size_A*sizeof(int), cudaMemcpyHostToDevice);
    if (error != cudaSuccess) Cleanup(false);
    error = cudaMemcpy(d_B, h_B, size_B*sizeof(int), cudaMemcpyHostToDevice);
    if (error != cudaSuccess) Cleanup(false);

    // Warm up
    CompareAddVectors<<<dimGrid, dimBlock>>>(d_A, d_B, d_C, ValuesPerThread, k);
    error = cudaGetLastError();
    if (error != cudaSuccess) {
		printf("W: %s\n", cudaGetErrorString(error));
		Cleanup(false);
	}
    cudaThreadSynchronize();

    // Initialize timer
    //unsigned int timer = 0;
    //cutCreateTimer(&timer);
    //cutStartTimer(timer);

    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
    // Invoke kernel
    CompareAddVectors<<<dimGrid, dimBlock>>>(d_A, d_B, d_C, ValuesPerThread, k);
    error = cudaGetLastError();
    if (error != cudaSuccess) {
		printf("%s\n", cudaGetErrorString(error));
		Cleanup(false);
	}

    // Compute elapsed time 
    cudaThreadSynchronize();
    cudaEventRecord(stop);
    
    cudaEventSynchronize(stop);

    float time = 0;
    cudaEventElapsedTime(&time, start, stop);

    // Compute integer operations per second.
    double nOps = (double)size_A*(double)size_B*(double)k*(double)2 + (double)2*(double)2*(double)k*(double)ValuesPerThread*(double)gridWidth*(double)blockWidth;
    float nOpsPerSec = 1e3*nOps/time;
    float nGOpsPerSec = nOpsPerSec*1e-9;
    // Compute transfer rates.
    float nBytes = size_A*sizeof(int) + size_B*sizeof(int) + size_A*sizeof(int)*size_B*sizeof(int); // 2N words in, N*N word out
    float nBytesPerSec = 1e3*nBytes/time;
    float nGBytesPerSec = nBytesPerSec*1e-9;

    // Report timing data.
    //printf( "Time: %f (ms), GOPS: %f, GBytesS: %f\n", time, nGOpsPerSec, nGBytesPerSec);

    printf("ValuesPerThread: %d \n",ValuesPerThread);
    printf("Iterations: %d \n", k);
    printf("TB: %d \n",gridWidth);
    printf("TPB: %d \n", blockWidth);
    printf("\n");
    printf("Time: %f (ms)\n",time);
    printf("GOPS: %f \n",nGOpsPerSec );
    printf("GBytesS: %f \n",nGBytesPerSec);
     
    // Copy result from device memory to host memory
    error = cudaMemcpy(h_C, d_C, size_A*sizeof(int)*size_B*sizeof(int), cudaMemcpyDeviceToHost);
    if (error != cudaSuccess) Cleanup(false);

    // Verify & report result
    for (i = 0; i < size_A; ++i) {
    	for (j = 0; j < size_B; ++j) {
			int val = h_C[i*size_B+j];
			if (abs(val - MAX(h_A[i]+h_B[j],0)) > 0) {
				printf("Result error: i=%d, j=%d, expected %d, got %d\n", i, j, MAX(h_A[i]+h_B[j],0.0), val);
				break;
			}
		}
		if (j != size_B) {
			break;
		}
    }
    printf("Test %s \n", (i == size_A && j == size_B) ? "PASSED" : "FAILED");

	// Clean up and exit.
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
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


