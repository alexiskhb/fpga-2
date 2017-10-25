vlog -reportprogress 300 -work work /home/ser/src/zz/ip/dac_ad7303/dac_ad7303.sv
vsim work.dac
add wave -position insertpoint  \
sim:/dac/clk
add wave -position insertpoint  \
sim:/dac/dac_clk
add wave -position insertpoint  \
sim:/dac/cnt
add wave -position insertpoint  \
sim:/dac/data
add wave -position insertpoint  \
sim:/dac/SCLK
add wave -position insertpoint  \
sim:/dac/SYNC
add wave -position insertpoint  \
sim:/dac/DIN
force -freeze sim:/dac/clk 1 0, 0 {5000 ps} -r 10000
force -freeze sim:/dac/dac_clk 1 0, 0 {25000 ps} -r 50000
force -freeze sim:/dac/streaming_sink_valid 1 0
force -freeze sim:/dac/reset 0 0
force -freeze sim:/dac/streaming_sink_data 11001010 0