class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard)
    `COMP_CONSTRUCTOR(apb_scoreboard)

    apb_trans trans;

    uvm_analysis_imp #(apb_trans,apb_scoreboard) ap_scb;

    bit [`DATA_WIDTH - 1 : 0] memory [int];

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_scb = new("ap_scb",this);
    endfunction

    function void write(apb_trans actual_trans);
        `uvm_info("SCB",$sformatf("paddr = 0x%0b, pdata = 0x%0b,prdata=0x%0b, pwrite = 0x%0b,",actual_trans.PADDR,actual_trans.PDATA,actual_trans.PRDATA,actual_trans.PWRITE), UVM_LOW);
        if(actual_trans.PWRITE) begin
            memory[actual_trans.PADDR] = actual_trans.PDATA;
            `uvm_info(get_type_name(),$sformatf("PWRITE = 0x%0b, PADDR = 0x%0b, PDATA = 0x%0b", actual_trans.PWRITE,actual_trans.PADDR,actual_trans.PDATA),UVM_LOW);
        end
        else begin
            if(memory.exists(actual_trans.PADDR)) begin
                
                `uvm_info(get_type_name(),$sformatf("PWRITE = 0x%0b, PRDATA = 0x%0b", actual_trans.PWRITE,actual_trans.PRDATA),UVM_LOW);
                if(actual_trans.PRDATA == memory[actual_trans.PADDR]) begin
                    `uvm_info(get_type_name(),$sformatf(" READ PASS PRDATA_actual = 0x%0b, PRDATA_expect = 0x%0b", actual_trans.PRDATA,memory[actual_trans.PADDR]),UVM_LOW); 
                end
                else begin     
                    `uvm_error(get_type_name(),$sformatf("READ FAIL PRDATA_actual = 0x%0b, PRDATA_expect = 0x%0b",actual_trans.PRDATA,memory[actual_trans.PADDR]));
                end
            end
            else begin
                `uvm_warning(get_type_name(),$sformatf("READ: address %0b not exists ", actual_trans.PADDR));
            end
        end
    endfunction
endclass
