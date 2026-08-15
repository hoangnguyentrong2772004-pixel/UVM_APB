class apb_agent extends uvm_agent;
    `uvm_component_utils(apb_agent)
    `COMP_CONSTRUCTOR(apb_agent)

    apb_driver driver;
    apb_monitor monitor;
    apb_sequencer seqr;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        driver = apb_driver::type_id::create("driver",this);
        monitor = apb_monitor::type_id::create("monitor",this);
        seqr = apb_sequencer::type_id::create("seqr",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(seqr.seq_item_export);
    endfunction
    
endclass
        
