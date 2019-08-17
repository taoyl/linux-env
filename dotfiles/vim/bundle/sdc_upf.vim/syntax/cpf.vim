" Vim syntax file
" Language:     CPF - Common Power Format 2.0, Aug 2013
" Maintainer:   gaofeng.dong@gmail.com
" Last Change:  Mon Nov 14 10:49:53 CST 2011
" Credits:      based on TCL Vim syntax file
" Version:      1.0

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Read the TCL syntax to start with
runtime! syntax/tcl.vim

" CPF-specific keywords
"version command
syn keyword cpfCollections set_cpf_version
"hierarchical support commands
syn keyword cpfCollections set_design
syn keyword cpfCollections set_instance
syn keyword cpfCollections end_design
syn keyword cpfCollections get_parameter
"macro support
syn keyword cpfCollections set_macro_model
syn keyword cpfCollections end_macro_model
syn keyword cpfCollections set_floating_ports
syn keyword cpfCollections set_input_voltage_tolerance
syn keyword cpfCollections set_wire_feedthrough_ports
"general purpose commands
syn keyword cpfCollections include
syn keyword cpfCollections set_array_naming_style
syn keyword cpfCollections set_hierarchy_separator
syn keyword cpfCollections set_power_unit
syn keyword cpfCollections set_register_naming_style
syn keyword cpfCollections set_time_unit
"verification support commands
syn keyword cpfCollections assert_illegal_domain_configurations
syn keyword cpfCollections create_assertion_control
"power mode commands
syn keyword cpfCollections set_power_mode_control_group
syn keyword cpfCollections end_power_mode_control_group
syn keyword cpfCollections create_power_mode
syn keyword cpfCollections create_mode_transition
syn keyword cpfCollections update_power_mode
"design and constraints
syn keyword cpfCollections create_analysis_view
syn keyword cpfCollections create_bias_net
syn keyword cpfCollections create_global_connection
syn keyword cpfCollections create_ground_nets
syn keyword cpfCollections create_isolation_rule
syn keyword cpfCollections create_level_shifter_rule
syn keyword cpfCollections create_nominal_condition
syn keyword cpfCollections create_operating_corner
syn keyword cpfCollections create_power_domain
syn keyword cpfCollections create_power_nets
syn keyword cpfCollections create_power_switch_rule
syn keyword cpfCollections create_state_retention_rule
syn keyword cpfCollections define_library_set
syn keyword cpfCollections identify_always_on_driver
syn keyword cpfCollections identify_power_logic
syn keyword cpfCollections identify_secondary_domain
syn keyword cpfCollections set_equivalent_control_pins
syn keyword cpfCollections set_power_target
syn keyword cpfCollections set_switching_activity
syn keyword cpfCollections update_isolation_rules
syn keyword cpfCollections update_level_shifter_rules
syn keyword cpfCollections update_nominal_condition
syn keyword cpfCollections update_power_domain
syn keyword cpfCollections update_power_switch_rule
syn keyword cpfCollections update_state_retention_rules

"library-related commands
syn keyword cpfCollections define_always_on_cell
syn keyword cpfCollections define_isolation_cell
syn keyword cpfCollections define_level_shifter_cell
syn keyword cpfCollections define_open_source_input_pin
syn keyword cpfCollections define_power_clamp_cell
syn keyword cpfCollections define_power_switch_cell
syn keyword cpfCollections define_related_power_pins
syn keyword cpfCollections define_state_retention_cell

"set_power_unit pW nW uW mW W
syn keyword cpfCollections pW nW uW mW W
"set_time_unit ns us ms
syn keyword cpfCollections ns us ms
"-object inst port pin net
syn keyword cpfCollections inst port pin net
"-pattern_type name cell module
syn keyword cpfCollections name cell module
"-no_enable high low hold
syn keyword cpfCollections high low hold
"-location from to parent any
"-valid_location from to on off any
"-valid_location to from either any
syn keyword cpfCollections from to parent any
"-isolation_output low high hold tristate clamp_high clamp_low
syn keyword cpfCollections low high hold tristate clamp_high clamp_low
"-isolation_target from to
syn keyword cpfCollections from to
"-action disable_corruption disable_isolation disable_retention power_up_replay
syn keyword cpfCollections disable_corruption disable_isolation disable_retention power_up_replay
"-direction in out inout
"-direction up down bidir
syn keyword cpfCollections in out inout up down bidir
"-pin_groups input_pin output_pin enable_pin
syn keyword cpfCollections input_pin output_pin enable_pin
"-power_down_states low high random inverted
"-power_off_function pullup pulldown hold
"-power_up_states random high low inverted
syn keyword cpfCollections low high random inverted pullup pulldown hold
"-state on off standby
"-target_type flop latch both
syn keyword cpfCollections on off standby flop latch both
"-type nmos pmos both
"-type footer header
syn keyword cpfCollections nmos pmos both footer header
"-type real wreal integer reg module instance
syn keyword cpfCollections real wreal integer reg module instance
"-type reset suspend
syn keyword cpfCollections reset suspend
"-type both
"-type ground
"-type isolation
"-type power
syn keyword cpfCollections both ground isolation power

