vlog D:/project/fpga-2/hw/ip/adc_fifo/adc_fifo.sv
vlog D:/project/fpga-2/hw/ip/dsp/dsp.sv
vlog D:/project/fpga-2/hw/soc_system/synthesis/submodules/soc_system_fifo_0.v
vlog D:/project/fpga-2/hw/soc_system/synthesis/submodules/soc_system_avalon_st_adapter.v
vlog D:/project/fpga-2/hw/soc_system/synthesis/submodules/soc_system_avalon_st_adapter_error_adapter_0.sv
vlog D:/project/fpga-2/hw/soc_system/synthesis/submodules/soc_system_avalon_st_adapter_channel_adapter_0.sv
vlog D:/project/fpga-2/hw/soc_system/synthesis/submodules/altera_avalon_sc_fifo.v
vlog D:/project/fpga-2/hw/test/sum.v
vsim -L altera_mf_ver -L lpm_ver work.top_testbench
add wave -position insertpoint  \
sim:/top_testbench/clk \
sim:/top_testbench/reset \
sim:/top_testbench/key \
sim:/top_testbench/ports_led \
sim:/top_testbench/dsp_avalon_streaming_source_valid \
sim:/top_testbench/dsp_avalon_streaming_source_data \
sim:/top_testbench/adc_fifo_avalon_streaming_source_valid \
sim:/top_testbench/adc_fifo_avalon_streaming_source_data \
sim:/top_testbench/avalon_st_adapter_001_out_0_valid \
sim:/top_testbench/avalon_st_adapter_001_out_0_data \
sim:/top_testbench/adc_fifo/avalon_streaming_sink_1_data \
sim:/top_testbench/adc_fifo/avalon_streaming_sink_1_valid \
sim:/top_testbench/adc_fifo/avalon_streaming_source_data \
sim:/top_testbench/adc_fifo/avalon_streaming_source_valid \
sim:/top_testbench/adc_fifo/flag_in \
sim:/top_testbench/adc_fifo/flag_out \
sim:/top_testbench/adc_fifo_avalon_master_readdata \
sim:/top_testbench/adc_fifo_avalon_master_waitrequest \
sim:/top_testbench/adc_fifo_avalon_master_address \
sim:/top_testbench/adc_fifo_avalon_master_read \
sim:/top_testbench/adc_fifo_avalon_master_writedata \
sim:/top_testbench/adc_fifo_avalon_master_write \
sim:/top_testbench/fifo_ready \
sim:/top_testbench/sc_fifo_0/in_data \
sim:/top_testbench/sc_fifo_0/in_valid \
sim:/top_testbench/sc_fifo_0/in_ready \
sim:/top_testbench/sc_fifo_0/out_data \
sim:/top_testbench/sc_fifo_0/out_valid \
sim:/top_testbench/sc_fifo_0/out_ready \
sim:/top_testbench/sc_fifo_0/csr_address \
sim:/top_testbench/sc_fifo_0/csr_write \
sim:/top_testbench/sc_fifo_0/csr_read \
sim:/top_testbench/sc_fifo_0/csr_writedata \
sim:/top_testbench/sc_fifo_0/csr_readdata \
sim:/top_testbench/sc_fifo_0/out_ready
run 300
force -freeze sim:/top_testbench/adc_fifo/dma_event 1 0
run 200
force -freeze sim:/top_testbench/adc_fifo/avalon_slave_read 1 0