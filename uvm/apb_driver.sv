class apb_driver extends uvm_driver #(apb_trans);
    `uvm_component_utils(apb_driver)
    `COMP_CONSTRUCTOR(apb_driver)

virtual apb_interface vif;
apb_trans trans;

virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual apb_interface )::get(this,"","apb_interface",vif))
        `uvm_fatal("DRV","dont get interface");
endfunction

virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        trans = apb_trans::type_id::create("trans");
        seq_item_port.get_next_item(trans);
        driver_dut(trans);
        seq_item_port.item_done();    
    end
endtask

virtual task driver_dut(apb_trans trans);
    @(vif.drv);
    if(!trans.PRESET_n) begin
        vif.drv.PADDR <= 0;
        vif.drv.PDATA <= 0;
    end

    else begin
        vif.drv.PADDR <= trans.PADDR;
        vif.drv.PDATA <= trans.PDATA;
        vif.drv.PWRITE <= trans.PWRITE;
        vif.drv.PSEL <= 1'b1;
        vif.drv.PENABLE <= 1'b0;
        vif.drv.PRESET_n <= trans.PRESET_n;
        @(vif.drv);
        vif.drv.PENABLE <= 1'b1;

        wait(vif.drv.PREADY);
        if(!trans.PWRITE) begin
            trans.PRDATA <= vif.drv.PRDATA; 
        end
    end
endtask
endclass

