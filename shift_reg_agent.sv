
package shift_reg_agent_pkg ; 
    
import uvm_pkg::*;
`include "uvm_macros.svh"

    import shift_reg_driver_pkg::*; 
    import shift_reg_sequencer_pkg::*; 
    import shift_reg_mon_pkg::*; 
    import shift_reg_config_obj_pkg::*;
    import shift_reg_seq_item_pkg::*; 
    
    class shift_reg_agent extends uvm_agent ; 
        `uvm_component_utils(shift_reg_agent) ; 
        
        function new(string name = "shift_reg_agent" , uvm_component parent = null) ; 
            super.new(name , parent) ; 
        endfunction
        
        shift_reg_sequencer sqr ; 
        
        shift_reg_driver driver ; 
        
        shift_reg_config_obj ag_config_obj ; 
        
        shift_reg_mon mon ; 
        
        uvm_analysis_port #(shift_reg_seq_item) agent_ana_port ; 
        
        
        
        function void build_phase(uvm_phase phase) ;
            super.build_phase(phase) ; 
            
            if(!(uvm_config_db #(shift_reg_config_obj)::get(this , "" , "config_obj" , ag_config_obj ))) 
                `uvm_fatal("ag_get" , "config_obj is not getten in agent" ) ; 
            
            sqr = shift_reg_sequencer::type_id::create("sqr" , this ) ; 
            
            driver = shift_reg_driver::type_id::create("driver" , this ) ; 
            
            mon = shift_reg_mon::type_id::create("mon" , this ) ;
            
            agent_ana_port = new("agent_ana_port",this) ; 
            
        
        endfunction 
        
        function void connect_phase (uvm_phase phase) ; 
            super.connect_phase(phase) ; 
            
            driver.shift_reg_d_v_if  = ag_config_obj.shift_reg_c_v_if ; 
            
            mon.shift_reg_m_v_if     = ag_config_obj.shift_reg_c_v_if ; 
            
            mon.mon_ana_port.connect(agent_ana_port) ; 
            
            driver.seq_item_port.connect(sqr.seq_item_export); 
        endfunction 
    
    endclass
endpackage