class apb_reset_sequence extends uvm_sequence #(apb_trans);
    `uvm_object_utils(apb_reset_sequence)
    `OBJ_CONSTRUCTOR(apb_reset_sequence)

    apb_trans trans;

    virtual task body();
        repeat (5) begin
            trans = apb_trans::type_id::create("trans");
            start_item(trans);
            trans.randomize() with {trans.PRESET_n == 0;};
            finish_item(trans);
        end
    endtask
endclass
