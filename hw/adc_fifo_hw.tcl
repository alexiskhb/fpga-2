# TCL File Generated by Component Editor 17.1
# Thu Jan 18 15:55:09 VLAT 2018
# DO NOT MODIFY


# 
# adc_fifo "adc_fifo" v1.0
#  2018.01.18.15:55:09
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module adc_fifo
# 
set_module_property DESCRIPTION ""
set_module_property NAME adc_fifo
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Terasic Qsys Component"
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME adc_fifo
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL adc_fifo
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file adc_fifo.sv SYSTEM_VERILOG PATH ip/adc_fifo/adc_fifo.sv TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink clk clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink reset reset Input 1


# 
# connection point avalon_ss_adc
# 
add_interface avalon_ss_adc avalon_streaming end
set_interface_property avalon_ss_adc associatedClock clock_sink
set_interface_property avalon_ss_adc associatedReset reset_sink
set_interface_property avalon_ss_adc dataBitsPerSymbol 16
set_interface_property avalon_ss_adc errorDescriptor ""
set_interface_property avalon_ss_adc firstSymbolInHighOrderBits true
set_interface_property avalon_ss_adc maxChannel 0
set_interface_property avalon_ss_adc readyLatency 0
set_interface_property avalon_ss_adc ENABLED true
set_interface_property avalon_ss_adc EXPORT_OF ""
set_interface_property avalon_ss_adc PORT_NAME_MAP ""
set_interface_property avalon_ss_adc CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_adc SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_adc adc_data data Input 16
add_interface_port avalon_ss_adc adc_valid valid Input 1
add_interface_port avalon_ss_adc adc_channel channel Input 3


# 
# connection point avalon_ss_fifo_in
# 
add_interface avalon_ss_fifo_in avalon_streaming start
set_interface_property avalon_ss_fifo_in associatedClock clock_sink
set_interface_property avalon_ss_fifo_in associatedReset reset_sink
set_interface_property avalon_ss_fifo_in dataBitsPerSymbol 16
set_interface_property avalon_ss_fifo_in errorDescriptor ""
set_interface_property avalon_ss_fifo_in firstSymbolInHighOrderBits true
set_interface_property avalon_ss_fifo_in maxChannel 0
set_interface_property avalon_ss_fifo_in readyLatency 0
set_interface_property avalon_ss_fifo_in ENABLED true
set_interface_property avalon_ss_fifo_in EXPORT_OF ""
set_interface_property avalon_ss_fifo_in PORT_NAME_MAP ""
set_interface_property avalon_ss_fifo_in CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_fifo_in SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_fifo_in fifo_in_data data Output 16
add_interface_port avalon_ss_fifo_in fifo_in_valid valid Output 1


# 
# connection point avalon_ss_fifo_out
# 
add_interface avalon_ss_fifo_out avalon_streaming end
set_interface_property avalon_ss_fifo_out associatedClock clock_sink
set_interface_property avalon_ss_fifo_out associatedReset reset_sink
set_interface_property avalon_ss_fifo_out dataBitsPerSymbol 16
set_interface_property avalon_ss_fifo_out errorDescriptor ""
set_interface_property avalon_ss_fifo_out firstSymbolInHighOrderBits true
set_interface_property avalon_ss_fifo_out maxChannel 0
set_interface_property avalon_ss_fifo_out readyLatency 0
set_interface_property avalon_ss_fifo_out ENABLED true
set_interface_property avalon_ss_fifo_out EXPORT_OF ""
set_interface_property avalon_ss_fifo_out PORT_NAME_MAP ""
set_interface_property avalon_ss_fifo_out CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_fifo_out SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_fifo_out fifo_out_channel channel Input 8
add_interface_port avalon_ss_fifo_out fifo_out_data data Input 16
add_interface_port avalon_ss_fifo_out fifo_out_error error Input 8
add_interface_port avalon_ss_fifo_out fifo_out_valid valid Input 1
add_interface_port avalon_ss_fifo_out fifo_out_ready ready Output 1


