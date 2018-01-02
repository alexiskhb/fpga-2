#pragma once
#define NUM_OF_CHANNELS     3
#define SPECTRUM_THRESHOLD  100
#define SAMPLES_IN_BLOCK    32
#define BLOCKS_FOR_ANALYZE  8
#define TAIL_LENGTH         2

#include <vector>
#include <cstdint>

typedef int16_t data_type;
typedef uint16_t fourier_type;
typedef int16_t hilbert_type;

void process_ping_guilbert(const data_type* data, const int blocks_num, const int block_size, 
                           data_type* data_out, const float threshold, std::vector<hilbert_type>& hilbert_out, 
                           std::vector<fourier_type>& fourier_out);
