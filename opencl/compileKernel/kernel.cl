// Example of OpenCL Kernel
__kernel void foo (__global float *a, __global float* b) {
       int idx = get_global_id(0);
       b[idx] = a[idx];
}

