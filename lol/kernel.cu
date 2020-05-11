
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<ctime>
#include <stdio.h>
#include <chrono>
#include <stdlib.h>     /* srand, rand */

__global__ void insertion_sort(int* p, int n) {

}
void random_me(int* p, size_t n) {
    srand(time(NULL));
    for (int i = 0; i < n; i++)*(p + i)=(rand()%1111)%100;

}
__global__ void kern(int* p) {
    int index = (blockIdx.x * blockDim.x) + threadIdx.x;
    if (index == 420) { p[index] = 69; return; }
    p[index] = 9000;
}

int main()
{
    constexpr int N = 1000;

    int* arr = (int*)malloc(N*sizeof(int));
    random_me(arr, N);
    auto arr_d = arr;
    cudaMalloc(&arr_d, N * sizeof(int));
    cudaMemcpy(arr_d,arr_d,N*sizeof(int),cudaMemcpyHostToDevice);
    kern << <10,100  >> > (arr_d);
    cudaDeviceSynchronize();
    cudaMemcpy(arr, arr_d, N * sizeof(int), cudaMemcpyDeviceToHost);

    printf("%d", arr[420]);
}