# 
# connection point avalon_slave_dma
# 
add_interface avalon_slave_dma avalon end
set_interface_property avalon_slave_dma addressUnits WORDS
set_interface_property avalon_slave_dma associatedClock clock_sink
set_interface_property avalon_slave_dma associatedReset reset_sink
set_interface_property avalon_slave_dma bitsPerSymbol 8
set_interface_property avalon_slave_dma burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_dma burstcountUnits WORDS
set_interface_property avalon_slave_dma explicitAddressSpan 0
set_interface_property avalon_slave_dma holdTime 0
set_interface_property avalon_slave_dma linewrapBursts false
set_interface_property avalon_slave_dma maximumPendingReadTransactions 1
set_interface_property avalon_slave_dma maximumPendingWriteTransactions 0
set_interface_property avalon_slave_dma readLatency 0
set_interface_property avalon_slave_dma readWaitTime 1
set_interface_property avalon_slave_dma setupTime 0
set_interface_property avalon_slave_dma timingUnits Cycles
set_interface_property avalon_slave_dma writeWaitTime 0
set_interface_property avalon_slave_dma ENABLED true
set_interface_property avalon_slave_dma EXPORT_OF ""
set_interface_property avalon_slave_dma PORT_NAME_MAP ""
set_interface_property avalon_slave_dma CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_dma SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_dma dma_address address Input 7
add_interface_port avalon_slave_dma dma_readdata readdata Output 16
add_interface_port avalon_slave_dma dma_read read_n Input 1
add_interface_port avalon_slave_dma dma_waitrequest waitrequest Output 1
add_interface_port avalon_slave_dma dma_readdatavalid readdatavalid Output 1
add_interface_port avalon_slave_dma dma_chipselect chipselect Input 1
set_interface_assignment avalon_slave_dma embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_dma embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_dma embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_dma embeddedsw.configuration.isPrintableDevice 0


# 
# connection point avalon_master_csr_fifo
# 
add_interface avalon_master_csr_fifo avalon start
set_interface_property avalon_master_csr_fifo addressUnits SYMBOLS
set_interface_property avalon_master_csr_fifo associatedClock clock_sink
set_interface_property avalon_master_csr_fifo associatedReset reset_sink
set_interface_property avalon_master_csr_fifo bitsPerSymbol 8
set_interface_property avalon_master_csr_fifo burstOnBurstBoundariesOnly false
set_interface_property avalon_master_csr_fifo burstcountUnits WORDS
set_interface_property avalon_master_csr_fifo doStreamReads false
set_interface_property avalon_master_csr_fifo doStreamWrites false
set_interface_property avalon_master_csr_fifo holdTime 0
set_interface_property avalon_master_csr_fifo linewrapBursts false
set_interface_property avalon_master_csr_fifo maximumPendingReadTransactions 0
set_interface_property avalon_master_csr_fifo maximumPendingWriteTransactions 0
set_interface_property avalon_master_csr_fifo readLatency 0
set_interface_property avalon_master_csr_fifo readWaitTime 1
set_interface_property avalon_master_csr_fifo setupTime 0
set_interface_property avalon_master_csr_fifo timingUnits Cycles
set_interface_property avalon_master_csr_fifo writeWaitTime 0
set_interface_property avalon_master_csr_fifo ENABLED true
set_interface_property avalon_master_csr_fifo EXPORT_OF ""
set_interface_property avalon_master_csr_fifo PORT_NAME_MAP ""
set_interface_property avalon_master_csr_fifo CMSIS_SVD_VARIABLES ""
set_interface_property avalon_master_csr_fifo SVD_ADDRESS_GROUP ""

add_interface_port avalon_master_csr_fifo fifo_csr_address address Output 32
add_interface_port avalon_master_csr_fifo fifo_csr_read read Output 1
add_interface_port avalon_master_csr_fifo fifo_csr_readdata readdata Input 32
add_interface_port avalon_master_csr_fifo fifo_csr_writedata writedata Output 32
add_interface_port avalon_master_csr_fifo fifo_csr_write write Output 1
add_interface_port avalon_master_csr_fifo fifo_csr_waitrequest waitrequest Input 1


