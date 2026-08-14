`include "defines.svh"

class trans extends uvm_sequence_item;
`uvm_object_utils(trans)

function new(string name= "trans");
super.new(name);
endfunction

rand bit wr_cs;
rand bit rd_cs;
rand bit wr_en;
rand bit rd_en;
rand bit [`DATA_WIDTH-1:0] data_in;
bit [`DATA_WIDTH-1:0] data_out;
bit full;
bit empty;

constraint c1{ data_in inside {[1:255]};}
constraint c2{ wr_cs dist {0:=1, 1:=1};}
constraint c3{ rd_cs dist {0:=1, 1:=1};}
constraint c4{ wr_en dist {0:=1, 1:=1};}
constraint c5{ rd_en dist {0:=1, 1:=1};}
constraint c6{ wr_cs -> wr_en;}
constraint c7{ rd_cs -> rd_en;}

endclass
