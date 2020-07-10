#include <thrust/sequence.h>
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <vector>


__device__ 
bool is_case(int a) {
    bool res;
    if (a % 3 == 0) {
        res = true;
    }
    else if (a % 5 == 0) {
        res = true;
    }
    return res;
}


__global__ 
void find_cases(thrust::device_vector<int> v, thrust::device_vector<bool>& flags) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;

    if (is_case(v[i])) {
        flags[i] = true;
    }
}


int sum_multiples(thrust::host_vector<int> x, thrust::host_vector<bool> flags) {
    int n = x.size();
    int res;

    for (size_t i = 0; i < n; i++) {
        if (flags[i]) {
            res += x[i];
        }
    }
    return res;
}


int main(int argc, char* argv[]) {

    n = std::atoi(argv[1])

    // initialize host vectors
    thrust::host_vector<int> h_numbers;
    thrust::host_vector<bool> h_flags;
    thrust::sequence(h_numbers.begin(), h_numbers.end());

    // device vectors
    thrust::device_vector<int> d_numbers = h_numbers;
    thrust::device_vector<bool> d_flags;

    int grid_size = n/256;
    int block_size = 256;

    find_cases<<<grid_size, block_size>>>(d_numbers, d_flags);
    h_flags = d_flags;

    res = sum_multiples(h_numbers, h_flags);

    std::cout << res << std::endl;
}