# 
# connection point avalon_ss_dsp
# 
add_interface avalon_ss_dsp avalon_streaming end
set_interface_property avalon_ss_dsp associatedClock clock_sink
set_interface_property avalon_ss_dsp associatedReset reset_sink
set_interface_property avalon_ss_dsp dataBitsPerSymbol 32
set_interface_property avalon_ss_dsp errorDescriptor ""
set_interface_property avalon_ss_dsp firstSymbolInHighOrderBits true
set_interface_property avalon_ss_dsp maxChannel 0
set_interface_property avalon_ss_dsp readyLatency 0
set_interface_property avalon_ss_dsp ENABLED true
set_interface_property avalon_ss_dsp EXPORT_OF ""
set_interface_property avalon_ss_dsp PORT_NAME_MAP ""
set_interface_property avalon_ss_dsp CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_dsp SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_dsp dsp_ss_valid valid Input 1
add_interface_port avalon_ss_dsp dsp_ss_data data Input 32


# 
# connection point interrupt_sender
# 
add_interface interrupt_sender interrupt end
set_interface_property interrupt_sender associatedAddressablePoint ""
set_interface_property interrupt_sender associatedClock clock_sink
set_interface_property interrupt_sender associatedReset reset_sink
set_interface_property interrupt_sender bridgedReceiverOffset ""
set_interface_property interrupt_sender bridgesToReceiver ""
set_interface_property interrupt_sender ENABLED true
set_interface_property interrupt_sender EXPORT_OF ""
set_interface_property interrupt_sender PORT_NAME_MAP ""
set_interface_property interrupt_sender CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_sender SVD_ADDRESS_GROUP ""

add_interface_port interrupt_sender irq irq Output 1


# 
# connection point fft_in
# 
add_interface fft_in avalon_streaming start
set_interface_property fft_in associatedClock clock_sink
set_interface_property fft_in associatedReset reset_sink
set_interface_property fft_in dataBitsPerSymbol 32
set_interface_property fft_in errorDescriptor ""
set_interface_property fft_in firstSymbolInHighOrderBits true
set_interface_property fft_in maxChannel 0
set_interface_property fft_in readyLatency 0
set_interface_property fft_in ENABLED true
set_interface_property fft_in EXPORT_OF ""
set_interface_property fft_in PORT_NAME_MAP ""
set_interface_property fft_in CMSIS_SVD_VARIABLES ""
set_interface_property fft_in SVD_ADDRESS_GROUP ""

add_interface_port fft_in next_in valid Output 1
add_interface_port fft_in X data Output 32


# 
# connection point fft_out
# 
add_interface fft_out avalon_streaming end
set_interface_property fft_out associatedClock clock_sink
set_interface_property fft_out associatedReset reset_sink
set_interface_property fft_out dataBitsPerSymbol 64
set_interface_property fft_out errorDescriptor ""
set_interface_property fft_out firstSymbolInHighOrderBits true
set_interface_property fft_out maxChannel 0
set_interface_property fft_out readyLatency 0
set_interface_property fft_out ENABLED true
set_interface_property fft_out EXPORT_OF ""
set_interface_property fft_out PORT_NAME_MAP ""
set_interface_property fft_out CMSIS_SVD_VARIABLES ""
set_interface_property fft_out SVD_ADDRESS_GROUP ""

add_interface_port fft_out next_out valid Input 1
add_interface_port fft_out Y data Input 64


# 
# connection point avalon_ss_sqrt_out
# 
add_interface avalon_ss_sqrt_out avalon_streaming end
set_interface_property avalon_ss_sqrt_out associatedClock clock_sink
set_interface_property avalon_ss_sqrt_out associatedReset reset_sink
set_interface_property avalon_ss_sqrt_out dataBitsPerSymbol 16
set_interface_property avalon_ss_sqrt_out errorDescriptor ""
set_interface_property avalon_ss_sqrt_out firstSymbolInHighOrderBits true
set_interface_property avalon_ss_sqrt_out maxChannel 0
set_interface_property avalon_ss_sqrt_out readyLatency 0
set_interface_property avalon_ss_sqrt_out ENABLED true
set_interface_property avalon_ss_sqrt_out EXPORT_OF ""
set_interface_property avalon_ss_sqrt_out PORT_NAME_MAP ""
set_interface_property avalon_ss_sqrt_out CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_sqrt_out SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_sqrt_out sqrt_result data Input 16
add_interface_port avalon_ss_sqrt_out sqrt_busy valid Input 1


