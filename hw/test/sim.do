vlog C:/SoC/fpga-2/hw/ip/adc_fifo/adc_fifo.sv
vlog C:/SoC/fpga-2/hw/ip/dsp/dsp.sv
vlog C:/SoC/fpga-2/hw/soc_system/synthesis/submodules/soc_system_avalon_st_adapter.v
vlog C:/SoC/fpga-2/hw/soc_system/synthesis/submodules/soc_system_avalon_st_adapter_error_adapter_0.sv
vlog C:/SoC/fpga-2/hw/soc_system/synthesis/submodules/soc_system_avalon_st_adapter_channel_adapter_0.sv
vlog C:/SoC/fpga-2/hw/soc_system/synthesis/submodules/altera_avalon_sc_fifo.v
vlog C:/SoC/fpga-2/hw/soc_system/synthesis/submodules/soc_system_dma_0.v
vlog C:/SoC/fpga-2/hw/test/sum.v
vsim -L altera_mf_ver -L lpm_ver work.top_testbench
add wave -position insertpoint  \
sim:/top_testbench/clk \
sim:/top_testbench/reset \
sim:/top_testbench/adc_fifo/avalon_streaming_source_data \
sim:/top_testbench/adc_fifo/avalon_streaming_source_valid
add wave -position insertpoint  \
sim:/top_testbench/adc_fifo/avalon_streaming_sink_1_data \
sim:/top_testbench/adc_fifo/avalon_streaming_sink_1_channel \
sim:/top_testbench/adc_fifo/avalon_streaming_sink_1_error \
sim:/top_testbench/adc_fifo/avalon_streaming_sink_1_valid \
sim:/top_testbench/adc_fifo/avalon_streaming_sink_1_ready
add wave -position insertpoint  \
sim:/top_testbench/sc_fifo_0/in_data \
sim:/top_testbench/sc_fifo_0/in_valid \
sim:/top_testbench/sc_fifo_0/in_startofpacket \
sim:/top_testbench/sc_fifo_0/in_endofpacket \
sim:/top_testbench/sc_fifo_0/in_empty \
sim:/top_testbench/sc_fifo_0/in_error \
sim:/top_testbench/sc_fifo_0/in_channel \
sim:/top_testbench/sc_fifo_0/in_ready
add wave -position insertpoint  \
sim:/top_testbench/sc_fifo_0/out_data \
sim:/top_testbench/sc_fifo_0/out_valid \
sim:/top_testbench/sc_fifo_0/out_startofpacket \
sim:/top_testbench/sc_fifo_0/out_endofpacket \
sim:/top_testbench/sc_fifo_0/out_empty \
sim:/top_testbench/sc_fifo_0/out_error \
sim:/top_testbench/sc_fifo_0/out_channel \
sim:/top_testbench/adc_fifo/flag_in \
sim:/top_testbench/adc_fifo/flag_out \
sim:/top_testbench/adc_fifo/avalon_slave_chipselect
run 300
force -freeze sim:/top_testbench/adc_fifo/dma_event 1 0
run 300
force -freeze sim:/top_testbench/adc_fifo/avalon_slave_chipselect 1 0
