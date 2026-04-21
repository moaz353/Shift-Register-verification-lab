
package shift_reg_config_obj_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

class shift_reg_config_obj extends uvm_object;
    
    `uvm_object_utils(shift_reg_config_obj) ; 
    
    virtual shift_reg_if shift_reg_c_v_if ; 
    
    
    function new (string name = "shift_reg_config_obj") ; 
        super.new(name) ; 
    endfunction
endclass 


endpackage 