# 
# connection point avalon_ss_sqrt_in
# 
add_interface avalon_ss_sqrt_in avalon_streaming start
set_interface_property avalon_ss_sqrt_in associatedClock clock_sink
set_interface_property avalon_ss_sqrt_in associatedReset reset_sink
set_interface_property avalon_ss_sqrt_in dataBitsPerSymbol 32
set_interface_property avalon_ss_sqrt_in errorDescriptor ""
set_interface_property avalon_ss_sqrt_in firstSymbolInHighOrderBits true
set_interface_property avalon_ss_sqrt_in maxChannel 0
set_interface_property avalon_ss_sqrt_in readyLatency 0
set_interface_property avalon_ss_sqrt_in ENABLED true
set_interface_property avalon_ss_sqrt_in EXPORT_OF ""
set_interface_property avalon_ss_sqrt_in PORT_NAME_MAP ""
set_interface_property avalon_ss_sqrt_in CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_sqrt_in SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_sqrt_in sqrt_value data Output 32
add_interface_port avalon_ss_sqrt_in sqrt_start valid Output 1


# 
# connection point avalon_ss_data_controller_in
# 
add_interface avalon_ss_data_controller_in avalon_streaming start
set_interface_property avalon_ss_data_controller_in associatedClock clock_sink
set_interface_property avalon_ss_data_controller_in associatedReset reset_sink
set_interface_property avalon_ss_data_controller_in dataBitsPerSymbol 16
set_interface_property avalon_ss_data_controller_in errorDescriptor ""
set_interface_property avalon_ss_data_controller_in firstSymbolInHighOrderBits true
set_interface_property avalon_ss_data_controller_in maxChannel 0
set_interface_property avalon_ss_data_controller_in readyLatency 0
set_interface_property avalon_ss_data_controller_in ENABLED true
set_interface_property avalon_ss_data_controller_in EXPORT_OF ""
set_interface_property avalon_ss_data_controller_in PORT_NAME_MAP ""
set_interface_property avalon_ss_data_controller_in CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_data_controller_in SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_data_controller_in data_cntrl_valid valid Output 1
add_interface_port avalon_ss_data_controller_in data_cntrl_data data Output 16
add_interface_port avalon_ss_data_controller_in data_cntrl_channel channel Output 3


# 
# connection point avalon_ss_fft_fifo0_out
# 
add_interface avalon_ss_fft_fifo0_out avalon_streaming end
set_interface_property avalon_ss_fft_fifo0_out associatedClock clock_sink
set_interface_property avalon_ss_fft_fifo0_out associatedReset reset_sink
set_interface_property avalon_ss_fft_fifo0_out dataBitsPerSymbol 32
set_interface_property avalon_ss_fft_fifo0_out errorDescriptor ""
set_interface_property avalon_ss_fft_fifo0_out firstSymbolInHighOrderBits true
set_interface_property avalon_ss_fft_fifo0_out maxChannel 0
set_interface_property avalon_ss_fft_fifo0_out readyLatency 0
set_interface_property avalon_ss_fft_fifo0_out ENABLED true
set_interface_property avalon_ss_fft_fifo0_out EXPORT_OF ""
set_interface_property avalon_ss_fft_fifo0_out PORT_NAME_MAP ""
set_interface_property avalon_ss_fft_fifo0_out CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_fft_fifo0_out SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_fft_fifo0_out fft_fifo0_out_channel channel Input 8
add_interface_port avalon_ss_fft_fifo0_out fft_fifo0_out_data data Input 32
add_interface_port avalon_ss_fft_fifo0_out fft_fifo0_out_error error Input 8
add_interface_port avalon_ss_fft_fifo0_out fft_fifo0_out_ready ready Output 1
add_interface_port avalon_ss_fft_fifo0_out fft_fifo0_out_valid valid Input 1


