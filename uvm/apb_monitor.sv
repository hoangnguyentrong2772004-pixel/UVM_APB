class apb_monitor extends uvm_monitor;
    `uvm_component_utils(apb_monitor)
    `COMP_CONSTRUCTOR(apb_monitor)

    virtual apb_interface vif;
    apb_trans trans;
    uvm_analysis_port #(apb_trans) ap_mon;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual apb_interface)::get(this,"","apb_interface",vif))
            `uvm_error("MON","dont get interface");

        ap_mon = new("ap_mon",this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

        forever begin
            trans = apb_trans::type_id::create("trans");
            @(vif.mon);
            if(vif.mon.PREADY && vif.mon.PSEL && vif.mon.PENABLE ) begin
                trans.PADDR = vif.mon.PADDR;
                trans.PWRITE = vif.mon.PWRITE;
                trans.PRESET_n = vif.mon.PRESET_n;
                if(trans.PWRITE) begin
                    trans.PDATA = vif.mon.PDATA;
                end
                else begin
                    trans.PRDATA = vif.mon.PRDATA;
                end

                ap_mon.write(trans);
                
                // dùng để chờ trans kết thúc
                wait (!vif.mon.PREADY);
            end
        end


    endtask
endclass
