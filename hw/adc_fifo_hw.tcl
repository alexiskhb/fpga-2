# TCL File Generated by Component Editor 17.1
# Thu Dec 28 12:59:01 SBT 2017
# DO NOT MODIFY


# 
# adc_fifo "adc_fifo" v1.0
#  2017.12.28.12:59:01
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
# connection point avalon_streaming_source
# 
add_interface avalon_streaming_source avalon_streaming start
set_interface_property avalon_streaming_source associatedClock clock_sink
set_interface_property avalon_streaming_source associatedReset reset_sink
set_interface_property avalon_streaming_source dataBitsPerSymbol 16
set_interface_property avalon_streaming_source errorDescriptor ""
set_interface_property avalon_streaming_source firstSymbolInHighOrderBits true
set_interface_property avalon_streaming_source maxChannel 0
set_interface_property avalon_streaming_source readyLatency 0
set_interface_property avalon_streaming_source ENABLED true
set_interface_property avalon_streaming_source EXPORT_OF ""
set_interface_property avalon_streaming_source PORT_NAME_MAP ""
set_interface_property avalon_streaming_source CMSIS_SVD_VARIABLES ""
set_interface_property avalon_streaming_source SVD_ADDRESS_GROUP ""

add_interface_port avalon_streaming_source avalon_streaming_source_data data Output 16
add_interface_port avalon_streaming_source avalon_streaming_source_valid valid Output 1


# 
# connection point avalon_master
# 
add_interface avalon_master avalon start
set_interface_property avalon_master addressUnits SYMBOLS
set_interface_property avalon_master associatedClock clock_sink
set_interface_property avalon_master associatedReset reset_sink
set_interface_property avalon_master bitsPerSymbol 8
set_interface_property avalon_master burstOnBurstBoundariesOnly false
set_interface_property avalon_master burstcountUnits WORDS
set_interface_property avalon_master doStreamReads false
set_interface_property avalon_master doStreamWrites false
set_interface_property avalon_master holdTime 0
set_interface_property avalon_master linewrapBursts false
set_interface_property avalon_master maximumPendingReadTransactions 0
set_interface_property avalon_master maximumPendingWriteTransactions 0
set_interface_property avalon_master readLatency 0
set_interface_property avalon_master readWaitTime 1
set_interface_property avalon_master setupTime 0
set_interface_property avalon_master timingUnits Cycles
set_interface_property avalon_master writeWaitTime 0
set_interface_property avalon_master ENABLED true
set_interface_property avalon_master EXPORT_OF ""
set_interface_property avalon_master PORT_NAME_MAP ""
set_interface_property avalon_master CMSIS_SVD_VARIABLES ""
set_interface_property avalon_master SVD_ADDRESS_GROUP ""

add_interface_port avalon_master avalon_master_address address Output 32
add_interface_port avalon_master avalon_master_read read Output 1
add_interface_port avalon_master avalon_master_readdata readdata Input 32
add_interface_port avalon_master avalon_master_writedata writedata Output 32
add_interface_port avalon_master avalon_master_write write Output 1
add_interface_port avalon_master avalon_master_waitrequest waitrequest Input 1


# 
# connection point avalon_slave
# 
add_interface avalon_slave avalon end
set_interface_property avalon_slave addressUnits WORDS
set_interface_property avalon_slave associatedClock clock_sink
set_interface_property avalon_slave associatedReset reset_sink
set_interface_property avalon_slave bitsPerSymbol 8
set_interface_property avalon_slave burstOnBurstBoundariesOnly false
set_interface_property avalon_slave burstcountUnits WORDS
set_interface_property avalon_slave explicitAddressSpan 0
set_interface_property avalon_slave holdTime 0
set_interface_property avalon_slave linewrapBursts false
set_interface_property avalon_slave maximumPendingReadTransactions 1
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

add_interface_port avalon_slave avalon_slave_address address Input 7
add_interface_port avalon_slave avalon_slave_readdata readdata Output 16
add_interface_port avalon_slave avalon_slave_read read_n Input 1
add_interface_port avalon_slave avalon_slave_waitrequest waitrequest Output 1
add_interface_port avalon_slave avalon_slave_readdatavalid readdatavalid Output 1
add_interface_port avalon_slave avalon_slave_chipselect chipselect Input 1
set_interface_assignment avalon_slave embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave embeddedsw.configuration.isPrintableDevice 0