# 
# connection point avalon_ss_fft_fifo1_out
# 
add_interface avalon_ss_fft_fifo1_out avalon_streaming end
set_interface_property avalon_ss_fft_fifo1_out associatedClock clock_sink
set_interface_property avalon_ss_fft_fifo1_out associatedReset reset_sink
set_interface_property avalon_ss_fft_fifo1_out dataBitsPerSymbol 32
set_interface_property avalon_ss_fft_fifo1_out errorDescriptor ""
set_interface_property avalon_ss_fft_fifo1_out firstSymbolInHighOrderBits true
set_interface_property avalon_ss_fft_fifo1_out maxChannel 0
set_interface_property avalon_ss_fft_fifo1_out readyLatency 0
set_interface_property avalon_ss_fft_fifo1_out ENABLED true
set_interface_property avalon_ss_fft_fifo1_out EXPORT_OF ""
set_interface_property avalon_ss_fft_fifo1_out PORT_NAME_MAP ""
set_interface_property avalon_ss_fft_fifo1_out CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_fft_fifo1_out SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_fft_fifo1_out fft_fifo1_out_channel channel Input 8
add_interface_port avalon_ss_fft_fifo1_out fft_fifo1_out_data data Input 32
add_interface_port avalon_ss_fft_fifo1_out fft_fifo1_out_error error Input 8
add_interface_port avalon_ss_fft_fifo1_out fft_fifo1_out_ready ready Output 1
add_interface_port avalon_ss_fft_fifo1_out fft_fifo1_out_valid valid Input 1


# 
# connection point avalon_ss_fft_fifo2_out
# 
add_interface avalon_ss_fft_fifo2_out avalon_streaming end
set_interface_property avalon_ss_fft_fifo2_out associatedClock clock_sink
set_interface_property avalon_ss_fft_fifo2_out associatedReset reset_sink
set_interface_property avalon_ss_fft_fifo2_out dataBitsPerSymbol 32
set_interface_property avalon_ss_fft_fifo2_out errorDescriptor ""
set_interface_property avalon_ss_fft_fifo2_out firstSymbolInHighOrderBits true
set_interface_property avalon_ss_fft_fifo2_out maxChannel 0
set_interface_property avalon_ss_fft_fifo2_out readyLatency 0
set_interface_property avalon_ss_fft_fifo2_out ENABLED true
set_interface_property avalon_ss_fft_fifo2_out EXPORT_OF ""
set_interface_property avalon_ss_fft_fifo2_out PORT_NAME_MAP ""
set_interface_property avalon_ss_fft_fifo2_out CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_fft_fifo2_out SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_fft_fifo2_out fft_fifo2_out_channel channel Input 8
add_interface_port avalon_ss_fft_fifo2_out fft_fifo2_out_data data Input 32
add_interface_port avalon_ss_fft_fifo2_out fft_fifo2_out_error error Input 8
add_interface_port avalon_ss_fft_fifo2_out fft_fifo2_out_ready ready Output 1
add_interface_port avalon_ss_fft_fifo2_out fft_fifo2_out_valid valid Input 1


# 
# connection point avalon_slave
# 
add_interface avalon_slave avalon end
set_interface_property avalon_slave addressUnits WORDS
set_interface_property avalon_slave associatedClock clock_sink
set_interface_property avalon_slave associatedReset reset_sink
set_interface_property avalon_slave bitsPerSymbol 32
set_interface_property avalon_slave burstOnBurstBoundariesOnly false
set_interface_property avalon_slave burstcountUnits WORDS
set_interface_property avalon_slave explicitAddressSpan 0
set_interface_property avalon_slave holdTime 0
set_interface_property avalon_slave linewrapBursts false
set_interface_property avalon_slave maximumPendingReadTransactions 0
set_interface_property avalon_slave maximumPendingWriteTransactions 0
set_interface_property avalon_slave readLatency 0
set_interface_property avalon_slave readWaitTime 1
set_interface_property avalon_slave setupTime 0
set_interface_property avalon_slave timingUnits Cycles
set_interface_property avalon_slave writeWaitTime 0
set_interface_property avalon_slave ENABLED true
set_interface_property avalon_slave EXPORT_OF ""
set_interface_property avalon_slave PORT_NAME_MAP ""
set_interface_property avalon_slave CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave slave_address address Input 8
add_interface_port avalon_slave slave_read read Input 1
add_interface_port avalon_slave slave_readdata readdata Output 32
add_interface_port avalon_slave slave_chipselect chipselect Input 1
add_interface_port avalon_slave slave_write write Input 1
add_interface_port avalon_slave slave_writedata writedata Input 32
set_interface_assignment avalon_slave embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave embeddedsw.configuration.isPrintableDevice 0

