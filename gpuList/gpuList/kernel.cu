#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <cuda.h>
#include <thrust\random.h>
#include <thrust\host_vector.h>
#include <thrust\device_vector.h>
#define SIZE 500

thrust::host_vector<int>* vec = new thrust::host_vector<int>(0);
thrust::device_vector<int>* d_vec = new thrust::device_vector<int>(0);

struct RandomNumberGenerator{
	float a, b;
	RandomNumberGenerator(float _a = 0.0f, float _b = 100.0f) : a(_a), b(_b) {};
	const float operator() (const unsigned int n) const
	{
		thrust::default_random_engine rng;
		thrust::uniform_real_distribution<float> dist(0, 500);
		rng.discard(n);

		return dist(rng);
	}
};

void createVector(){
	for (int i = 0; i < SIZE; i++)
	vec->push_back(RandomNumberGenerator(1.0f, 500.0f)(0));
}
cudaError_t copyVector(){
	return cudaMemcpy(d_vec, vec, SIZE * sizeof(int), cudaMemcpyHostToDevice);
}

__device__ __host__ void compareNumbers(int max){
	for (int i = 0; i < SIZE; i++){
		if (vec[i] < 250){
			printf("%i", d_vec[i]);
		}
	}
}
