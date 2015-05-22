
#include <stdio.h>
#include <cutil.h>
#include "vecmultKernel.h"

// Defines
//#define GridWidth 60
//#define BlockWidth 128

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
	//printf("1st bf\n");
    // Determine the number of threads .
    // N is the total number of values to be in a vector
//    N = ValuesPerThread * gridWidth * blockWidth;
//    printf("Total vector size: %d : Iterations: %d\n", N, k); 
    // size_t is the total number of bytes for a vector.
//    size_t size = N * sizeof(float);

    // Tell CUDA how big to make the grid and thread blocks.
    // Since this is a vector addition problem,
    // grid and thread block are both one-dimensional.
    dim3 dimGrid(gridWidth);                    
    dim3 dimBlock(blockWidth);                 

    // Allocate input vectors h_A and h_B in host memory
    h_A = (int*)malloc(size_A*sizeof(int));
    if (h_A == 0) Cleanup(false);
    h_B = (int*)malloc(size_B*sizeof(int));
    if (h_B == 0) Cleanup(false);
    h_C = (int*)malloc(size_A*sizeof(int)*size_B*sizeof(int));
    if (h_C == 0) Cleanup(false);
	
//	printf("1 \n");
	//printf("2nd  bp\n");
    // Allocate vectors in device memory.
    cudaError_t error;
    error = cudaMalloc((void**)&d_A, size_A*sizeof(int));
    if (error != cudaSuccess) Cleanup(false);
	//printf("1.1\n");
    error = cudaMalloc((void**)&d_B, size_B*sizeof(int));
    if (error != cudaSuccess) Cleanup(false);
//	printf("1.2\n");
    error = cudaMalloc((void**)&d_C, size_A*sizeof(int)*size_B*sizeof(int));
    if (error != cudaSuccess) Cleanup(false);

//	printf("2\n");
    // Initialize host vectors h_A and h_B
    int i, j;
    for(i=0; i <size_A; ++i){
     h_A[i] = (int)i;
    }
    for(i=0; i <size_B; ++i){
     h_B[i] = (int)(N-i);   
    }
	
	//printf("3rd bp\n");
    // Copy host vectors h_A and h_B to device vectores d_A and d_B



    error = cudaMemcpy(d_A, h_A, size_A*sizeof(int), cudaMemcpyHostToDevice);
    if (error != cudaSuccess) Cleanup(false);
    error = cudaMemcpy(d_B, h_B, size_B*sizeof(int), cudaMemcpyHostToDevice);
    if (error != cudaSuccess) Cleanup(false);
	

    MultiplyVectors<<<dimGrid, dimBlock>>>(d_A, d_B, d_C, ValuesPerThread, k);
    error = cudaGetLastError();
//printf("4th bp\n");
    if (error != cudaSuccess) {
		printf("W: %s\n", cudaGetErrorString(error));
		Cleanup(false);
	}
    cudaThreadSynchronize();


//	printf("4\n");
    // Initialize timer

 // printf("Starting Kernel\n");
    unsigned int timer = 0;
    cutCreateTimer(&timer);
    cutStartTimer(timer);
  
    // Invoke kernel
    MultiplyVectors<<<dimGrid, dimBlock>>>(d_A, d_B, d_C, ValuesPerThread, k);
    error = cudaGetLastError();
    if (error != cudaSuccess) {
		printf("%s\n", cudaGetErrorString(error));
		Cleanup(false);
	}

//	printf("5\n");
	// Compute elapsed time 
    cudaThreadSynchronize();
    cutStopTimer(timer);
    float time = cutGetTimerValue(timer);

	// Compute floating point operations per second.
    //double nFlops = size_A*size_B*k*2 + 4*k*6*60;
    double nFlops = (double)size_A*(double)size_B*(double)k*(double)2 + (double)4*(double)k*(double)ValuesPerThread*(double)gridWidth*(double)blockWidth;
    //long nFlops = (int)size_A*(int)size_B*(int)k*(int)2;
	//printf("nFlops=%ld\n",nFlops);
	//nFlops+=(int)4*ValuesPerThread*(int)k*gridWidth*blockWidth;
	//printf("nFlops=%ld\n",nFlops);
    float nFlopsPerSec = 1e3*float(nFlops)/time;
    float nGFlopsPerSec = nFlopsPerSec*1e-9;
	//printf("%f :: %f", (double)size_A*(double)size_B*(double)k*(double)2, (double)2*(double)k*(double)ValuesPerThread*(double)gridWidth*(double)blockWidth);
	// Compute transfer rates.
    int nBytes = size_A*sizeof(int) + size_B*sizeof(int) + size_A*sizeof(int)*size_B*sizeof(int); // 2N words in, N*N word out
    float nBytesPerSec = 1e3*(float)nBytes/time;
    float nGBytesPerSec = nBytesPerSec*1e-9;

	// Report timing data.
    printf( "Time: %f (ms), GFLOPS: %f, GBytesS: %f\n", 
             time, nGFlopsPerSec, nGBytesPerSec);
     
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

	// Clean up and exit.
    cutDeleteTimer( timer);
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


