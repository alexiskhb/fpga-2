	component unnamed is
		port (
			streaming_source_data  : out std_logic_vector(12 downto 0);        -- data
			streaming_source_valid : out std_logic;                            -- valid
			CONVST                 : out std_logic;                            -- convst
			SCK                    : out std_logic;                            -- sck
			SDI                    : out std_logic;                            -- sdi
			SDO                    : in  std_logic                     := 'X'; -- sdo
			slave_clk              : in  std_logic                     := 'X'; -- clk
			slave_readdata         : out std_logic_vector(15 downto 0);        -- readdata
			slave_chipselect       : in  std_logic                     := 'X'; -- chipselect
			slave_read             : in  std_logic                     := 'X'; -- read
			slave_address          : in  std_logic                     := 'X'; -- address
			slave_reset            : in  std_logic                     := 'X'; -- reset
			adc_clk                : in  std_logic                     := 'X'  -- clk
		);
	end component unnamed;

	u0 : component unnamed
		port map (
			streaming_source_data  => CONNECTED_TO_streaming_source_data,  -- avalon_streaming_source.data
			streaming_source_valid => CONNECTED_TO_streaming_source_valid, --                        .valid
			CONVST                 => CONNECTED_TO_CONVST,                 --             conduit_end.convst
			SCK                    => CONNECTED_TO_SCK,                    --                        .sck
			SDI                    => CONNECTED_TO_SDI,                    --                        .sdi
			SDO                    => CONNECTED_TO_SDO,                    --                        .sdo
			slave_clk              => CONNECTED_TO_slave_clk,              --              clock_sink.clk
			slave_readdata         => CONNECTED_TO_slave_readdata,         --                   slave.readdata
			slave_chipselect       => CONNECTED_TO_slave_chipselect,       --                        .chipselect
			slave_read             => CONNECTED_TO_slave_read,             --                        .read
			slave_address          => CONNECTED_TO_slave_address,          --                        .address
			slave_reset            => CONNECTED_TO_slave_reset,            --              reset_sink.reset
			adc_clk                => CONNECTED_TO_adc_clk                 --          clock_sink_adc.clk
		);

