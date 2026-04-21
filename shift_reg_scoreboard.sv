
package shift_reg_scoreboard_pkg ; 


import uvm_pkg::*;
`include "uvm_macros.svh"

    import shift_reg_seq_item_pkg::*;
    
    class shift_reg_scoreboard extends uvm_scoreboard ; 
        `uvm_component_utils(shift_reg_scoreboard) ; 
        
        shift_reg_seq_item  sc_seq_item ; 
        
        uvm_analysis_export #(shift_reg_seq_item) sc_ana_export ; 
        
        uvm_tlm_analysis_fifo #(shift_reg_seq_item) sc_fifo ; 
        
        logic [5:0] dataout_ref ; 
        
        int correct_count = 0 ; 
        int error_count   = 0 ; 
        
        function new(string name = "shift_reg_scoreboard" , uvm_component parent = null) ; 
            super.new(name , parent) ; 
        endfunction
        
        function void build_phase (uvm_phase phase ) ; 
            super.build_phase(phase) ;
            
            sc_ana_export = new ("sc_ana_export" , this ) ; 
            
            sc_fifo = new ("sc_fifo" , this) ; 
        
        endfunction
        
        function void connect_phase (uvm_phase phase ) ; 
            super.connect_phase(phase) ; 
            sc_ana_export.connect(sc_fifo.analysis_export) ; 
        endfunction 
        
        
        
        task run_phase (uvm_phase phase )  ; 
            super.run_phase(phase) ;           
            sc_fifo.get(sc_seq_item);           
            ref_model(sc_seq_item) ; 
            if (sc_seq_item.dataout != dataout_ref ) begin 
                `uvm_error("run_phase" , " out_ref is not equal to design_out" ) ; 
                error_count ++ ; 
            end
            else begin 
                `uvm_info("run_phase" , " out_ref is equal to design_out" , UVM_LOW ) ;
                correct_count ++ ; 
            end
                
        endtask 


//* ref model ****************************************
        task ref_model(shift_reg_seq_item check_seq_item) ; 
            if (check_seq_item.reset)
                dataout_ref = 0;
            else
                if (check_seq_item.mode) // rotate
                    if (check_seq_item.direction) // left
                        dataout_ref = {check_seq_item.datain[4:0], check_seq_item.datain[5]};
                    else
                        dataout_ref = {check_seq_item.datain[0], check_seq_item.datain[5:1]};
                else // shift
                    if (check_seq_item.direction) // left
                        dataout_ref = {check_seq_item.datain[4:0], check_seq_item.serial_in};
                    else
                        dataout_ref = {check_seq_item.serial_in, check_seq_item.datain[5:1]};
        endtask
//************************************************************


//******************************* report_phase ***************
        function void report_phase(uvm_phase phase) ; 
            super.report_phase(phase) ; 
            `uvm_info("report_phase" , $sformatf("Toltal successful transactions : %0d " , correct_count) , UVM_MEDIUM) ; 
            `uvm_info("report_phase" , $sformatf("Toltal failed transactions : %0d " , error_count ) , UVM_MEDIUM) ; 
        endfunction 
    endclass
endpackage