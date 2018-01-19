# TCL File Generated by Component Editor 17.1
# Fri Jan 19 21:11:01 SBT 2018
# DO NOT MODIFY


# 
# pinger_simulator "pinger_simulator" v1.0
#  2018.01.19.21:11:01
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module pinger_simulator
# 
set_module_property DESCRIPTION ""
set_module_property NAME pinger_simulator
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Terasic Qsys Component"
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME pinger_simulator
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL pinger_simulator
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file pinger_simulator.sv SYSTEM_VERILOG PATH ip/pinger_simulator/pinger_simulator.sv TOP_LEVEL_FILE


# 
# parameters
# 


# 
# display items
# 


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
# connection point avalon_ss_nco_in
# 
add_interface avalon_ss_nco_in avalon_streaming start
set_interface_property avalon_ss_nco_in associatedClock clock_sink
set_interface_property avalon_ss_nco_in associatedReset reset_sink
set_interface_property avalon_ss_nco_in dataBitsPerSymbol 32
set_interface_property avalon_ss_nco_in errorDescriptor ""
set_interface_property avalon_ss_nco_in firstSymbolInHighOrderBits true
set_interface_property avalon_ss_nco_in maxChannel 0
set_interface_property avalon_ss_nco_in readyLatency 0
set_interface_property avalon_ss_nco_in ENABLED true
set_interface_property avalon_ss_nco_in EXPORT_OF ""
set_interface_property avalon_ss_nco_in PORT_NAME_MAP ""
set_interface_property avalon_ss_nco_in CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_nco_in SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_nco_in nco_phase_inc data Output 32


# 
# connection point avalon_ss_nco_out
# 
add_interface avalon_ss_nco_out avalon_streaming end
set_interface_property avalon_ss_nco_out associatedClock clock_sink
set_interface_property avalon_ss_nco_out associatedReset reset_sink
set_interface_property avalon_ss_nco_out dataBitsPerSymbol 12
set_interface_property avalon_ss_nco_out errorDescriptor ""
set_interface_property avalon_ss_nco_out firstSymbolInHighOrderBits true
set_interface_property avalon_ss_nco_out maxChannel 0
set_interface_property avalon_ss_nco_out readyLatency 0
set_interface_property avalon_ss_nco_out ENABLED true
set_interface_property avalon_ss_nco_out EXPORT_OF ""
set_interface_property avalon_ss_nco_out PORT_NAME_MAP ""
set_interface_property avalon_ss_nco_out CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_nco_out SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_nco_out nco_sin_out data Input 12


# 
# connection point avalon_ss_out
# 
add_interface avalon_ss_out avalon_streaming start
set_interface_property avalon_ss_out associatedClock clock_sink
set_interface_property avalon_ss_out associatedReset reset_sink
set_interface_property avalon_ss_out dataBitsPerSymbol 16
set_interface_property avalon_ss_out errorDescriptor ""
set_interface_property avalon_ss_out firstSymbolInHighOrderBits true
set_interface_property avalon_ss_out maxChannel 0
set_interface_property avalon_ss_out readyLatency 0
set_interface_property avalon_ss_out ENABLED true
set_interface_property avalon_ss_out EXPORT_OF ""
set_interface_property avalon_ss_out PORT_NAME_MAP ""
set_interface_property avalon_ss_out CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_out SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_out adc_value data Output 16
add_interface_port avalon_ss_out next_channel ready Input 1


# 
# connection point avalon_ss_pinger_param
# 
add_interface avalon_ss_pinger_param avalon_streaming end
set_interface_property avalon_ss_pinger_param associatedClock clock_sink
set_interface_property avalon_ss_pinger_param associatedReset reset_sink
set_interface_property avalon_ss_pinger_param dataBitsPerSymbol 32
set_interface_property avalon_ss_pinger_param errorDescriptor ""
set_interface_property avalon_ss_pinger_param firstSymbolInHighOrderBits true
set_interface_property avalon_ss_pinger_param maxChannel 0
set_interface_property avalon_ss_pinger_param readyLatency 0
set_interface_property avalon_ss_pinger_param ENABLED true
set_interface_property avalon_ss_pinger_param EXPORT_OF ""
set_interface_property avalon_ss_pinger_param PORT_NAME_MAP ""
set_interface_property avalon_ss_pinger_param CMSIS_SVD_VARIABLES ""
set_interface_property avalon_ss_pinger_param SVD_ADDRESS_GROUP ""

add_interface_port avalon_ss_pinger_param pinger_param_channel channel Input 8
add_interface_port avalon_ss_pinger_param pinger_param_data data Input 32
