package shift_reg_mon_pkg ; 


import uvm_pkg::*;
`include "uvm_macros.svh"

import shift_reg_seq_item_pkg::*; 
import shared_pkg::*; 
class shift_reg_mon extends uvm_monitor ;
    `uvm_component_utils(shift_reg_mon) ; 
    
    virtual shift_reg_if shift_reg_m_v_if ; 
    
    shift_reg_seq_item mon_shift_reg_item ; 

    uvm_analysis_port #(shift_reg_seq_item) mon_ana_port  ; 

    function new(string name = "shift_reg_mon" , uvm_component parent = null) ; 
        super.new(name , parent) ; 
    endfunction
    
    function void build_phase(uvm_phase phase ) ; 
        super.build_phase(phase) ;
        mon_ana_port = new("mon_ana_port" , this ) ; 
    endfunction
    
    task run_phase (uvm_phase phase) ; 
        
        super.run_phase(phase) ; 
        
        forever begin 
            mon_shift_reg_item = shift_reg_seq_item::type_id::create("mon_shift_reg_item" , this ) ; 
            
            @(negedge shift_reg_m_v_if.clk) 
            
            mon_shift_reg_item.reset     = shift_reg_m_v_if.reset ; 
            
            mon_shift_reg_item.serial_in = shift_reg_m_v_if.serial_in ; 
            
            //*
            mon_shift_reg_item.direction = direction_e'(shift_reg_m_v_if.direction) ; 
            
            //*
            mon_shift_reg_item.mode      = mode_e'(shift_reg_m_v_if.mode) ; 
            
            mon_shift_reg_item.datain    = shift_reg_m_v_if.datain ; 
            
            mon_shift_reg_item.dataout   = shift_reg_m_v_if.dataout ;
            
            mon_ana_port.write(mon_shift_reg_item) ; 
            
            `uvm_info("mon_run_phase" , mon_shift_reg_item.convert2string() , UVM_HIGH ) ; 
        end
    endtask
endclass
endpackage 