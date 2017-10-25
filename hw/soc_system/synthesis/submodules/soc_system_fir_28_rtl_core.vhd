-- ------------------------------------------------------------------------- 
-- Intel Altera DSP Builder Advanced Flow Tools Release Version 16.1
-- Quartus Prime development tool and MATLAB/Simulink Interface
-- 
-- Legal Notice: Copyright 2016 Intel Corporation.  All rights reserved.
-- Your use of  Intel  Corporation's design tools,  logic functions and other
-- software and tools,  and its AMPP  partner logic functions, and  any output
-- files  any of the  foregoing  device programming or simulation files),  and
-- any associated  documentation or information are expressly subject  to  the
-- terms and conditions  of the Intel FPGA Software License Agreement,
-- Intel  MegaCore  Function  License  Agreement, or other applicable license
-- agreement,  including,  without limitation,  that your use  is for the sole
-- purpose of  programming  logic  devices  manufactured by Intel and sold by
-- Intel or its authorized  distributors.  Please  refer  to  the  applicable
-- agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from soc_system_fir_28_rtl_core
-- VHDL created on Fri Dec 23 14:01:06 2016


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity soc_system_fir_28_rtl_core is
    port (
        xIn_v : in std_logic_vector(0 downto 0);  -- sfix1
        xIn_c : in std_logic_vector(7 downto 0);  -- sfix8
        xIn_0 : in std_logic_vector(12 downto 0);  -- sfix13
        xOut_v : out std_logic_vector(0 downto 0);  -- ufix1
        xOut_c : out std_logic_vector(7 downto 0);  -- ufix8
        xOut_0 : out std_logic_vector(31 downto 0);  -- sfix32
        clk : in std_logic;
        areset : in std_logic
    );
end soc_system_fir_28_rtl_core;

