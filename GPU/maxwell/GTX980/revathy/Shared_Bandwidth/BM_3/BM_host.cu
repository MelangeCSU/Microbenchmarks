
/************************************

CPU Host code for BW Benchmark 2

 s += A * B


*************************************/


#include <stdio.h>

#define NUM_SM 16

// Variables for host and device vectors.
//int* h_A; 
//int* h_B; 
int* h_C; 
//int* d_A; 
//int* d_B; 
int* d_C; 

//Kernel declaration
__global__ void BWkernel (int *C, int x);

// Utility Functions
void Cleanup(bool);
void checkCUDAError(const char *msg);


int main(int argc, char ** argv)
{
	
	int i, x, B, T, iters, u, depth;
	
	// Parse arguments.
    if(argc != 7){
     printf("Usage: %s ValuesPerThread Repeats NumBlocks ThreadsPerBlock Depth Unroll\n", argv[0]);
     printf("ValuesPerThread is the footprint of each thread in a block.\n");
     printf("Repeats is the number of times the main loop is repeated in the kernel.");
     printf("NumBlocks is the number of threadblocks to be launched.\n");
     printf("ThreadsPerBlock is the number of threads in each threadblock.\n");
     printf("Depth is the number of scalar values computed per thread to avoid RAW dependency.");
     printf("Unroll is the number of timmes inner loop in kernel is unrolled.\n");
     printf("Total vector size is ValuesPerThread*ThreadsPerBlock*NumBlocks\n");
     return 0;
    } else {
      sscanf(argv[1], "%d", &x);
      sscanf(argv[2], "%d", &iters);
      sscanf(argv[3], "%d", &B);
      sscanf(argv[4], "%d", &T);
      sscanf(argv[5], "%d", &depth);
      sscanf(argv[6], "%d", &u);
    }
    
    long vectorLen = x * depth* T * B;
    
    //printf("VectorLen %d\n", vectorLen);
    //printf("x %d\n", x);
    //printf("Blocks %d\n", B);
    //printf("Threads %d\n", T);
    
    //Allocate vectors on host
    int size = vectorLen*sizeof(int);
    /*
    h_A = (int*)malloc(size);
    if (h_A == 0) Cleanup(false);
    h_B = (int*)malloc(size);
    if (h_B == 0) Cleanup(false);
    * */
    h_C = (int*)malloc(size);
    if (h_C == 0) Cleanup(false);
    
    //Allocate vectors on device
    cudaError_t error;
    /*
    error = cudaMalloc((void**)&d_A, size);
    if (error != cudaSuccess) Cleanup(false);
    error = cudaMalloc((void**)&d_B, size);
    if (error != cudaSuccess) Cleanup(false);
    */
    error = cudaMalloc((void**)&d_C, size);
    if (error != cudaSuccess) Cleanup(false);
    
    /*
    // Initialize input vectors on host
    for(i=0; i <vectorLen; ++i){
     h_A[i] = i;
    }
    for(i=0; i <vectorLen; ++i){
     h_B[i] =(100-i);   
    }

    // Copy host vectors h_A and h_B to device vectores d_A and d_B
    error = cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);
    if (error != cudaSuccess) Cleanup(false);
    error = cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);
    if (error != cudaSuccess) Cleanup(false);
    */
    
    // Warm up
    BWkernel <<<B, T>>>(d_C, x);
    error = cudaGetLastError();
    if (error != cudaSuccess) {
		printf("W: %s\n", cudaGetErrorString(error));
		Cleanup(false);
	}
    cudaThreadSynchronize();
    
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    cudaEventRecord(start);
    // Invoke kernel
    BWkernel <<<B, T>>>(d_C,100);
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
    double nOps = (double) vectorLen * 2;
    float nOpsPerSec = 1e3*nOps/time;
    float nGOpsPerSec = nOpsPerSec*1e-9;
    
    // Compute transfer rates.
    double nBytes = 2*vectorLen*sizeof(int)*iters; // 2N integer inputs + N integer output
    double nBytesPerSec = 1e3*nBytes/time;
    double nGBytesPerSec = nBytesPerSec*1e-9;
    double nGBytesPerSecPerSM = nGBytesPerSec / (double)NUM_SM;
    
    //Print results
    //printf("GOPS %f\n", nGOpsPerSec);
    //printf("GBytesS %f \n",nGBytesPerSec);

    printf("%d\t%d\t%d\t%d\t%d\t%f\t%f\t%f\t%d\n",x, iters, B, T, depth, nGOpsPerSec, nGBytesPerSecPerSM, time/1000.0, u);
    
    /*    
    // Copy result from device memory to host memory
    error = cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);
    if (error != cudaSuccess) Cleanup(false);

    // Verify & report result
    for (i = 0; i < vectorLen; ++i) {
		if (h_C[i] != 100) {
			break;
		}
    }
    printf("Test %s \n", (i == vectorLen) ? "PASSED" : "FAILED");
    */
    
    /*
    printf("Printing inputs: \n h_A  h_B  h_C\n");
    for(i=0; i<vectorLen; i++){
		printf("%3d  %3d  %3d  \n", h_A[i], h_B[i], h_C[i]);
	}
	*/
	// Clean up and exit.
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    Cleanup(true);
    
    return 0;
	
}

void Cleanup(bool noError) {  // simplified version from CUDA SDK
    cudaError_t error;
        
    // Free device vectors
    /*
    if (d_A)
        cudaFree(d_A);
    if (d_B)
        cudaFree(d_B);
    */
    if (d_C)
        cudaFree(d_C);

    // Free host memory
    /*
    if (h_A)
        free(h_A);
    if (h_B)
        free(h_B);
    */
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
