
package shift_reg_test_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import shift_reg_env_pkg::*;

import shift_reg_config_obj_pkg::*;

import rst_sequence_pkg::*;
import main_sequence_pkg::*; 

class shift_reg_test extends uvm_test;
  `uvm_component_utils(shift_reg_test) ;
  
  shift_reg_env env ; 
  
  shift_reg_config_obj config_obj ;
  
  virtual shift_reg_if shift_reg_v_if ;
  
  rst_sequence rst_seq ; 
  
  main_sequence main_seq ; 
  
function new (string name = "shift_reg_test" , uvm_component parent =  null );
    super.new(name , parent ) ; 
endfunction 

function void build_phase (uvm_phase phase ) ; 
  super.build_phase(phase) ; 
  env = shift_reg_env::type_id::create( "env" , this ) ; 
  
  config_obj = shift_reg_config_obj::type_id::create( "config_obj" , this ) ; 
  
  main_seq = main_sequence::type_id::create("main_seq" , this) ; 
  
  rst_seq = rst_sequence::type_id::create("rst_seq" , this) ; 
  
  if(!(uvm_config_db #(virtual shift_reg_if)::get(this , "" , "shift_reg_v_if" , config_obj.shift_reg_c_v_if ) ) ) 
    `uvm_fatal("build_phase" , "v_if is not getten") ; 
  
  uvm_config_db #(shift_reg_config_obj )::set(this ,"*", "config_obj" , config_obj  ) ; 
  
endfunction 

task run_phase (uvm_phase phase) ; 
    super.run_phase(phase) ; 
    phase.raise_objection(this) ; 
    
    `uvm_info("run_phase" , "Reset_Asserted" , UVM_LOW) ; 
    
    rst_seq.start(env.agent.sqr);
    
    `uvm_info("run_phase" , "Reset_Deasserted" , UVM_LOW) ; 
    
    
    `uvm_info("run_phase" , "Stimulus Generation Started" , UVM_LOW) ; 
    
    main_seq.start(env.agent.sqr) ; 
    
    `uvm_info("run_phase" , "Stimulus Generation Finished" , UVM_LOW) ; 
    
    
    phase.drop_objection(this) ; 
    
endtask 

endclass: shift_reg_test

endpackage