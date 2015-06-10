#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <iostream>
#include <cuda.h>
#include <thrust\host_vector.h>
#include <thrust\device_vector.h>

extern cudaError_t copyVector(void);
extern void createVector(void);
extern __global__ void compareNumbers(int max);

int main(int argc, char* argv[]){
	createVector();
	if(copyVector() != cudaError::cudaSuccess){
		std::cout << "An Error Occurred While Copying the vector" << std::endl;
		system("PAUSE");
		return 0;
	}
	compareNumbers << < 1, 500 >> >(500);
	return 0;
}
