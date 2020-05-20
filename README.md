# CUDA

small project where i implement the merge sort in a parallel algorithm on the GPU.
As of writing, it can only run on one block (1024 threads max) so the max array it can sort is 1024.
Coupled with the fact that my CPU is a beast (3600x) and array size is limited, it is pretty slow.

To improve:
I can take use of shared memory. Right now im declaring an array within the kernel, since it is not indexed with a constant
(because it can be determined at compile-time), it is not actually stored on the super fast register memory (as of yet).
instead, it goes to the slow local memory (unique to each thread) and is not always cached (depends on gpu ) 

As the size of the array increases, not all elements will fit in each block. thus i cant use local memory anymore. or even shared.

I also need to consider if the array is not a power of 2...

