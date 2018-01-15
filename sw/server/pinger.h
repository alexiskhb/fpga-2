#pragma once

#include <vector>
#include <iostream>
#include "processing.h"
#include "json/json.hpp"

class Pinger {
public:
    using json = nlohmann::json;

    Pinger() {}

    Pinger(std::istream& file) : is_from_file(true) 
    {
        load(file);
    }

    Pinger& load(std::istream& file)
    {
        using response_data_type = std::vector<std::vector<std::pair<data_type, data_type>>>;
        json j;
        file >> j;
        response_data_type rsps_data = j.at("data").get<response_data_type>();
        for (auto& v: rsps_data) {
            data2d.push_back(vec1d<data_type>(v.size()));
            for (unsigned i = 0; i < v.size(); i++) {
                data2d.back()[i] = v[i].second;
            }
        }
        from_file(true);
        return *this;
    }

    Pinger(int a_freq/*Hz*/, int a_pulse_len/*ms*/, int a_amplitude, int a_sample_rate)
    {
        this->set(a_freq, a_pulse_len, a_amplitude, a_sample_rate);
        std::cout << 
            "freq: " << freq <<
            "\nblock size: " << block_size << std::endl;
    }

    Pinger& set(int a_freq/*Hz*/, int a_pulse_len/*ms*/, int a_amplitude, int a_sample_rate)
    {
        this->block_size = upperpow2(pulse_len*measures_per_ms);
        this->freq = a_freq;
        this->pulse_len = a_pulse_len;
        this->ampl = a_amplitude;
        this->sample_rate = a_sample_rate;
        from_file(false);
        return *this;
    }

    void from_file(bool b) 
    {
        this->is_from_file = b;
    }

    vec2d<data_type> generate() 
    {
        return data2d;
    }

    vec2d<data_type> generate(const vec1d<double>& distances/*meters*/) 
    {
        if (is_from_file) {
            return generate();
        }
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
            data[t] = ampl*sin((2*M_PI*t*freq)/sample_rate);
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
    vec2d<data_type> data2d;
    bool is_from_file;
};

class Context {
public:

};
