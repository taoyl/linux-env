" Vim syntax file
" Language:     UPF - Unified Power Format - 1801-2013@v2.1
" Maintainer:   gaofeng.dong@gmail.com
" Last Change:  Tue Jul 12 11:15:16 IST 2016
" Credits:      based on TCL Vim syntax file
" Version:      1.1

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Read the TCL syntax to start with
runtime! syntax/tcl.vim

" UPF-specific keywords
"Power intent commands
syn keyword upfCollections add_power_state 
syn keyword upfCollections apply_power_model
syn keyword upfCollections associate_supply_set 
syn keyword upfCollections begin_power_model 
syn keyword upfCollections bind_checker 
syn keyword upfCollections connect_logic_net 
syn keyword upfCollections connect_supply_net 
syn keyword upfCollections connect_supply_set 
syn keyword upfCollections create_composite_domain 
syn keyword upfCollections create_hdl2upf_vct 
syn keyword upfCollections create_logic_net 
syn keyword upfCollections create_logic_port 
syn keyword upfCollections create_power_domain 
syn keyword upfCollections create_power_switch 
syn keyword upfCollections create_supply_net 
syn keyword upfCollections create_supply_port 
syn keyword upfCollections create_supply_set 
syn keyword upfCollections create_upf2hdl_vct 
syn keyword upfCollections describe_state_transition 
syn keyword upfCollections end_power_model
syn keyword upfCollections find_objects 
syn keyword upfCollections load_simstate_behavior 
syn keyword upfCollections load_upf 
syn keyword upfCollections load_upf_protected 
syn keyword upfCollections map_power_switch 
syn keyword upfCollections map_retention_cell 
syn keyword upfCollections name_format 
syn keyword upfCollections save_upf 
syn keyword upfCollections set_design_attributes 
syn keyword upfCollections set_design_top 
syn keyword upfCollections set_equivalent 
syn keyword upfCollections set_isolation 
syn keyword upfCollections set_level_shifter 
syn keyword upfCollections set_partial_on_translation 
syn keyword upfCollections set_port_attributes 
syn keyword upfCollections set_repeater 
syn keyword upfCollections set_retention 
syn keyword upfCollections set_retention_elements 
syn keyword upfCollections set_scope 
syn keyword upfCollections set_simstate_behavior 
syn keyword upfCollections upf_version 
syn keyword upfCollections use_interface_cell 
"Power management cell commands
syn keyword upfCollections define_always_on_cell
syn keyword upfCollections define_diode_clamp
syn keyword upfCollections define_isolation_cell
syn keyword upfCollections define_level_shifter_cell
syn keyword upfCollections define_power_switch_cell 
syn keyword upfCollections define_retention_cell 
"legacy commands
syn keyword upfCollections1 add_port_state
syn keyword upfCollections1 add_pst_state
syn keyword upfCollections1 create_pst
syn keyword upfCollections1 set_domain_supply_net
"deprecated commands
syn keyword upfCollections1 add_domain_elements
syn keyword upfCollections1 map_isolation_cell
syn keyword upfCollections1 map_level_shifter_cell
syn keyword upfCollections1 merge_power_domains
syn keyword upfCollections1 set_isolation_control
syn keyword upfCollections1 set_pin_related_supply
syn keyword upfCollections1 set_power_switch
syn keyword upfCollections1 set_retention_control
"a) Domain record field space
syn keyword upfreserved primary default_retention default_isolation
"b) Switch record field space
syn keyword upfreserved supply
"c) Level-shifter strategy record field name space
syn keyword upfreserved input_supply_set output_supply_set internal_supply_set
"d) Isolation strategy record field name space
syn keyword upfreserved isolation_supply_set isolation_signal
"e) Retention strategy record field name space (see 6.33)
syn keyword upfreserved retention_ref retention_supply_set primary_ref primary_supply_set save_signal restore_signal
syn keyword upfreserved UPF_GENERIC_CLOCK UPF_GENERIC_DATA UPF_GENERIC_ASYNC_LOAD UPF_GENERIC_OUTPUT
"When -function is specified, func_name shall be one of the following:
syn keyword upfreserved power ground nwell pwell deepnwell deeppwell
"-simstate specifies a simstate for the power states associated with a supply set. Valid values are
syn keyword upfreserved NORMAL CORRUPT_ON_CHANGE CORRUPT_STATE_ON_CHANGE CORRUPT_STATE_ON_ACTIVITY CORRUPT_ON_ACTIVITY CORRUPT NOT_NORMAL
"The supply state value may be 
syn keyword upfreserved OFF UNDETERMINED PARTIAL_ON FULL_ON
"The supply_set_handle may be a predefined supply set handle. The predefined supply set handles are as follows:
syn keyword upfreserved primary default_retention default_isolation supply isolation_supply_set input output
"[-location <self | other | parent | automatic | fanout | fanin | faninout | sibling>]; fanin | faninout | sibling are deprecated
syn keyword upfreserved self other parent fanout automatic
"[-rule <low_to_high | high_to_low | both>]
syn keyword upfreserved low_to_high high_to_low both
"-applies_to <inputs | outputs | both>
syn keyword upfreserved outputs inputs
"-use_equivalence [<TRUE | FALSE>]
syn keyword upfreserved TRUE FALSE
"[-isolation_signal signal_list [-isolation_sense {<high | low>*}]]
syn keyword upfreserved high low
"[-clamp_value {< 0 | 1 | any | Z | latch | value>*}
syn keyword upfreserved Z latch
"[-save_signal {logic_net <high | low | posedge | negedge>}
syn keyword upfreserved posedge negedge

" command flags highlighting
syn match upfFlags "[[:space:]]-[[:alpha:]_]*\>"
syn match cpfFlags "^-[[:alpha:]_]*\>"
syn match upfFlags "\<exists\>"

" Define the default highlighting.
"hi def link upfObjectsInfo      Operator
hi def link upfCollections      Repeat
hi def link upfCollections1     Comment
hi def link upfreserved         Repeat
hi def link upfFlags            Special

let b:current_syntax = "upf"

