	unnamed u0 (
		.streaming_source_data  (<connected-to-streaming_source_data>),  // avalon_streaming_source.data
		.streaming_source_valid (<connected-to-streaming_source_valid>), //                        .valid
		.CONVST                 (<connected-to-CONVST>),                 //             conduit_end.convst
		.SCK                    (<connected-to-SCK>),                    //                        .sck
		.SDI                    (<connected-to-SDI>),                    //                        .sdi
		.SDO                    (<connected-to-SDO>),                    //                        .sdo
		.slave_clk              (<connected-to-slave_clk>),              //              clock_sink.clk
		.slave_readdata         (<connected-to-slave_readdata>),         //                   slave.readdata
		.slave_chipselect       (<connected-to-slave_chipselect>),       //                        .chipselect
		.slave_read             (<connected-to-slave_read>),             //                        .read
		.slave_address          (<connected-to-slave_address>),          //                        .address
		.slave_reset            (<connected-to-slave_reset>),            //              reset_sink.reset
		.adc_clk                (<connected-to-adc_clk>)                 //          clock_sink_adc.clk
	);