# 
# connection point avalon_streaming_sink
# 
add_interface avalon_streaming_sink avalon_streaming end
set_interface_property avalon_streaming_sink associatedClock clock_sink
set_interface_property avalon_streaming_sink associatedReset reset_sink
set_interface_property avalon_streaming_sink dataBitsPerSymbol 32
set_interface_property avalon_streaming_sink errorDescriptor ""
set_interface_property avalon_streaming_sink firstSymbolInHighOrderBits true
set_interface_property avalon_streaming_sink maxChannel 0
set_interface_property avalon_streaming_sink readyLatency 0
set_interface_property avalon_streaming_sink ENABLED true
set_interface_property avalon_streaming_sink EXPORT_OF ""
set_interface_property avalon_streaming_sink PORT_NAME_MAP ""
set_interface_property avalon_streaming_sink CMSIS_SVD_VARIABLES ""
set_interface_property avalon_streaming_sink SVD_ADDRESS_GROUP ""

add_interface_port avalon_streaming_sink avalon_streaming_sink_valid valid Input 1
add_interface_port avalon_streaming_sink avalon_streaming_sink_data data Input 32


# 
# connection point avalon_streaming_sink_1
# 
add_interface avalon_streaming_sink_1 avalon_streaming end
set_interface_property avalon_streaming_sink_1 associatedClock clock_sink
set_interface_property avalon_streaming_sink_1 associatedReset reset_sink
set_interface_property avalon_streaming_sink_1 dataBitsPerSymbol 16
set_interface_property avalon_streaming_sink_1 errorDescriptor ""
set_interface_property avalon_streaming_sink_1 firstSymbolInHighOrderBits true
set_interface_property avalon_streaming_sink_1 maxChannel 0
set_interface_property avalon_streaming_sink_1 readyLatency 0
set_interface_property avalon_streaming_sink_1 ENABLED true
set_interface_property avalon_streaming_sink_1 EXPORT_OF ""
set_interface_property avalon_streaming_sink_1 PORT_NAME_MAP ""
set_interface_property avalon_streaming_sink_1 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_streaming_sink_1 SVD_ADDRESS_GROUP ""

add_interface_port avalon_streaming_sink_1 avalon_streaming_sink_1_channel channel Input 8
add_interface_port avalon_streaming_sink_1 avalon_streaming_sink_1_data data Input 16
add_interface_port avalon_streaming_sink_1 avalon_streaming_sink_1_error error Input 8
add_interface_port avalon_streaming_sink_1 avalon_streaming_sink_1_valid valid Input 1
add_interface_port avalon_streaming_sink_1 avalon_streaming_sink_1_ready ready Output 1


# 
# connection point avalon_streaming_source_1
# 
add_interface avalon_streaming_source_1 avalon_streaming start
set_interface_property avalon_streaming_source_1 associatedClock clock_sink
set_interface_property avalon_streaming_source_1 associatedReset reset_sink
set_interface_property avalon_streaming_source_1 dataBitsPerSymbol 32
set_interface_property avalon_streaming_source_1 errorDescriptor ""
set_interface_property avalon_streaming_source_1 firstSymbolInHighOrderBits true
set_interface_property avalon_streaming_source_1 maxChannel 0
set_interface_property avalon_streaming_source_1 readyLatency 0
set_interface_property avalon_streaming_source_1 ENABLED true
set_interface_property avalon_streaming_source_1 EXPORT_OF ""
set_interface_property avalon_streaming_source_1 PORT_NAME_MAP ""
set_interface_property avalon_streaming_source_1 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_streaming_source_1 SVD_ADDRESS_GROUP ""

add_interface_port avalon_streaming_source_1 avalon_streaming_source_1_data data Output 32
add_interface_port avalon_streaming_source_1 avalon_streaming_source_1_valid valid Output 1


# 
# connection point avalon_ss_adc
# 
add_interface avalon_ss_adc avalon_streaming end
set_interface_property avalon_ss_adc associatedClock clock_sink
set_interface_property avalon_ss_adc associatedReset reset_sink
set_interface_property avalon_ss_adc dataBitsPerSymbol 13
set_interface_property avalon_ss_adc errorDescriptor ""
set_interface_property avalon_ss_adc firstSymbolInHighOrderBits true
set_interface_property avalon_ss_adc maxChannel 0
set_interface_property avalon_ss_adc readyLatency 0
set_interface_property avalon_ss_adc ENABLED true
set_interface_property avalon_ss_adc EXPORT_OF ""
set_interface_property avalon_ss_adc PORT_NAME_MAP ""
set_interface_property avalon_ss_adc CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_adc SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_adc avalon_ss_adc_data data Input 13
add_interface_port avalon_ss_adc avalon_ss_adc_valid valid Input 1
add_interface_port avalon_ss_adc avalon_ss_adc_channel channel Input 3

