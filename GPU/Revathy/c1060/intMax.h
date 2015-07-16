///
/// intMax.h
/// Common header for all microbenchmarks
///
/// Created by: Revathy
//
__global__ void CompareAddVectors(const float* A, const float* B, float* C, int x, int k);

__global__ void CompareAddVectors(const int* A, const int* B, int* C, int x, int k);
