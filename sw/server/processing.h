#pragma once
#define NUM_OF_CHANNELS     3
#define SPECTRUM_THRESHOLD  100
#define SAMPLES_IN_BLOCK    32
#define BLOCKS_FOR_ANALYZE  8
#define TAIL_LENGTH         2

#include <vector>

void process_ping_guilbert(const unsigned short* data, const int blocks_num, const int block_size, 
                           unsigned short* data_out, const float threshold, std::vector<short>& spectra_out);
