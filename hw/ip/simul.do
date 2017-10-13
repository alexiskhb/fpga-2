vlog -reportprogress 300 -work work ~/src/zz/ip/dsp/matchedFilter.sv
vlog -reportprogress 300 -work work ~/src/zz/ip/dsp/dsp.sv
vlog -reportprogress 300 -work work ~/src/zz/ip/dsp/hps_driver.sv
vlog -reportprogress 300 -work work ~/src/zz/ip/dsp/sdram_driver.sv
vsim -L altera_mf_ver -L lpm_ver work.dsp
add wave -position insertpoint  \
sim:/dsp/clk
add wave -position insertpoint  \
sim:/dsp/coder_tx_inst/data_out
add wave -position insertpoint  \
{sim:/dsp/pins[0]}
add wave -position insertpoint  \
sim:/dsp/start_tx
add wave -position insertpoint  \
sim:/dsp/decoder_rx_inst/data_out_mf0
add wave -position insertpoint  \
sim:/dsp/decoder_rx_inst/data_out_mf1
add wave -position insertpoint  \
sim:/dsp/decoder_rx_inst/input_data
add wave -position insertpoint  \
sim:/dsp/decoder_rx_inst/data_in_mf
add wave -position insertpoint  \
sim:/dsp/decoder_rx_inst/mult_delay_data_out
add wave -position insertpoint  \
sim:/dsp/decoder_rx_inst/m_filter_inst0/data_delayed
add wave -position insertpoint  \
sim:/dsp/decoder_rx_inst/m_filter_inst1/data_delayed
force -freeze sim:/dsp/clk 1 0, 0 {5000 ps} -r 10000
force -freeze sim:/dsp/reset 1 0
run 100000
force -freeze sim:/dsp/reset 0 0
run 1000000000
force -freeze sim:/dsp/hps_driver_inst/address 8'h18 0
force -freeze sim:/dsp/hps_driver_inst/chipselect 1 0
force -freeze sim:/dsp/hps_driver_inst/write_en 1 0
run 10000
noforce sim:/dsp/hps_driver_inst/write_en
noforce sim:/dsp/hps_driver_inst/address
noforce sim:/dsp/hps_driver_inst/chipselect