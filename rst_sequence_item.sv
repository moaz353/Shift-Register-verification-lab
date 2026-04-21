package rst_sequence_pkg ; 


import uvm_pkg::*;
`include "uvm_macros.svh" ;

    
    import shift_reg_seq_item_pkg::*;
    
    class rst_sequence extends uvm_sequence #(shift_reg_seq_item) ; 
    `uvm_object_utils(rst_sequence) ;
    
    
    shift_reg_seq_item rst_item ; 
    
    function new(string name = "shift_reg_sequence") ; 
        super.new(name) ; 
    endfunction 
    
    virtual task body() ; 
        rst_item = shift_reg_seq_item::type_id::create("rst_item") ;
            
            start_item(rst_item) ; 
            
            rst_item.reset = 0 ; 
            
            finish_item(rst_item) ; 
    endtask
    endclass    
endpackage