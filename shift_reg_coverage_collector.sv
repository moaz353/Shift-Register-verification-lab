package shift_reg_coverage_collector_pkg ; 


import uvm_pkg::*;
`include "uvm_macros.svh"
    
    import shift_reg_seq_item_pkg::*;
    
    class shift_reg_coverage_collector extends uvm_component ; 
        `uvm_component_utils(shift_reg_coverage_collector) ; 
        
        uvm_analysis_export #(shift_reg_seq_item) cov_export ; 
        uvm_tlm_analysis_fifo #(shift_reg_seq_item) cov_fifo ; 
        
        shift_reg_seq_item cov_seq_item ;
        
        covergroup cg ; 
            datain_cp    : coverpoint  cov_seq_item.datain;
            serial_in_cp : coverpoint  cov_seq_item.serial_in;
            direction_cp : coverpoint  cov_seq_item.direction;
            mode_cp      : coverpoint  cov_seq_item.mode ;
        endgroup 
        
        function new(string name = "shift_reg_coverage_collector" , uvm_component parent = null) ; 
            super.new(name , parent ) ; 
            cg = new() ; 
        endfunction 
        
        function void build_phase (uvm_phase phase ) ; 
            super.build_phase(phase) ; 
            cov_export = new("cov_export" , this ) ;
            cov_fifo = new("fifo" , this) ; 
        endfunction 
        
        function void connect_phase (uvm_phase phase ) ; 
            super.connect_phase(phase) ; 
            cov_export.connect(cov_fifo.analysis_export) ; 
        endfunction 
        
        task run_phase (uvm_phase phase) ; 
            super.run_phase(phase) ; 
            forever begin 
                cov_fifo.get(cov_seq_item) ; 
                cg.sample() ; 
            end 
        endtask 
    endclass
endpackage


