## This file is a general .xdc for the Basys3 rev B board
## XDC constraints for Trigonometric Calculator with Seven-Segment Display

## Clock signal (100MHz)
set_property PACKAGE_PIN W5 [get_ports clk]							
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
## Switches - for angle_deg input (9 switches: SW0-SW8)
set_property PACKAGE_PIN V17 [get_ports {angle_deg[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {angle_deg[0]}]
set_property PACKAGE_PIN V16 [get_ports {angle_deg[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {angle_deg[1]}]
set_property PACKAGE_PIN W16 [get_ports {angle_deg[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {angle_deg[2]}]
set_property PACKAGE_PIN W17 [get_ports {angle_deg[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {angle_deg[3]}]
set_property PACKAGE_PIN W15 [get_ports {angle_deg[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {angle_deg[4]}]
set_property PACKAGE_PIN V15 [get_ports {angle_deg[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {angle_deg[5]}]
set_property PACKAGE_PIN W14 [get_ports {angle_deg[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {angle_deg[6]}]
set_property PACKAGE_PIN W13 [get_ports {angle_deg[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {angle_deg[7]}]
set_property PACKAGE_PIN V2 [get_ports {angle_deg[8]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {angle_deg[8]}]

## LEDs - Show switch status (LED0-LED8 correspond to SW0-SW8)
set_property PACKAGE_PIN U16 [get_ports {led[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN E19 [get_ports {led[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[1]}]
set_property PACKAGE_PIN U19 [get_ports {led[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[2]}]
set_property PACKAGE_PIN V19 [get_ports {led[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[3]}]
set_property PACKAGE_PIN W18 [get_ports {led[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[4]}]
set_property PACKAGE_PIN U15 [get_ports {led[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[5]}]
set_property PACKAGE_PIN U14 [get_ports {led[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[6]}]
set_property PACKAGE_PIN V14 [get_ports {led[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[7]}]
set_property PACKAGE_PIN V13 [get_ports {led[8]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[8]}]
set_property PACKAGE_PIN V3 [get_ports {led[9]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[9]}]
set_property PACKAGE_PIN W3 [get_ports {led[10]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[10]}]
set_property PACKAGE_PIN U3 [get_ports {led[11]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[11]}]
set_property PACKAGE_PIN P3 [get_ports {led[12]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[12]}]
set_property PACKAGE_PIN N3 [get_ports {led[13]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[13]}]
set_property PACKAGE_PIN P1 [get_ports {led[14]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[14]}]
set_property PACKAGE_PIN L1 [get_ports {led[15]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {led[15]}]

## Buttons (Center button not used)
set_property PACKAGE_PIN U18 [get_ports BTND]						
set_property IOSTANDARD LVCMOS33 [get_ports BTND]
set_property PACKAGE_PIN T18 [get_ports BTNU]						
set_property IOSTANDARD LVCMOS33 [get_ports BTNU]
set_property PACKAGE_PIN W19 [get_ports BTNL]						
set_property IOSTANDARD LVCMOS33 [get_ports BTNL]
set_property PACKAGE_PIN T17 [get_ports BTNR]						
set_property IOSTANDARD LVCMOS33 [get_ports BTNR]

## 7-Segment Display Cathodes (segments a-g)
set_property PACKAGE_PIN W7 [get_ports {seg[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {seg[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {seg[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {seg[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {seg[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {seg[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {seg[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

## Decimal Point
set_property PACKAGE_PIN V7 [get_ports dp]							
set_property IOSTANDARD LVCMOS33 [get_ports dp]

## 7-Segment Display Anodes (Basys3 has 4 anodes: AN0-AN3)
set_property PACKAGE_PIN U2 [get_ports {an[0]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]
set_property PACKAGE_PIN V4 [get_ports {an[2]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]
set_property PACKAGE_PIN W4 [get_ports {an[3]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]

## Unused anodes - tie off to avoid undriven warnings
set_property PACKAGE_PIN V3 [get_ports {an[4]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an[4]}]
set_property PACKAGE_PIN W3 [get_ports {an[5]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an[5]}]
set_property PACKAGE_PIN U3 [get_ports {an[6]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an[6]}]
set_property PACKAGE_PIN P3 [get_ports {an[7]}]					
set_property IOSTANDARD LVCMOS33 [get_ports {an[7]}]

## Configuration options
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## ============================================================
## TIMING CONSTRAINTS FOR SYNCHRONIZATION
## ============================================================

## Primary clock constraint (already defined above)
## 100 MHz clock = 10ns period

## Input delay constraints for switches (asynchronous inputs)
## Assume switches settle within 5ns after clock edge
set_input_delay -clock [get_clocks sys_clk_pin] -min 0.0 [get_ports {angle_deg[*]}]
set_input_delay -clock [get_clocks sys_clk_pin] -max 5.0 [get_ports {angle_deg[*]}]

## Input delay constraints for buttons (asynchronous inputs)
## Buttons are debounced, so less critical but still constrained
set_input_delay -clock [get_clocks sys_clk_pin] -min 0.0 [get_ports BTNU]
set_input_delay -clock [get_clocks sys_clk_pin] -max 5.0 [get_ports BTNU]
set_input_delay -clock [get_clocks sys_clk_pin] -min 0.0 [get_ports BTNL]
set_input_delay -clock [get_clocks sys_clk_pin] -max 5.0 [get_ports BTNL]
set_input_delay -clock [get_clocks sys_clk_pin] -min 0.0 [get_ports BTNR]
set_input_delay -clock [get_clocks sys_clk_pin] -max 5.0 [get_ports BTNR]
set_input_delay -clock [get_clocks sys_clk_pin] -min 0.0 [get_ports BTND]
set_input_delay -clock [get_clocks sys_clk_pin] -max 5.0 [get_ports BTND]

## Output delay constraints for seven-segment display
## Seven-segment displays are slow devices, so generous timing
set_output_delay -clock [get_clocks sys_clk_pin] -min -2.0 [get_ports {seg[*]}]
set_output_delay -clock [get_clocks sys_clk_pin] -max 8.0 [get_ports {seg[*]}]
set_output_delay -clock [get_clocks sys_clk_pin] -min -2.0 [get_ports {an[*]}]
set_output_delay -clock [get_clocks sys_clk_pin] -max 8.0 [get_ports {an[*]}]
set_output_delay -clock [get_clocks sys_clk_pin] -min -2.0 [get_ports dp]
set_output_delay -clock [get_clocks sys_clk_pin] -max 8.0 [get_ports dp]

## Output delay constraints for LEDs
set_output_delay -clock [get_clocks sys_clk_pin] -min -2.0 [get_ports {led[*]}]
set_output_delay -clock [get_clocks sys_clk_pin] -max 8.0 [get_ports {led[*]}]

## False path constraints for asynchronous button inputs
## Buttons go through debouncer, so initial press timing not critical
set_false_path -from [get_ports BTNU] -to [all_registers]
set_false_path -from [get_ports BTNL] -to [all_registers]
set_false_path -from [get_ports BTNR] -to [all_registers]
set_false_path -from [get_ports BTND] -to [all_registers]

## Maximum delay constraint for combinational logic in triRatio module
## Ensure calculation completes within reasonable time
set_max_delay 50.0 -from [get_ports {angle_deg[]}] -to [get_ports {seg[]}]
set_max_delay 50.0 -from [get_ports {angle_deg[]}] -to [get_ports {an[]}]

## Multi-cycle path for complex calculations
## Taylor series calculations may need multiple cycles
set_multicycle_path -setup 5 -from [get_pins {trig_calc/x_rad_reg[]/C}] -to [get_pins {trig_calc/sin_val_reg[]/D}]
set_multicycle_path -hold 4 -from [get_pins {trig_calc/x_rad_reg[]/C}] -to [get_pins {trig_calc/sin_val_reg[]/D}]
set_multicycle_path -setup 5 -from [get_pins {trig_calc/x_rad_reg[]/C}] -to [get_pins {trig_calc/cos_val_reg[]/D}]
set_multicycle_path -hold 4 -from [get_pins {trig_calc/x_rad_reg[]/C}] -to [get_pins {trig_calc/cos_val_reg[]/D}]

## Clock domain crossing constraints
## Mark button debouncer outputs as asynchronous
set_false_path -from [get_pins {db_u/btn_state_reg/C}] -to [all_registers]
set_false_path -from [get_pins {db_l/btn_state_reg/C}] -to [all_registers]
set_false_path -from [get_pins {db_r/btn_state_reg/C}] -to [all_registers]
set_false_path -from [get_pins {db_d/btn_state_reg/C}] -to [all_registers]

## Ignore timing on unused anode outputs
set_false_path -to [get_ports {an[4]}]
set_false_path -to [get_ports {an[5]}]
set_false_path -to [get_ports {an[6]}]
set_false_path -to [get_ports {an[7]}]

## Maximum fanout constraint to improve timing
set_max_fanout 20 [current_design]

## Case analysis for unused signals (helps optimization)
set_case_analysis 1 [get_ports {an[4]}]
set_case_analysis 1 [get_ports {an[5]}]
set_case_analysis 1 [get_ports {an[6]}]
set_case_analysis 1 [get_ports {an[7]}]