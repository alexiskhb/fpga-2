#pragma once

#include <vector>
#include <iostream>
#include "processing.h"

class Pinger {
public:
    Pinger(int freq/*Hz*/, int pulse_len/*ms*/, int amplitude, int sample_rate) : 
        freq(freq), pulse_len(pulse_len), ampl(amplitude), sample_rate(sample_rate)
    {
        this->block_size = upperpow2(pulse_len*measures_per_ms);
        std::cout << 
            "freq: " << freq <<
            "\nblock size: " << block_size << std::endl;
    }

    vec2d<data_type> generate(const vec1d<double>& distances/*meters*/) 
    {
        auto min_dist = distances.front();
        for (auto d: distances) {
            if (d < min_dist) {
                min_dist = d;
            }
        }
        int blocks_num = distances.size();
        vec2d<data_type> result(blocks_num, vec1d<data_type>(block_size));
        m_generate_data(block_size);
        for (int i = 0; i < blocks_num; i++) {
            m_generate_impl(result[i].begin(), distances[i] - min_dist);
        }
        return result;
    }
private:
    void m_generate_impl(const vec1d<data_type>::iterator begin, double dist)
    {
        double speed_of_sound = 1468.5;
        // I don't know why 1000000
        int shift = std::min(int(1'000'000*dist/speed_of_sound), block_size);
        std::cout << shift << std::endl;
        std::fill(begin, begin + shift, 0);
        std::copy(data.begin(), data.end() - shift, begin + shift);
    }

    void m_generate_data(int block_size)
    {
        data.resize(block_size);
        for (int t = 0; t < block_size; t++) {
            data[t] = ampl*sin((2*M_PI*t*freq)/sample_rate) + ampl + 1;
        }
    }

    int upperpow2(int k) {
        int result = 1;
        while (result < k) {
            result <<= 1;
        }
        return result;
    }
    const int measures_per_ms = 1000;
    int freq, pulse_len, ampl, block_size, sample_rate;
    vec1d<data_type> data;
};

class Context {
public:

};
