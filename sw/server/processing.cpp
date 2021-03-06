#include <fftw3.h>
#include <cmath>
#include "processing.h"
#include <mutex>

std::mutex fftw3_plan_locker;

void process_ping_guilbert(const data_type* data, const int blocks_num, const int block_size, 
                           data_type* data_out, const float threshold, std::vector<hilbert_type>& hilbert_out,
                           std::vector<fourier_type>& fourier_out)
{
    float out[blocks_num][block_size];
    fftw_complex in_complex[blocks_num][block_size], out_complex[blocks_num][block_size];
    fftw_plan plan[blocks_num], plan_inv[blocks_num];
    float max_n = -1;
    float tmp = 0;
    hilbert_out.resize(block_size*blocks_num);
    fourier_out.resize(block_size*blocks_num);

    fftw3_plan_locker.lock();
    for (int i = 0; i < blocks_num; ++i) {
        plan[i] = fftw_plan_dft_1d(block_size, in_complex[i], out_complex[i], FFTW_FORWARD, FFTW_ESTIMATE);
        plan_inv[i] = fftw_plan_dft_1d(block_size, in_complex[i], out_complex[i], FFTW_BACKWARD, FFTW_ESTIMATE);
    }
    fftw3_plan_locker.unlock();
    for (int i = 0; i < blocks_num; ++i) {
        tmp = data[block_size * i];
        max_n = -1;
        for (int j = 0; j < block_size; ++j) {
            in_complex[i][j][0] = static_cast<float>(data[j + block_size * i]) - tmp;
            in_complex[i][j][1] = 0;
            tmp = static_cast<float>(data[j + block_size * i]);
            max_n = fmaxf(fabs(in_complex[i][j][0]), max_n);
        }
    }

    for (int i = 0; i < blocks_num; ++i) {
        for (int j = 0; j < block_size; ++j) {
            in_complex[i][j][0] /= max_n;
        }
        fftw_execute(plan[i]);

        for (int j = 0; j < block_size; ++j) {
            fourier_out[i*block_size + j] = sqrtf(out_complex[i][j][0] * out_complex[i][j][0] + out_complex[i][j][1] * out_complex[i][j][1]);
            if (j < (block_size / 2)) {
                in_complex[i][j][0] = out_complex[i][j][0] * 2;
                in_complex[i][j][1] = out_complex[i][j][1] * 2;
            } else {
                in_complex[i][j][0] = 0;
                in_complex[i][j][1] = 0;
            }
        }
        fftw_execute(plan_inv[i]);
        max_n = -1;
        for (int j = 0; j < block_size; ++j) {
            out[i][j] = sqrtf(out_complex[i][j][0] * out_complex[i][j][0] + out_complex[i][j][1] * out_complex[i][j][1]);
            max_n = fmaxf(fabs(out[i][j]), max_n);
            hilbert_out[i*block_size + j] = out[i][j];
        }
        
        data_out[i] = 0;
        for (int j = 0/*block_size / 4*/; j < block_size; ++j) {
            if (fabs(out[i][j]) > threshold * max_n) {
                data_out[i] = j;
                break;
            }
        }
    }
    fftw3_plan_locker.lock();
    for (int i = 0; i < blocks_num; ++i) {
        fftw_destroy_plan(plan[i]);
        fftw_destroy_plan(plan_inv[i]);
    }
    fftw3_plan_locker.unlock();
}
