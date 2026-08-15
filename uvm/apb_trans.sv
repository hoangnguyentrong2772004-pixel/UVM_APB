class apb_trans extends uvm_sequence_item;
    `OBJ_CONSTRUCTOR(apb_trans)

    rand bit PRESET_n;
    bit PREADY;
    rand bit [`ADDR_WIDTH - 1: 0]   PADDR;
    rand bit [`DATA_WIDTH - 1 : 0]  PDATA;
    bit [`RDATA_WIDTH - 1 : 0]      PRDATA;
    rand bit PWRITE;
    bit PSLVERR;
    bit PSEL;
    bit PENABLE;

    `uvm_object_utils_begin(apb_trans)
        `uvm_field_int(PRESET_n, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(PREADY, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(PADDR, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(PDATA, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(PRDATA, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(PWRITE, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(PSLVERR, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(PSEL, UVM_ALL_ON | UVM_DEC)
        `uvm_field_int(PENABLE, UVM_ALL_ON | UVM_DEC)
    `uvm_object_utils_end

constraint valid_address {PADDR inside {[0:9]};}
constraint data {PDATA inside {[0:100]};}
constraint invalid_address {PADDR inside {[10:11]};}

endclass

