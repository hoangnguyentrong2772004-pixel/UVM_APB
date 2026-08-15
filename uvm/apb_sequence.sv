class apb_sequence extends uvm_sequence #(apb_trans);
    `uvm_object_utils(apb_sequence)
    `OBJ_CONSTRUCTOR(apb_sequence)

    apb_trans trans ;

    virtual task body();
        repeat(5) begin
            trans = apb_trans::type_id::create("trans");
            start_item(trans);
            trans.valid_address.constraint_mode(1);
            trans.invalid_address.constraint_mode(0);
            trans.randomize();
            finish_item(trans);
        end
    endtask
endclass



