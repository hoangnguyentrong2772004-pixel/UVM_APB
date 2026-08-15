class apb_invalid_sequence extends uvm_sequence #(apb_trans);
    `uvm_object_utils(apb_invalid_sequence)
    `OBJ_CONSTRUCTOR(apb_invalid_sequence)


    apb_trans trans;

    virtual task body();
        repeat(5) begin
            trans = apb_trans::type_id::create("trans");
            start_item(trans);
            trans.valid_address.constraint_mode(0);
            trans.invalid_address.constraint_mode(1);
            trans.randomize() with {PRESET_n == 1;};
            finish_item(trans);
        end
    endtask
endclass
        