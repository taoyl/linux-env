" Vim syntax file
" Language:     SDC - Design Constraints Format - v2.0
" Maintainer:   gaofeng.dong@gmail.com
" Last Change:  Thu Jun  2 13:53:05 IST 2016
" Credits:      based on TCL Vim syntax file
" Version:      1.0

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Read the TCL syntax to start with
runtime! syntax/tcl.vim

" SDC-specific keywords
"Operating conditions
syn keyword sdcCollections set_operating_conditions
"Wire load models
syn keyword sdcCollections set_wire_load_min_block_size
syn keyword sdcCollections set_wire_load_mode
syn keyword sdcCollections set_wire_load_model
syn keyword sdcCollections set_wire_load_selection_group
"System interface
syn keyword sdcCollections set_drive
syn keyword sdcCollections set_driving_cell
syn keyword sdcCollections set_fanout_load
syn keyword sdcCollections set_input_transition
syn keyword sdcCollections set_load
syn keyword sdcCollections set_port_fanout_number
"Design rule constraints
syn keyword sdcCollections set_max_capacitance
syn keyword sdcCollections set_min_capacitance
syn keyword sdcCollections set_max_fanout
syn keyword sdcCollections set_max_transition
"Timing constraints
syn keyword sdcCollections create_clock
syn keyword sdcCollections create_generated_clock
syn keyword sdcCollections group_path
syn keyword sdcCollections set_clock_gating_check
syn keyword sdcCollections set_clock_groups
syn keyword sdcCollections set_clock_latency
syn keyword sdcCollections set_clock_sense
syn keyword sdcCollections set_clock_transition
syn keyword sdcCollections set_clock_uncertainty
syn keyword sdcCollections set_data_check
syn keyword sdcCollections set_disable_timing
syn keyword sdcCollections set_ideal_latency
syn keyword sdcCollections set_ideal_network
syn keyword sdcCollections set_ideal_transition
syn keyword sdcCollections set_input_delay
syn keyword sdcCollections set_max_time_borrow
syn keyword sdcCollections set_min_pulse_width
syn keyword sdcCollections set_output_delay
syn keyword sdcCollections set_propagated_clock
syn keyword sdcCollections set_resistance
syn keyword sdcCollections set_timing_derate
"Timing exceptions
syn keyword sdcCollections set_false_path
syn keyword sdcCollections set_max_delay
syn keyword sdcCollections set_min_delay
syn keyword sdcCollections set_multicycle_path
"Area constraints
syn keyword sdcCollections set_max_area
"Multivoltage and power optimization constraints
syn keyword sdcCollections create_voltage_area
syn keyword sdcCollections set_level_shifter_strategy
syn keyword sdcCollections set_level_shifter_threshold
syn keyword sdcCollections set_max_dynamic_power
syn keyword sdcCollections set_max_leakage_power
"Logic assignments
syn keyword sdcCollections set_case_analysis
syn keyword sdcCollections set_logic_dc
syn keyword sdcCollections set_logic_one
syn keyword sdcCollections set_logic_zero

"SDC Design Objects
syn keyword sdcobjCollections current_design 
syn keyword sdcobjCollections get_clocks all_clocks get_ports
syn keyword sdcobjCollections all_inputs all_outputs
syn keyword sdcobjCollections get_cells
syn keyword sdcobjCollections get_pins
syn keyword sdcobjCollections get_nets
syn keyword sdcobjCollections get_libs
syn keyword sdcobjCollections get_lib_cells
syn keyword sdcobjCollections get_lib_pins
syn keyword sdcobjCollections all_registers

" command flags highlighting
syn match sdcFlags "[[:space:]]-[[:alpha:]_]*\>"
syn match sdcFlags "\<exists\>"

" Define the default highlighting.
"hi def link sdcObjectsInfo      Operator
hi def link sdcCollections      Repeat
hi def link sdcObjCollections   Operator
hi def link sdcFlags            Special

let b:current_syntax = "sdc"

