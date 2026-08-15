`include "define.sv"
interface apb_interface (input pclk);
    logic   PRESET_n;
    logic   PREADY;
    logic   [`ADDR_WIDTH - 1:0] PADDR;
    logic   [`DATA_WIDTH - 1:0] PDATA;
    logic   [`RDATA_WIDTH - 1:0] PRDATA;
    logic   PWRITE;
    logic   PSLVERR;
    logic   PSEL;
    logic   PENABLE;

    clocking drv @(posedge pclk);
        default input #1 output #0;
        output PRESET_n, PSEL, PWRITE, PDATA, PADDR, PENABLE;
        input PRDATA, PSLVERR, PREADY ;
    endclocking 
    
    clocking mon @(posedge pclk);
        default input #1 output #0;
        input PRESET_n, PADDR, PDATA, PWRITE, PSEL, PENABLE;
        input PRDATA, PSLVERR, PREADY ;
    endclocking
    
endinterface


