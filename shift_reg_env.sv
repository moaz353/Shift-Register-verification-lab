
package shift_reg_env_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

  import shift_reg_agent_pkg::*;
  import shift_reg_scoreboard_pkg::*; 
  import shift_reg_coverage_collector_pkg::*;

class shift_reg_env extends uvm_env;

  `uvm_component_utils(shift_reg_env) ; 
  
  shift_reg_agent agent ; 
  
  shift_reg_scoreboard sc ; 
  
  shift_reg_coverage_collector cov_coll ;   
  
  function new (string name = "shift_reg_env" , uvm_component parent = null) ; 
    super.new(name,parent) ; 
  endfunction 
  

  function void build_phase (uvm_phase phase ) ; 
    super.build_phase(phase) ; 
    agent =  shift_reg_agent::type_id::create( "agent" , this ) ; 
    
    sc = shift_reg_scoreboard::type_id::create("sc" , this) ; 
    
    cov_coll = shift_reg_coverage_collector::type_id::create("cov_coll" , this) ; 
    
  endfunction 
  
  function void connect_phase(uvm_phase phase) ; 
    
    super.connect_phase(phase) ; 
    
    agent.agent_ana_port.connect(sc.sc_ana_export) ;
    
    agent.agent_ana_port.connect(cov_coll.cov_export) ;
    
  endfunction
  
endclass
endpackage