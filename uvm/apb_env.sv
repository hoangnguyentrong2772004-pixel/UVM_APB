class apb_env extends uvm_env;
    `uvm_component_utils(apb_env)
    `COMP_CONSTRUCTOR(apb_env)

    apb_scoreboard my_sco;
    apb_agent my_agent;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        my_sco = apb_scoreboard::type_id::create("my_sco",this);
        my_agent = apb_agent::type_id::create("my_agent",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        my_agent.monitor.ap_mon.connect(my_sco.ap_scb);
    endfunction

endclass