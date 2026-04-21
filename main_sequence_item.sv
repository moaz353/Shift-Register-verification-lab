package main_sequence_pkg ; 

import uvm_pkg::*;
`include "uvm_macros.svh"
    
    import shift_reg_seq_item_pkg::*;
    
    class main_sequence extends uvm_sequence #(shift_reg_seq_item) ; 
    `uvm_object_utils(main_sequence) ;
    
    shift_reg_seq_item main_item ; 
    
    
    function new(string name = "shift_reg_sequence") ; 
        super.new(name) ; 
    endfunction 
    
    virtual task body() ; 
        main_item = shift_reg_seq_item::type_id::create("main_item") ;
        
        repeat(10000) begin 
            start_item(main_item) ; 
            
            assert(main_item.randomize()); 
            
            finish_item(main_item) ; 
        end 
    endtask
    endclass    
endpackage