architecture normal of soc_system_fir_28_rtl_core is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_in0_m0_wi0_wo0_assign_id1_q_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_count : STD_LOGIC_VECTOR (1 downto 0);
    signal u0_m0_wo0_run_preEnaQ : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_out : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_enableQ : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_run_ctrl : STD_LOGIC_VECTOR (2 downto 0);
    signal u0_m0_wo0_memread_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_compute_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_14_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_u0_m0_wo0_compute_q_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_inner_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_inner_i : SIGNED (7 downto 0);
    attribute preserve : boolean;
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count0_inner_i : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count0_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_i : UNSIGNED (6 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count0_i : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count1_lutreg_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_q : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_i : UNSIGNED (6 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count1_i : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count1_eq : std_logic;
    attribute preserve of u0_m0_wo0_wi0_r0_ra0_count1_eq : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_a : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_b : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_o : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_add_0_0_q : STD_LOGIC_VECTOR (8 downto 0);
    signal u0_m0_wo0_wi0_r0_wa0_q : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_wa0_i : UNSIGNED (6 downto 0);
    attribute preserve of u0_m0_wo0_wi0_r0_wa0_i : signal is true;
    signal u0_m0_wo0_wi0_r0_memr0_reset0 : std_logic;
    signal u0_m0_wo0_wi0_r0_memr0_ia : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_aa : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_ab : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_iq : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_wi0_r0_memr0_q : STD_LOGIC_VECTOR (12 downto 0);
    signal u0_m0_wo0_ca0_q : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_ca0_i : UNSIGNED (6 downto 0);
    attribute preserve of u0_m0_wo0_ca0_i : signal is true;
    signal u0_m0_wo0_ca0_eq : std_logic;
    attribute preserve of u0_m0_wo0_ca0_eq : signal is true;
    signal u0_m0_wo0_cm0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal u0_m0_wo0_aseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_aseq_eq : std_logic;
    signal u0_m0_wo0_accum_a : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_accum_b : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_accum_i : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_accum_o : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_accum_q : STD_LOGIC_VECTOR (31 downto 0);
    signal u0_m0_wo0_oseq_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_eq : std_logic;
    signal u0_m0_wo0_oseq_gated_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    type u0_m0_wo0_mtree_mult1_0_cma_a0type is array(0 to 0) of SIGNED(12 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_a0 : u0_m0_wo0_mtree_mult1_0_cma_a0type;
    attribute preserve of u0_m0_wo0_mtree_mult1_0_cma_a0 : signal is true;
    type u0_m0_wo0_mtree_mult1_0_cma_c0type is array(0 to 0) of SIGNED(11 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_c0 : u0_m0_wo0_mtree_mult1_0_cma_c0type;
    attribute preserve of u0_m0_wo0_mtree_mult1_0_cma_c0 : signal is true;
    type u0_m0_wo0_mtree_mult1_0_cma_ptype is array(0 to 0) of SIGNED(24 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_p : u0_m0_wo0_mtree_mult1_0_cma_ptype;
    signal u0_m0_wo0_mtree_mult1_0_cma_u : u0_m0_wo0_mtree_mult1_0_cma_ptype;
    signal u0_m0_wo0_mtree_mult1_0_cma_w : u0_m0_wo0_mtree_mult1_0_cma_ptype;
    signal u0_m0_wo0_mtree_mult1_0_cma_x : u0_m0_wo0_mtree_mult1_0_cma_ptype;
    signal u0_m0_wo0_mtree_mult1_0_cma_y : u0_m0_wo0_mtree_mult1_0_cma_ptype;
    signal u0_m0_wo0_mtree_mult1_0_cma_s : u0_m0_wo0_mtree_mult1_0_cma_ptype;
    signal u0_m0_wo0_mtree_mult1_0_cma_qq : STD_LOGIC_VECTOR (24 downto 0);
    signal u0_m0_wo0_mtree_mult1_0_cma_q : STD_LOGIC_VECTOR (24 downto 0);
    signal d_xIn_0_13_mem_reset0 : std_logic;
    signal d_xIn_0_13_mem_ia : STD_LOGIC_VECTOR (12 downto 0);
    signal d_xIn_0_13_mem_aa : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_mem_ab : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_mem_iq : STD_LOGIC_VECTOR (12 downto 0);
    signal d_xIn_0_13_mem_q : STD_LOGIC_VECTOR (12 downto 0);
    signal d_xIn_0_13_rdcnt_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_rdcnt_i : UNSIGNED (0 downto 0);
    attribute preserve of d_xIn_0_13_rdcnt_i : signal is true;
    signal d_xIn_0_13_wraddr_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute preserve of d_xIn_0_13_sticky_ena_q : signal is true;
    signal u0_m0_wo0_wi0_r0_ra0_count0_run_a : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count0_run_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_gated_a : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_gated_b : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_oseq_gated_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_notEnable_a : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_nor_a : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_nor_b : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_enaAnd_a : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_enaAnd_b : STD_LOGIC_VECTOR (0 downto 0);
    signal d_xIn_0_13_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_count1_lut_q : STD_LOGIC_VECTOR (7 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_resize_in : STD_LOGIC_VECTOR (6 downto 0);
    signal u0_m0_wo0_wi0_r0_ra0_resize_b : STD_LOGIC_VECTOR (6 downto 0);
    signal out0_m0_wo0_lineup_select_delay_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal out0_m0_wo0_assign_id3_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)@0
    VCC_q <= "1";

    -- xIn(PORTIN,2)@10

    -- u0_m0_wo0_run(ENABLEGENERATOR,9)@10 + 2
    u0_m0_wo0_run_ctrl <= u0_m0_wo0_run_out & xIn_v & u0_m0_wo0_run_enableQ;
    u0_m0_wo0_run_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_run_enable_c : SIGNED(7 downto 0);
        variable u0_m0_wo0_run_inc : SIGNED(1 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_run_q <= "0";
            u0_m0_wo0_run_enable_c := TO_SIGNED(123, 8);
            u0_m0_wo0_run_enableQ <= "0";
            u0_m0_wo0_run_count <= "00";
            u0_m0_wo0_run_inc := (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_run_out = "1") THEN
                IF (u0_m0_wo0_run_enable_c(7) = '1') THEN
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c - (-124);
                ELSE
                    u0_m0_wo0_run_enable_c := u0_m0_wo0_run_enable_c + (-1);
                END IF;
                u0_m0_wo0_run_enableQ <= STD_LOGIC_VECTOR(u0_m0_wo0_run_enable_c(7 downto 7));
            ELSE
                u0_m0_wo0_run_enableQ <= "0";
            END IF;
            CASE (u0_m0_wo0_run_ctrl) IS
                WHEN "000" | "001" => u0_m0_wo0_run_inc := "00";
                WHEN "010" | "011" => u0_m0_wo0_run_inc := "11";
                WHEN "100" => u0_m0_wo0_run_inc := "00";
                WHEN "101" => u0_m0_wo0_run_inc := "01";
                WHEN "110" => u0_m0_wo0_run_inc := "11";
                WHEN "111" => u0_m0_wo0_run_inc := "00";
                WHEN OTHERS => 
            END CASE;
            u0_m0_wo0_run_count <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_run_count) + SIGNED(u0_m0_wo0_run_inc));
            u0_m0_wo0_run_q <= u0_m0_wo0_run_out;
        END IF;
    END PROCESS;
    u0_m0_wo0_run_preEnaQ <= u0_m0_wo0_run_count(1 downto 1);
    u0_m0_wo0_run_out <= u0_m0_wo0_run_preEnaQ and VCC_q;

    -- u0_m0_wo0_memread(DELAY,10)@12
    u0_m0_wo0_memread : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_run_q, xout => u0_m0_wo0_memread_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_compute(DELAY,11)@12
    u0_m0_wo0_compute : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_memread_q, xout => u0_m0_wo0_compute_q, clk => clk, aclr => areset );

    -- d_u0_m0_wo0_compute_q_14(DELAY,39)@12 + 2
    d_u0_m0_wo0_compute_q_14 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC" )
    PORT MAP ( xin => u0_m0_wo0_compute_q, xout => d_u0_m0_wo0_compute_q_14_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_aseq(SEQUENCE,26)@14 + 1
    u0_m0_wo0_aseq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_aseq_c : SIGNED(8 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_aseq_c := "000000000";
            u0_m0_wo0_aseq_q <= "0";
            u0_m0_wo0_aseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_14_q = "1") THEN
                IF (u0_m0_wo0_aseq_c = "000000000") THEN
                    u0_m0_wo0_aseq_eq <= '1';
                ELSE
                    u0_m0_wo0_aseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_aseq_eq = '1') THEN
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c + 124;
                ELSE
                    u0_m0_wo0_aseq_c := u0_m0_wo0_aseq_c - 1;
                END IF;
                u0_m0_wo0_aseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_aseq_c(8 downto 8));
            END IF;
        END IF;
    END PROCESS;

    -- d_u0_m0_wo0_compute_q_15(DELAY,40)@14 + 1
    d_u0_m0_wo0_compute_q_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC" )
    PORT MAP ( xin => d_u0_m0_wo0_compute_q_14_q, xout => d_u0_m0_wo0_compute_q_15_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_ca0(COUNTER,23)@12
    -- low=0, high=124, step=1, init=0
    u0_m0_wo0_ca0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_ca0_i <= TO_UNSIGNED(0, 7);
            u0_m0_wo0_ca0_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_compute_q = "1") THEN
                IF (u0_m0_wo0_ca0_i = TO_UNSIGNED(123, 7)) THEN
                    u0_m0_wo0_ca0_eq <= '1';
                ELSE
                    u0_m0_wo0_ca0_eq <= '0';
                END IF;
                IF (u0_m0_wo0_ca0_eq = '1') THEN
                    u0_m0_wo0_ca0_i <= u0_m0_wo0_ca0_i + 4;
                ELSE
                    u0_m0_wo0_ca0_i <= u0_m0_wo0_ca0_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_ca0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_ca0_i, 7)));

    -- u0_m0_wo0_cm0(LOOKUP,24)@12 + 1
    u0_m0_wo0_cm0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_cm0_q <= "000000000000";
        ELSIF (clk'EVENT AND clk = '1') THEN
            CASE (u0_m0_wo0_ca0_q) IS
                WHEN "0000000" => u0_m0_wo0_cm0_q <= "000000000000";
                WHEN "0000001" => u0_m0_wo0_cm0_q <= "000000000100";
                WHEN "0000010" => u0_m0_wo0_cm0_q <= "000000001011";
                WHEN "0000011" => u0_m0_wo0_cm0_q <= "000000000011";
                WHEN "0000100" => u0_m0_wo0_cm0_q <= "000000000000";
                WHEN "0000101" => u0_m0_wo0_cm0_q <= "111111110000";
                WHEN "0000110" => u0_m0_wo0_cm0_q <= "111111011111";
                WHEN "0000111" => u0_m0_wo0_cm0_q <= "111111001111";
                WHEN "0001000" => u0_m0_wo0_cm0_q <= "111111000100";
                WHEN "0001001" => u0_m0_wo0_cm0_q <= "111111000000";
                WHEN "0001010" => u0_m0_wo0_cm0_q <= "111111000101";
                WHEN "0001011" => u0_m0_wo0_cm0_q <= "111111010010";
                WHEN "0001100" => u0_m0_wo0_cm0_q <= "111111100110";
                WHEN "0001101" => u0_m0_wo0_cm0_q <= "111111111101";
                WHEN "0001110" => u0_m0_wo0_cm0_q <= "000000010001";
                WHEN "0001111" => u0_m0_wo0_cm0_q <= "000000100010";
                WHEN "0010000" => u0_m0_wo0_cm0_q <= "000000101001";
                WHEN "0010001" => u0_m0_wo0_cm0_q <= "000000101000";
                WHEN "0010010" => u0_m0_wo0_cm0_q <= "000000011110";
                WHEN "0010011" => u0_m0_wo0_cm0_q <= "000000010000";
                WHEN "0010100" => u0_m0_wo0_cm0_q <= "000000000011";
                WHEN "0010101" => u0_m0_wo0_cm0_q <= "111111111111";
                WHEN "0010110" => u0_m0_wo0_cm0_q <= "000000000101";
                WHEN "0010111" => u0_m0_wo0_cm0_q <= "000000011011";
                WHEN "0011000" => u0_m0_wo0_cm0_q <= "000001000000";
                WHEN "0011001" => u0_m0_wo0_cm0_q <= "000001101110";
                WHEN "0011010" => u0_m0_wo0_cm0_q <= "000010011011";
                WHEN "0011011" => u0_m0_wo0_cm0_q <= "000010111010";
                WHEN "0011100" => u0_m0_wo0_cm0_q <= "000011000000";
                WHEN "0011101" => u0_m0_wo0_cm0_q <= "000010100000";
                WHEN "0011110" => u0_m0_wo0_cm0_q <= "000001010100";
                WHEN "0011111" => u0_m0_wo0_cm0_q <= "111111011111";
                WHEN "0100000" => u0_m0_wo0_cm0_q <= "111101001001";
                WHEN "0100001" => u0_m0_wo0_cm0_q <= "111010100101";
                WHEN "0100010" => u0_m0_wo0_cm0_q <= "111000001101";
                WHEN "0100011" => u0_m0_wo0_cm0_q <= "110110011111";
                WHEN "0100100" => u0_m0_wo0_cm0_q <= "110101110101";
                WHEN "0100101" => u0_m0_wo0_cm0_q <= "110110100101";
                WHEN "0100110" => u0_m0_wo0_cm0_q <= "111000111001";
                WHEN "0100111" => u0_m0_wo0_cm0_q <= "111100101100";
                WHEN "0101000" => u0_m0_wo0_cm0_q <= "000001100111";
                WHEN "0101001" => u0_m0_wo0_cm0_q <= "000111001000";
                WHEN "0101010" => u0_m0_wo0_cm0_q <= "001100011111";
                WHEN "0101011" => u0_m0_wo0_cm0_q <= "010000110101";
                WHEN "0101100" => u0_m0_wo0_cm0_q <= "010011011100";
                WHEN "0101101" => u0_m0_wo0_cm0_q <= "010011101011";
                WHEN "0101110" => u0_m0_wo0_cm0_q <= "010001010001";
                WHEN "0101111" => u0_m0_wo0_cm0_q <= "001100010001";
                WHEN "0110000" => u0_m0_wo0_cm0_q <= "000101000111";
                WHEN "0110001" => u0_m0_wo0_cm0_q <= "111100101010";
                WHEN "0110010" => u0_m0_wo0_cm0_q <= "110011111011";
                WHEN "0110011" => u0_m0_wo0_cm0_q <= "101100000111";
                WHEN "0110100" => u0_m0_wo0_cm0_q <= "100110011000";
                WHEN "0110101" => u0_m0_wo0_cm0_q <= "100011101001";
                WHEN "0110110" => u0_m0_wo0_cm0_q <= "100100011011";
                WHEN "0110111" => u0_m0_wo0_cm0_q <= "101000110100";
                WHEN "0111000" => u0_m0_wo0_cm0_q <= "110000010111";
                WHEN "0111001" => u0_m0_wo0_cm0_q <= "111010001100";
                WHEN "0111010" => u0_m0_wo0_cm0_q <= "000101000011";
                WHEN "0111011" => u0_m0_wo0_cm0_q <= "001111100010";
                WHEN "0111100" => u0_m0_wo0_cm0_q <= "011000001111";
                WHEN "0111101" => u0_m0_wo0_cm0_q <= "011101111110";
                WHEN "0111110" => u0_m0_wo0_cm0_q <= "011111111110";
                WHEN "0111111" => u0_m0_wo0_cm0_q <= "011101111110";
                WHEN "1000000" => u0_m0_wo0_cm0_q <= "011000001111";
                WHEN "1000001" => u0_m0_wo0_cm0_q <= "001111100010";
                WHEN "1000010" => u0_m0_wo0_cm0_q <= "000101000011";
                WHEN "1000011" => u0_m0_wo0_cm0_q <= "111010001100";
                WHEN "1000100" => u0_m0_wo0_cm0_q <= "110000010111";
                WHEN "1000101" => u0_m0_wo0_cm0_q <= "101000110100";
                WHEN "1000110" => u0_m0_wo0_cm0_q <= "100100011011";
                WHEN "1000111" => u0_m0_wo0_cm0_q <= "100011101001";
                WHEN "1001000" => u0_m0_wo0_cm0_q <= "100110011000";
                WHEN "1001001" => u0_m0_wo0_cm0_q <= "101100000111";
                WHEN "1001010" => u0_m0_wo0_cm0_q <= "110011111011";
                WHEN "1001011" => u0_m0_wo0_cm0_q <= "111100101010";
                WHEN "1001100" => u0_m0_wo0_cm0_q <= "000101000111";
                WHEN "1001101" => u0_m0_wo0_cm0_q <= "001100010001";
                WHEN "1001110" => u0_m0_wo0_cm0_q <= "010001010001";
                WHEN "1001111" => u0_m0_wo0_cm0_q <= "010011101011";
                WHEN "1010000" => u0_m0_wo0_cm0_q <= "010011011100";
                WHEN "1010001" => u0_m0_wo0_cm0_q <= "010000110101";
                WHEN "1010010" => u0_m0_wo0_cm0_q <= "001100011111";
                WHEN "1010011" => u0_m0_wo0_cm0_q <= "000111001000";
                WHEN "1010100" => u0_m0_wo0_cm0_q <= "000001100111";
                WHEN "1010101" => u0_m0_wo0_cm0_q <= "111100101100";
                WHEN "1010110" => u0_m0_wo0_cm0_q <= "111000111001";
                WHEN "1010111" => u0_m0_wo0_cm0_q <= "110110100101";
                WHEN "1011000" => u0_m0_wo0_cm0_q <= "110101110101";
                WHEN "1011001" => u0_m0_wo0_cm0_q <= "110110011111";
                WHEN "1011010" => u0_m0_wo0_cm0_q <= "111000001101";
                WHEN "1011011" => u0_m0_wo0_cm0_q <= "111010100101";
                WHEN "1011100" => u0_m0_wo0_cm0_q <= "111101001001";
                WHEN "1011101" => u0_m0_wo0_cm0_q <= "111111011111";
                WHEN "1011110" => u0_m0_wo0_cm0_q <= "000001010100";
                WHEN "1011111" => u0_m0_wo0_cm0_q <= "000010100000";
                WHEN "1100000" => u0_m0_wo0_cm0_q <= "000011000000";
                WHEN "1100001" => u0_m0_wo0_cm0_q <= "000010111010";
                WHEN "1100010" => u0_m0_wo0_cm0_q <= "000010011011";
                WHEN "1100011" => u0_m0_wo0_cm0_q <= "000001101110";
                WHEN "1100100" => u0_m0_wo0_cm0_q <= "000001000000";
                WHEN "1100101" => u0_m0_wo0_cm0_q <= "000000011011";
                WHEN "1100110" => u0_m0_wo0_cm0_q <= "000000000101";
                WHEN "1100111" => u0_m0_wo0_cm0_q <= "111111111111";
                WHEN "1101000" => u0_m0_wo0_cm0_q <= "000000000011";
                WHEN "1101001" => u0_m0_wo0_cm0_q <= "000000010000";
                WHEN "1101010" => u0_m0_wo0_cm0_q <= "000000011110";
                WHEN "1101011" => u0_m0_wo0_cm0_q <= "000000101000";
                WHEN "1101100" => u0_m0_wo0_cm0_q <= "000000101001";
                WHEN "1101101" => u0_m0_wo0_cm0_q <= "000000100010";
                WHEN "1101110" => u0_m0_wo0_cm0_q <= "000000010001";
                WHEN "1101111" => u0_m0_wo0_cm0_q <= "111111111101";
                WHEN "1110000" => u0_m0_wo0_cm0_q <= "111111100110";
                WHEN "1110001" => u0_m0_wo0_cm0_q <= "111111010010";
                WHEN "1110010" => u0_m0_wo0_cm0_q <= "111111000101";
                WHEN "1110011" => u0_m0_wo0_cm0_q <= "111111000000";
                WHEN "1110100" => u0_m0_wo0_cm0_q <= "111111000100";
                WHEN "1110101" => u0_m0_wo0_cm0_q <= "111111001111";
                WHEN "1110110" => u0_m0_wo0_cm0_q <= "111111011111";
                WHEN "1110111" => u0_m0_wo0_cm0_q <= "111111110000";
                WHEN "1111000" => u0_m0_wo0_cm0_q <= "000000000000";
                WHEN "1111001" => u0_m0_wo0_cm0_q <= "000000000011";
                WHEN "1111010" => u0_m0_wo0_cm0_q <= "000000001011";
                WHEN "1111011" => u0_m0_wo0_cm0_q <= "000000000100";
                WHEN "1111100" => u0_m0_wo0_cm0_q <= "000000000000";
                WHEN OTHERS => -- unreachable
                               u0_m0_wo0_cm0_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra0_count1(COUNTER,18)@12
    -- low=0, high=124, step=1, init=1
    u0_m0_wo0_wi0_r0_ra0_count1_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count1_i <= TO_UNSIGNED(1, 7);
            u0_m0_wo0_wi0_r0_ra0_count1_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                IF (u0_m0_wo0_wi0_r0_ra0_count1_i = TO_UNSIGNED(123, 7)) THEN
                    u0_m0_wo0_wi0_r0_ra0_count1_eq <= '1';
                ELSE
                    u0_m0_wo0_wi0_r0_ra0_count1_eq <= '0';
                END IF;
                IF (u0_m0_wo0_wi0_r0_ra0_count1_eq = '1') THEN
                    u0_m0_wo0_wi0_r0_ra0_count1_i <= u0_m0_wo0_wi0_r0_ra0_count1_i + 4;
                ELSE
                    u0_m0_wo0_wi0_r0_ra0_count1_i <= u0_m0_wo0_wi0_r0_ra0_count1_i + 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_count1_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra0_count1_i, 7)));

    -- u0_m0_wo0_wi0_r0_ra0_count1_lut(LOOKUP,16)@12
    u0_m0_wo0_wi0_r0_ra0_count1_lut_combproc: PROCESS (u0_m0_wo0_wi0_r0_ra0_count1_q)
    BEGIN
        -- Begin reserved scope level
        CASE (u0_m0_wo0_wi0_r0_ra0_count1_q) IS
            WHEN "0000000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01111101";
            WHEN "0000001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01111110";
            WHEN "0000010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01111111";
            WHEN "0000011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00000000";
            WHEN "0000100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00000001";
            WHEN "0000101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00000010";
            WHEN "0000110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00000011";
            WHEN "0000111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00000100";
            WHEN "0001000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00000101";
            WHEN "0001001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00000110";
            WHEN "0001010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00000111";
            WHEN "0001011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00001000";
            WHEN "0001100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00001001";
            WHEN "0001101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00001010";
            WHEN "0001110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00001011";
            WHEN "0001111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00001100";
            WHEN "0010000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00001101";
            WHEN "0010001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00001110";
            WHEN "0010010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00001111";
            WHEN "0010011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00010000";
            WHEN "0010100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00010001";
            WHEN "0010101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00010010";
            WHEN "0010110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00010011";
            WHEN "0010111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00010100";
            WHEN "0011000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00010101";
            WHEN "0011001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00010110";
            WHEN "0011010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00010111";
            WHEN "0011011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00011000";
            WHEN "0011100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00011001";
            WHEN "0011101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00011010";
            WHEN "0011110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00011011";
            WHEN "0011111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00011100";
            WHEN "0100000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00011101";
            WHEN "0100001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00011110";
            WHEN "0100010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00011111";
            WHEN "0100011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00100000";
            WHEN "0100100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00100001";
            WHEN "0100101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00100010";
            WHEN "0100110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00100011";
            WHEN "0100111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00100100";
            WHEN "0101000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00100101";
            WHEN "0101001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00100110";
            WHEN "0101010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00100111";
            WHEN "0101011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00101000";
            WHEN "0101100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00101001";
            WHEN "0101101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00101010";
            WHEN "0101110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00101011";
            WHEN "0101111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00101100";
            WHEN "0110000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00101101";
            WHEN "0110001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00101110";
            WHEN "0110010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00101111";
            WHEN "0110011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00110000";
            WHEN "0110100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00110001";
            WHEN "0110101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00110010";
            WHEN "0110110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00110011";
            WHEN "0110111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00110100";
            WHEN "0111000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00110101";
            WHEN "0111001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00110110";
            WHEN "0111010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00110111";
            WHEN "0111011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00111000";
            WHEN "0111100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00111001";
            WHEN "0111101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00111010";
            WHEN "0111110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00111011";
            WHEN "0111111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00111100";
            WHEN "1000000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00111101";
            WHEN "1000001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00111110";
            WHEN "1000010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "00111111";
            WHEN "1000011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01000000";
            WHEN "1000100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01000001";
            WHEN "1000101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01000010";
            WHEN "1000110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01000011";
            WHEN "1000111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01000100";
            WHEN "1001000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01000101";
            WHEN "1001001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01000110";
            WHEN "1001010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01000111";
            WHEN "1001011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01001000";
            WHEN "1001100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01001001";
            WHEN "1001101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01001010";
            WHEN "1001110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01001011";
            WHEN "1001111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01001100";
            WHEN "1010000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01001101";
            WHEN "1010001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01001110";
            WHEN "1010010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01001111";
            WHEN "1010011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01010000";
            WHEN "1010100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01010001";
            WHEN "1010101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01010010";
            WHEN "1010110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01010011";
            WHEN "1010111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01010100";
            WHEN "1011000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01010101";
            WHEN "1011001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01010110";
            WHEN "1011010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01010111";
            WHEN "1011011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01011000";
            WHEN "1011100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01011001";
            WHEN "1011101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01011010";
            WHEN "1011110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01011011";
            WHEN "1011111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01011100";
            WHEN "1100000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01011101";
            WHEN "1100001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01011110";
            WHEN "1100010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01011111";
            WHEN "1100011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01100000";
            WHEN "1100100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01100001";
            WHEN "1100101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01100010";
            WHEN "1100110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01100011";
            WHEN "1100111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01100100";
            WHEN "1101000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01100101";
            WHEN "1101001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01100110";
            WHEN "1101010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01100111";
            WHEN "1101011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01101000";
            WHEN "1101100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01101001";
            WHEN "1101101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01101010";
            WHEN "1101110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01101011";
            WHEN "1101111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01101100";
            WHEN "1110000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01101101";
            WHEN "1110001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01101110";
            WHEN "1110010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01101111";
            WHEN "1110011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01110000";
            WHEN "1110100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01110001";
            WHEN "1110101" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01110010";
            WHEN "1110110" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01110011";
            WHEN "1110111" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01110100";
            WHEN "1111000" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01110101";
            WHEN "1111001" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01110110";
            WHEN "1111010" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01110111";
            WHEN "1111011" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01111000";
            WHEN "1111100" => u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= "01111001";
            WHEN OTHERS => -- unreachable
                           u0_m0_wo0_wi0_r0_ra0_count1_lut_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra0_count1_lutreg(REG,17)@12
    u0_m0_wo0_wi0_r0_ra0_count1_lutreg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count1_lutreg_q <= "01111101";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra0_count1_lutreg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_count1_lut_q);
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_wi0_r0_ra0_count0_inner(COUNTER,13)@12
    -- low=-1, high=123, step=-1, init=123
    u0_m0_wo0_wi0_r0_ra0_count0_inner_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count0_inner_i <= TO_SIGNED(123, 8);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1") THEN
                IF (u0_m0_wo0_wi0_r0_ra0_count0_inner_i(7 downto 7) = "1") THEN
                    u0_m0_wo0_wi0_r0_ra0_count0_inner_i <= u0_m0_wo0_wi0_r0_ra0_count0_inner_i - 132;
                ELSE
                    u0_m0_wo0_wi0_r0_ra0_count0_inner_i <= u0_m0_wo0_wi0_r0_ra0_count0_inner_i - 1;
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_count0_inner_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra0_count0_inner_i, 8)));

    -- u0_m0_wo0_wi0_r0_ra0_count0_run(LOGICAL,14)@12
    u0_m0_wo0_wi0_r0_ra0_count0_run_a <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_count0_inner_q);
    u0_m0_wo0_wi0_r0_ra0_count0_run_q <= u0_m0_wo0_wi0_r0_ra0_count0_run_a(7 downto 7);

    -- u0_m0_wo0_wi0_r0_ra0_count0(COUNTER,15)@12
    -- low=0, high=127, step=1, init=0
    u0_m0_wo0_wi0_r0_ra0_count0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_count0_i <= TO_UNSIGNED(0, 7);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (u0_m0_wo0_memread_q = "1" and u0_m0_wo0_wi0_r0_ra0_count0_run_q = "1") THEN
                u0_m0_wo0_wi0_r0_ra0_count0_i <= u0_m0_wo0_wi0_r0_ra0_count0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_count0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_ra0_count0_i, 8)));

    -- u0_m0_wo0_wi0_r0_ra0_add_0_0(ADD,19)@12 + 1
    u0_m0_wo0_wi0_r0_ra0_add_0_0_a <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_ra0_count0_q);
    u0_m0_wo0_wi0_r0_ra0_add_0_0_b <= STD_LOGIC_VECTOR("0" & u0_m0_wo0_wi0_r0_ra0_count1_lutreg_q);
    u0_m0_wo0_wi0_r0_ra0_add_0_0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_add_0_0_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_wi0_r0_ra0_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(u0_m0_wo0_wi0_r0_ra0_add_0_0_a) + UNSIGNED(u0_m0_wo0_wi0_r0_ra0_add_0_0_b));
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_ra0_add_0_0_q <= u0_m0_wo0_wi0_r0_ra0_add_0_0_o(8 downto 0);

    -- u0_m0_wo0_wi0_r0_ra0_resize(BITSELECT,20)@13
    u0_m0_wo0_wi0_r0_ra0_resize_in <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_add_0_0_q(6 downto 0));
    u0_m0_wo0_wi0_r0_ra0_resize_b <= STD_LOGIC_VECTOR(u0_m0_wo0_wi0_r0_ra0_resize_in(6 downto 0));

    -- d_xIn_0_13_notEnable(LOGICAL,45)@10
    d_xIn_0_13_notEnable_a <= STD_LOGIC_VECTOR(VCC_q);
    d_xIn_0_13_notEnable_q <= not (d_xIn_0_13_notEnable_a);

    -- d_xIn_0_13_nor(LOGICAL,46)@10
    d_xIn_0_13_nor_a <= STD_LOGIC_VECTOR(d_xIn_0_13_notEnable_q);
    d_xIn_0_13_nor_b <= STD_LOGIC_VECTOR(d_xIn_0_13_sticky_ena_q);
    d_xIn_0_13_nor_q <= not (d_xIn_0_13_nor_a or d_xIn_0_13_nor_b);

    -- d_xIn_0_13_cmpReg(REG,44)@10 + 1
    d_xIn_0_13_cmpReg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_13_cmpReg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            d_xIn_0_13_cmpReg_q <= STD_LOGIC_VECTOR(VCC_q);
        END IF;
    END PROCESS;

    -- d_xIn_0_13_sticky_ena(REG,47)@10 + 1
    d_xIn_0_13_sticky_ena_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_13_sticky_ena_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_xIn_0_13_nor_q = "1") THEN
                d_xIn_0_13_sticky_ena_q <= STD_LOGIC_VECTOR(d_xIn_0_13_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- d_xIn_0_13_enaAnd(LOGICAL,48)@10
    d_xIn_0_13_enaAnd_a <= STD_LOGIC_VECTOR(d_xIn_0_13_sticky_ena_q);
    d_xIn_0_13_enaAnd_b <= STD_LOGIC_VECTOR(VCC_q);
    d_xIn_0_13_enaAnd_q <= d_xIn_0_13_enaAnd_a and d_xIn_0_13_enaAnd_b;

    -- d_xIn_0_13_rdcnt(COUNTER,42)@10 + 1
    -- low=0, high=1, step=1, init=0
    d_xIn_0_13_rdcnt_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_13_rdcnt_i <= TO_UNSIGNED(0, 1);
        ELSIF (clk'EVENT AND clk = '1') THEN
            d_xIn_0_13_rdcnt_i <= d_xIn_0_13_rdcnt_i + 1;
        END IF;
    END PROCESS;
    d_xIn_0_13_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(d_xIn_0_13_rdcnt_i, 1)));

    -- d_xIn_0_13_wraddr(REG,43)@10 + 1
    d_xIn_0_13_wraddr_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            d_xIn_0_13_wraddr_q <= "1";
        ELSIF (clk'EVENT AND clk = '1') THEN
            d_xIn_0_13_wraddr_q <= STD_LOGIC_VECTOR(d_xIn_0_13_rdcnt_q);
        END IF;
    END PROCESS;

    -- d_xIn_0_13_mem(DUALMEM,41)@10 + 2
    d_xIn_0_13_mem_ia <= STD_LOGIC_VECTOR(xIn_0);
    d_xIn_0_13_mem_aa <= d_xIn_0_13_wraddr_q;
    d_xIn_0_13_mem_ab <= d_xIn_0_13_rdcnt_q;
    d_xIn_0_13_mem_reset0 <= areset;
    d_xIn_0_13_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 13,
        widthad_a => 1,
        numwords_a => 2,
        width_b => 13,
        widthad_b => 1,
        numwords_b => 2,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => d_xIn_0_13_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clk,
        aclr1 => d_xIn_0_13_mem_reset0,
        clock1 => clk,
        address_a => d_xIn_0_13_mem_aa,
        data_a => d_xIn_0_13_mem_ia,
        wren_a => VCC_q(0),
        address_b => d_xIn_0_13_mem_ab,
        q_b => d_xIn_0_13_mem_iq
    );
    d_xIn_0_13_mem_q <= d_xIn_0_13_mem_iq(12 downto 0);

    -- d_in0_m0_wi0_wo0_assign_id1_q_13(DELAY,38)@10 + 3
    d_in0_m0_wi0_wo0_assign_id1_q_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC" )
    PORT MAP ( xin => xIn_v, xout => d_in0_m0_wi0_wo0_assign_id1_q_13_q, clk => clk, aclr => areset );

    -- u0_m0_wo0_wi0_r0_wa0(COUNTER,21)@13
    -- low=0, high=127, step=1, init=121
    u0_m0_wo0_wi0_r0_wa0_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_wi0_r0_wa0_i <= TO_UNSIGNED(121, 7);
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_in0_m0_wi0_wo0_assign_id1_q_13_q = "1") THEN
                u0_m0_wo0_wi0_r0_wa0_i <= u0_m0_wo0_wi0_r0_wa0_i + 1;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_wi0_r0_wa0_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(u0_m0_wo0_wi0_r0_wa0_i, 7)));

    -- u0_m0_wo0_wi0_r0_memr0(DUALMEM,22)@13
    u0_m0_wo0_wi0_r0_memr0_ia <= STD_LOGIC_VECTOR(d_xIn_0_13_mem_q);
    u0_m0_wo0_wi0_r0_memr0_aa <= u0_m0_wo0_wi0_r0_wa0_q;
    u0_m0_wo0_wi0_r0_memr0_ab <= u0_m0_wo0_wi0_r0_ra0_resize_b;
    u0_m0_wo0_wi0_r0_memr0_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "M10K",
        operation_mode => "DUAL_PORT",
        width_a => 13,
        widthad_a => 7,
        numwords_a => 128,
        width_b => 13,
        widthad_b => 7,
        numwords_b => 128,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK0",
        outdata_aclr_b => "NONE",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "FALSE",
        init_file => "UNUSED",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken0 => '1',
        clock0 => clk,
        address_a => u0_m0_wo0_wi0_r0_memr0_aa,
        data_a => u0_m0_wo0_wi0_r0_memr0_ia,
        wren_a => d_in0_m0_wi0_wo0_assign_id1_q_13_q(0),
        address_b => u0_m0_wo0_wi0_r0_memr0_ab,
        q_b => u0_m0_wo0_wi0_r0_memr0_iq
    );
    u0_m0_wo0_wi0_r0_memr0_q <= u0_m0_wo0_wi0_r0_memr0_iq(12 downto 0);

    -- u0_m0_wo0_mtree_mult1_0_cma(CHAINMULTADD,36)@13 + 2
    u0_m0_wo0_mtree_mult1_0_cma_p(0) <= u0_m0_wo0_mtree_mult1_0_cma_a0(0) * u0_m0_wo0_mtree_mult1_0_cma_c0(0);
    u0_m0_wo0_mtree_mult1_0_cma_u(0) <= RESIZE(u0_m0_wo0_mtree_mult1_0_cma_p(0),25);
    u0_m0_wo0_mtree_mult1_0_cma_w(0) <= u0_m0_wo0_mtree_mult1_0_cma_u(0);
    u0_m0_wo0_mtree_mult1_0_cma_x(0) <= u0_m0_wo0_mtree_mult1_0_cma_w(0);
    u0_m0_wo0_mtree_mult1_0_cma_y(0) <= u0_m0_wo0_mtree_mult1_0_cma_x(0);
    u0_m0_wo0_mtree_mult1_0_cma_chainmultadd: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_mtree_mult1_0_cma_a0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_mult1_0_cma_c0 <= (others => (others => '0'));
            u0_m0_wo0_mtree_mult1_0_cma_s <= (others => (others => '0'));
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_mtree_mult1_0_cma_a0(0) <= RESIZE(SIGNED(u0_m0_wo0_wi0_r0_memr0_q),13);
            u0_m0_wo0_mtree_mult1_0_cma_c0(0) <= RESIZE(SIGNED(u0_m0_wo0_cm0_q),12);
            u0_m0_wo0_mtree_mult1_0_cma_s(0) <= u0_m0_wo0_mtree_mult1_0_cma_y(0);
        END IF;
    END PROCESS;
    u0_m0_wo0_mtree_mult1_0_cma_delay : dspba_delay
    GENERIC MAP ( width => 25, depth => 0, reset_kind => "ASYNC" )
    PORT MAP ( xin => STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_0_cma_s(0)(24 downto 0)), xout => u0_m0_wo0_mtree_mult1_0_cma_qq, clk => clk, aclr => areset );
    u0_m0_wo0_mtree_mult1_0_cma_q <= STD_LOGIC_VECTOR(u0_m0_wo0_mtree_mult1_0_cma_qq(24 downto 0));

    -- u0_m0_wo0_accum(ADD,27)@15 + 1
    u0_m0_wo0_accum_a <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((31 downto 25 => u0_m0_wo0_mtree_mult1_0_cma_q(24)) & u0_m0_wo0_mtree_mult1_0_cma_q));
    u0_m0_wo0_accum_b <= STD_LOGIC_VECTOR(u0_m0_wo0_accum_q);
    u0_m0_wo0_accum_i <= u0_m0_wo0_accum_a;
    u0_m0_wo0_accum_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_accum_o <= (others => '0');
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_15_q = "1") THEN
                IF (u0_m0_wo0_aseq_q = "1") THEN
                    u0_m0_wo0_accum_o <= u0_m0_wo0_accum_i;
                ELSE
                    u0_m0_wo0_accum_o <= STD_LOGIC_VECTOR(SIGNED(u0_m0_wo0_accum_a) + SIGNED(u0_m0_wo0_accum_b));
                END IF;
            END IF;
        END IF;
    END PROCESS;
    u0_m0_wo0_accum_q <= u0_m0_wo0_accum_o(31 downto 0);

    -- GND(CONSTANT,0)@0
    GND_q <= "0";

    -- u0_m0_wo0_oseq(SEQUENCE,28)@14 + 1
    u0_m0_wo0_oseq_clkproc: PROCESS (clk, areset)
        variable u0_m0_wo0_oseq_c : SIGNED(8 downto 0);
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_c := "001111100";
            u0_m0_wo0_oseq_q <= "0";
            u0_m0_wo0_oseq_eq <= '0';
        ELSIF (clk'EVENT AND clk = '1') THEN
            IF (d_u0_m0_wo0_compute_q_14_q = "1") THEN
                IF (u0_m0_wo0_oseq_c = "000000000") THEN
                    u0_m0_wo0_oseq_eq <= '1';
                ELSE
                    u0_m0_wo0_oseq_eq <= '0';
                END IF;
                IF (u0_m0_wo0_oseq_eq = '1') THEN
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c + 124;
                ELSE
                    u0_m0_wo0_oseq_c := u0_m0_wo0_oseq_c - 1;
                END IF;
                u0_m0_wo0_oseq_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_c(8 downto 8));
            END IF;
        END IF;
    END PROCESS;

    -- u0_m0_wo0_oseq_gated(LOGICAL,29)@15
    u0_m0_wo0_oseq_gated_a <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_q);
    u0_m0_wo0_oseq_gated_b <= STD_LOGIC_VECTOR(d_u0_m0_wo0_compute_q_15_q);
    u0_m0_wo0_oseq_gated_q <= u0_m0_wo0_oseq_gated_a and u0_m0_wo0_oseq_gated_b;

    -- u0_m0_wo0_oseq_gated_reg(REG,30)@15 + 1
    u0_m0_wo0_oseq_gated_reg_clkproc: PROCESS (clk, areset)
    BEGIN
        IF (areset = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= "0";
        ELSIF (clk'EVENT AND clk = '1') THEN
            u0_m0_wo0_oseq_gated_reg_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_q);
        END IF;
    END PROCESS;

    -- out0_m0_wo0_lineup_select_delay_0(DELAY,32)@16
    out0_m0_wo0_lineup_select_delay_0_q <= STD_LOGIC_VECTOR(u0_m0_wo0_oseq_gated_reg_q);

    -- out0_m0_wo0_assign_id3(DELAY,34)@16
    out0_m0_wo0_assign_id3_q <= STD_LOGIC_VECTOR(out0_m0_wo0_lineup_select_delay_0_q);

    -- xOut(PORTOUT,35)@16 + 1
    xOut_v <= out0_m0_wo0_assign_id3_q;
    xOut_c <= STD_LOGIC_VECTOR("0000000" & GND_q);
    xOut_0 <= u0_m0_wo0_accum_q;

END normal;
