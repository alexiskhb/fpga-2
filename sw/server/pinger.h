#pragma once

#include <vector>
#include <iostream>

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

    std::vector<data_type> generate(const std::vector<double>& distances/*meters*/) 
    {
        double min_dist = distances.front();
        for (int d: distances) {
            if (d < min_dist) {
                min_dist = d;
            }
        }
        int blocks_num = distances.size();
        std::vector<data_type> result(block_size * blocks_num);
        m_generate_data(block_size);
        for (int i = 0; i < blocks_num; i++) {
            m_generate_impl(result.begin() + block_size*i, distances[i] - min_dist);
        }
        return result;
    }
private:
    void m_generate_impl(const std::vector<data_type>::iterator begin, double dist)
    {
        double speed_of_sound = 1468.5;
        // I don't know why 1000000
        int shift = std::min(std::max(int(1'000'000*dist/speed_of_sound), 0), block_size);
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
    std::vector<data_type> data;
};
