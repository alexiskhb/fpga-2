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

template <class T>
using vec1d = std::vector<T>;

template <class T>
using vec2d = vec1d<vec1d<T>>;

void process_ping_guilbert(const vec2d<data_type>& data, 
                           const float threshold,
                           vec1d<data_type>& data_out, 
                           vec2d<hilbert_type>& hilbert_out, 
                           vec2d<fourier_type>& fourier_out);
