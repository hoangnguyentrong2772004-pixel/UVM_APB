`include "uvm_macros.svh"

module apb_tb;
    import uvm_pkg::*;
    import pkg::*;

    logic pclk ;
    always #5 pclk = ~pclk;
    apb_interface vif(pclk);
    apb_slave dut(
        .pclk(vif.pclk),
        .PRESET_n(vif.PRESET_n),
        .PSEL(vif.PSEL),
        .PENABLE(vif.PENABLE),
        .PWRITE(vif.PWRITE),
        .PADDR(vif.PADDR),
        .PDATA(vif.PDATA),
        .PRDATA(vif.PRDATA),
        .PREADY(vif.PREADY),
        .PSLVERR(vif.PSLVERR)
    );

    initial begin
        pclk <= 0;
        uvm_config_db#(virtual apb_interface)::set(null,"","apb_interface",vif);
    end
    initial 
        run_test("apb_test");

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
endmodule

