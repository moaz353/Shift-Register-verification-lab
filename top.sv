
import uvm_pkg::*;
`include "uvm_macros.svh"

import shift_reg_test_pkg::*;

module top();
  // Clock generation
  // Instantiate the interface and DUT
  // run test using run_test task
  
  bit clk ; 

  initial begin
    clk = 0 ; 
    forever #1 clk = ~clk ; 
  end

  shift_reg_if shift_reg_if (clk) ;

  shift_reg DUT (.clk(shift_reg_if.clk), 
                  .reset(shift_reg_if.reset), 
                  .serial_in(shift_reg_if.serial_in), 
                  .direction(shift_reg_if.direction), 
                  .mode(shift_reg_if.mode), 
                  .datain(shift_reg_if.datain), 
                  .dataout(shift_reg_if.dataout) );

initial begin 

  uvm_config_db #(virtual shift_reg_if)::set( null , "*" , "shift_reg_v_if" , shift_reg_if) ; 

  run_test("shift_reg_test") ; 
end 

endmodule

