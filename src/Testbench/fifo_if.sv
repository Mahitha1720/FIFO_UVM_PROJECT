`include "defines.svh"

interface fifo_if(input bit clk, input bit rst);
bit wr_cs;
bit rd_cs;
bit wr_en;
bit rd_en;
bit [`DATA_WIDTH-1:0] data_in;
//OUTPUT
bit [`DATA_WIDTH-1:0] data_out;
bit full;
bit empty;

clocking drv_cb @(posedge clk);
default input #0 output #0;
output wr_cs;
output rd_cs;
output wr_en;
output rd_en;
output data_in;
endclocking

clocking in_mon_cb @(posedge clk);
default input #0 output #0;
input wr_cs;
input rd_cs;
input wr_en;
input rd_en;
input data_in;
endclocking

clocking out_mon_cb @(posedge clk);
default input #0 output #0;
input wr_cs;
input rd_cs;
input wr_en;
input rd_en;
input data_in;
input data_out;
input full;
input empty;
endclocking

modport DRV(input clk,rst, clocking drv_cb);
modport IN_MON(input clk,rst, clocking in_mon_cb);
modport OUT_MON(input clk,rst, clocking out_mon_cb);

//ASSERTIONS

property full_empty;
    @(posedge clk) disable iff (rst)
    !(full && empty);
endproperty
assert property(full_empty)
else $display("Assertion FAIL: full and empty");


property write_full;
    @(posedge clk) disable iff (rst)
    (wr_cs && wr_en && full) |=> $stable(full);
endproperty
assert property(write_full)
else $display("Assertion FAIL: write when full not blocked");


property read_empty;
    @(posedge clk) disable iff (rst)
    (rd_cs && rd_en && empty) |=> $stable(empty);
endproperty
assert property(read_empty)
else $display("ASSERTION FAIL: read happening when empty");


property write_empty;
    @(posedge clk) disable iff (rst)
    (wr_cs && wr_en && empty) |=> !empty;
endproperty

assert property(write_empty)
else $display("Assertion FAIL: FIFO is still empty after write");


property read_full;
    @(posedge clk) disable iff (rst)
    (rd_cs && rd_en && full) |=> !full;
endproperty

assert property(read_full)
else $display("Assertion FAIL: not full after read");

property reset_fifo;
    @(posedge clk)
    rst |=> (empty && !full);
endproperty

assert property(reset_fifo)
else $display("Assertion FAIL: empty once reset");

endinterface
