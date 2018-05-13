#include <iostream>


__device__ is_case(int a) {
    bool res;
    if (a % 3 == 0) {
        res = true;
    }
    else if (a % 5 == 0) {
        res = true;
    }
    return res;
}


__global__ find_cases()