"all argments
syn keyword cpfCollections acknowledge_receiver_1
syn keyword cpfCollections acknowledge_receiver_2
syn keyword cpfCollections action
syn keyword cpfCollections active_state_conditions
syn keyword cpfCollections activity_file
syn keyword cpfCollections activity_file_weight
syn keyword cpfCollections all
syn keyword cpfCollections always_on_components
syn keyword cpfCollections always_on_pins
syn keyword cpfCollections analog_pins
syn keyword cpfCollections assertions
syn keyword cpfCollections aux_enables
syn keyword cpfCollections average_ir_drop_limit
syn keyword cpfCollections base_domains
syn keyword cpfCollections boundary_ports
syn keyword cpfCollections bypass_condition
syn keyword cpfCollections bypass_enable
syn keyword cpfCollections cell_list
syn keyword cpfCollections cell_type
syn keyword cpfCollections cells
syn keyword cpfCollections clamp
syn keyword cpfCollections clock_pin
syn keyword cpfCollections clock_pins
syn keyword cpfCollections condition
syn keyword cpfCollections controlling_domain
syn keyword cpfCollections cycles
syn keyword cpfCollections data
syn keyword cpfCollections data_pins
syn keyword cpfCollections deep_nwell_net
syn keyword cpfCollections deep_nwell_voltage
syn keyword cpfCollections deep_pwell_net
syn keyword cpfCollections deep_pwell_voltage
syn keyword cpfCollections default
syn keyword cpfCollections default_isolation_condition
syn keyword cpfCollections default_restore_edge
syn keyword cpfCollections default_restore_level
syn keyword cpfCollections default_save_edge
syn keyword cpfCollections default_save_level
syn keyword cpfCollections design
syn keyword cpfCollections direction
syn keyword cpfCollections domain
syn keyword cpfCollections domain_conditions
syn keyword cpfCollections domain_corners
syn keyword cpfCollections domain_mapping
syn keyword cpfCollections domains
syn keyword cpfCollections driver
syn keyword cpfCollections dynamic
syn keyword cpfCollections dynamic_power_limit
syn keyword cpfCollections enable
syn keyword cpfCollections enable_condition_1
syn keyword cpfCollections enable_condition_2
syn keyword cpfCollections enable_pin_bias
syn keyword cpfCollections end_condition
syn keyword cpfCollections equivalent_ground_nets
syn keyword cpfCollections equivalent_power_nets
syn keyword cpfCollections exact
syn keyword cpfCollections exclude
syn keyword cpfCollections exclude_instances
syn keyword cpfCollections exclude_ports
syn keyword cpfCollections external_controlled_shutoff
syn keyword cpfCollections external_ground_net
syn keyword cpfCollections external_power_net
syn keyword cpfCollections external_shutoff_condition
syn keyword cpfCollections force
syn keyword cpfCollections from
syn keyword cpfCollections gate_bias_net
syn keyword cpfCollections gate_bias_pin
syn keyword cpfCollections global_ground
syn keyword cpfCollections global_power
syn keyword cpfCollections ground
syn keyword cpfCollections ground_input_voltage_range
syn keyword cpfCollections ground_output_voltage_range
syn keyword cpfCollections ground_switchable
syn keyword cpfCollections ground_voltage
syn keyword cpfCollections group_modes
syn keyword cpfCollections group_views
syn keyword cpfCollections groups
syn keyword cpfCollections hierarchical
syn keyword cpfCollections hold_sdc_files
syn keyword cpfCollections honor_boundary_port_domain
syn keyword cpfCollections ignore_case
syn keyword cpfCollections illegal
syn keyword cpfCollections inout_ports
syn keyword cpfCollections input_domain
syn keyword cpfCollections input_ground_pin
syn keyword cpfCollections input_ports
syn keyword cpfCollections input_power_pin
syn keyword cpfCollections input_voltage_range
syn keyword cpfCollections instances
syn keyword cpfCollections internal
syn keyword cpfCollections isolated_pins
syn keyword cpfCollections isolation_condition
syn keyword cpfCollections isolation_control
syn keyword cpfCollections isolation_output
syn keyword cpfCollections isolation_target
syn keyword cpfCollections latency
syn keyword cpfCollections leaf_only
syn keyword cpfCollections leakage
syn keyword cpfCollections leakage_current
syn keyword cpfCollections leakage_power_limit
syn keyword cpfCollections lib_cells
syn keyword cpfCollections libraries
syn keyword cpfCollections library_set
syn keyword cpfCollections local_ground
syn keyword cpfCollections local_power
syn keyword cpfCollections location
syn keyword cpfCollections mapping
syn keyword cpfCollections master
syn keyword cpfCollections mode
syn keyword cpfCollections model
syn keyword cpfCollections module
syn keyword cpfCollections modules
syn keyword cpfCollections multi_stage
syn keyword cpfCollections name
syn keyword cpfCollections names
syn keyword cpfCollections negative
syn keyword cpfCollections net
syn keyword cpfCollections nets
syn keyword cpfCollections nmos_bias_net
syn keyword cpfCollections nmos_bias_voltage
syn keyword cpfCollections no_condition
syn keyword cpfCollections no_enable
syn keyword cpfCollections no_propagation
syn keyword cpfCollections non_dedicated
syn keyword cpfCollections non_leaf_only
syn keyword cpfCollections object
syn keyword cpfCollections of_bond_ports
syn keyword cpfCollections open_source_pins_only ...
syn keyword cpfCollections output_domain
syn keyword cpfCollections output_ground_pin
syn keyword cpfCollections output_ports
syn keyword cpfCollections output_power_pin
syn keyword cpfCollections output_voltage_range
syn keyword cpfCollections pad_pins
syn keyword cpfCollections parameter_mapping
syn keyword cpfCollections parameters
syn keyword cpfCollections pattern_type
syn keyword cpfCollections peak_ir_drop_limit
syn keyword cpfCollections pg_type
syn keyword cpfCollections pin
syn keyword cpfCollections pin_groups
syn keyword cpfCollections pin_mapping
syn keyword cpfCollections pins
syn keyword cpfCollections pmos_bias_net
syn keyword cpfCollections pmos_bias_voltage
syn keyword cpfCollections port_mapping
syn keyword cpfCollections ports
syn keyword cpfCollections positive
syn keyword cpfCollections power
syn keyword cpfCollections power_down_states
syn keyword cpfCollections power_library_set
syn keyword cpfCollections power_off_function
syn keyword cpfCollections power_source
syn keyword cpfCollections power_switchable
syn keyword cpfCollections power_up_states
syn keyword cpfCollections prefix
syn keyword cpfCollections primary_ground_net
syn keyword cpfCollections primary_power_net
syn keyword cpfCollections probability
syn keyword cpfCollections process
syn keyword cpfCollections regexp
syn keyword cpfCollections required
syn keyword cpfCollections restore_check
syn keyword cpfCollections restore_edge
syn keyword cpfCollections restore_function
syn keyword cpfCollections restore_level
syn keyword cpfCollections restore_precondition
syn keyword cpfCollections retention_check
syn keyword cpfCollections retention_precondition
syn keyword cpfCollections rules
syn keyword cpfCollections save_check
syn keyword cpfCollections save_edge
syn keyword cpfCollections save_function
syn keyword cpfCollections save_level
syn keyword cpfCollections save_precondition
syn keyword cpfCollections scope
syn keyword cpfCollections sdc_files
syn keyword cpfCollections secondary_domain
syn keyword cpfCollections set_reset_control
syn keyword cpfCollections setup_sdc_files
syn keyword cpfCollections shutoff_condition
syn keyword cpfCollections stage_1_enable
syn keyword cpfCollections stage_1_on_resistance
syn keyword cpfCollections stage_1_output
syn keyword cpfCollections stage_1_saturation_current
syn keyword cpfCollections stage_2_enable
syn keyword cpfCollections stage_2_on_resistance
syn keyword cpfCollections stage_2_output
syn keyword cpfCollections stage_2_saturation_current
syn keyword cpfCollections start_condition
syn keyword cpfCollections state
syn keyword cpfCollections suffix
syn keyword cpfCollections target_type
syn keyword cpfCollections targets
syn keyword cpfCollections temperature
syn keyword cpfCollections testbench
syn keyword cpfCollections through
syn keyword cpfCollections to
syn keyword cpfCollections toggle_percentage
syn keyword cpfCollections toggle_rate
syn keyword cpfCollections transition_cycles
syn keyword cpfCollections transition_latency
syn keyword cpfCollections transition_slope
syn keyword cpfCollections type
syn keyword cpfCollections use_model
syn keyword cpfCollections use_secondary_for_output
syn keyword cpfCollections user_attributes
syn keyword cpfCollections valid_location
syn keyword cpfCollections voltage
syn keyword cpfCollections voltage_range
syn keyword cpfCollections within_hierarchy

"new keyword in CPF2.0
syn keyword cpfCollections set_sim_control
syn keyword cpfCollections create_mode
syn keyword cpfCollections create_pad_rule
syn keyword cpfCollections define_global_cell
syn keyword cpfCollections define_pad_cell
syn keyword cpfCollections define_power_clamp_pins
syn keyword cpfCollections find_design_objects
syn keyword cpfCollections power_design
syn keyword cpfCollections set_analog_ports port_list
syn keyword cpfCollections set_diode_ports
syn keyword cpfCollections set_pad_ports pin_list
syn keyword cpfCollections set_power_source_reference_pin pin
syn keyword cpfCollections update_design

" command flags highlighting
"syn match cpfFlags "[[:space:]]-[[:alpha:]_]*\>"
"syn match cpfFlags "^-[[:alpha:]_]*\>"
"syn match cpfFlags "\<exists\>"

" Define the default highlighting.
"hi def link cpfObjectsInfo      Operator
hi def link cpfCollections      Repeat
hi def link cpfFlags            Special

let b:current_syntax = "cpf"

