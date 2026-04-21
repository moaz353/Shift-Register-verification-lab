package shift_reg_seq_item_pkg ; 

import uvm_pkg::*;
`include "uvm_macros.svh"

import shared_pkg::*; 

    class shift_reg_seq_item extends uvm_sequence_item  ; 
    `uvm_object_utils(shift_reg_seq_item) 
    
    rand logic reset ;
    rand logic serial_in ; 
    rand direction_e direction ; 
    rand mode_e mode ;
    rand logic [5:0] datain ; 
    logic [5:0] dataout ; 
    
    function new(string name = "shift_reg_sequence") ; 
        super.new(name) ; 
    endfunction 
    
    constraint rst_cons{
                            reset dist{0:= 98 , 1 := 2};
                        };
    
    function string convert2string();  
        
        return $sformatf("reset = %b , serial_in = %d  , direction = %b , mode = %b , datain = %d  , dataout = %d  " ,
                            super.convert2string() , reset , serial_in , direction , mode , datain , dataout ) ;  
    endfunction 
    
    function string convert2string_stimulus();  
        
        return $sformatf("reset = %b , serial_in = %d  , direction = %s , mode = %s , datain = %d  "  
                            , reset , serial_in , direction , mode , datain ) ;  
    endfunction 
    
    endclass    
endpackage