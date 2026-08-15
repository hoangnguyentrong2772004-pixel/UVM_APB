class apb_test extends uvm_test;
    `uvm_component_utils(apb_test)
    `COMP_CONSTRUCTOR(apb_test)
    apb_env my_env;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        my_env = apb_env::type_id::create("my_env",this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        apb_write_sequence my_write;
        apb_read_sequence my_read;



        phase.raise_objection(this);
        my_write = apb_write_sequence::type_id::create("my_write" );
        my_read = apb_read_sequence::type_id::create("my_read");

        my_write.start(my_env.my_agent.seqr);
        my_read.start(my_env.my_agent.seqr);

        phase.drop_objection(this);
    endtask
endclass
