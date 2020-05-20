
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<ctime>
#include <stdio.h>
#include <chrono>
#include <stdlib.h>     /* srand, rand */
#include <math.h>       /* log2 */

__global__ void merge(int* ptr,size_t size) {
    int i = threadIdx.x;
    int sort[32];//tempi think this is using slow memory
    int* start = ptr + (i * size);
    int* mid = start + (size / 2);
    int a = 0; int b = 0;
    for (int j = 0; j < size; j++) {
        if (a > (size / 2)-1) { a--; start[a] = 9999; }
        else if (b > (size / 2)-1) 
        { b--; mid[b] = 9999; }//i dont know what to say

        if (start[a] > mid[b]) {
            sort[j] = mid[b];
            b++;
        }

        else {
            sort[j] = start[a];
            a++;
        }
        
    }
          
    start = ptr + (i * size);      
    for (int j = 0; j < size; j++) {          
        start[j] =  sort[j];

    }

}

void random_me(int* p, size_t n) {
    srand(time(NULL));
    for (int i = 0; i < n; i++)*(p + i)=(rand()%1111)%100;
}


int main()
{
    constexpr int N = 32;

    int* arr = (int*)malloc(N * sizeof(int));
    random_me(arr, N);
    for (int c = 0; c < N; c++) { printf("%d,", arr[c]);  }printf("\n");
    auto arr_d = arr;
    
    cudaMalloc(&arr_d, N * sizeof(int));
    cudaMemcpy(arr_d, arr, N * sizeof(int), cudaMemcpyHostToDevice);
    for (int size = 2; size <N+1; size = size * 2) {
        merge << <1, N/size >> > (arr_d, size);
        cudaDeviceSynchronize();

    }
    
    
    cudaMemcpy(arr, arr_d, N * sizeof(int), cudaMemcpyDeviceToHost);
    for (int c = 0; c < N;c++) {
        printf("%d\n", arr[c]);
    }
    
}


