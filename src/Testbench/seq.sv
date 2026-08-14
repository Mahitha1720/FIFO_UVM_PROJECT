class seq extends uvm_sequence #(trans);
`uvm_object_utils(seq)
trans req;

function new(string name="seq");
super.new(name);
endfunction

task body();
req= trans::type_id::create("req");
start_item(req);
assert(req.randomize());
finish_item(req);
endtask
endclass




class seq_wr extends uvm_sequence #(trans);
`uvm_object_utils(seq_wr)
trans req;

function new(string name="seq_wr");
super.new(name);
endfunction

task body();
req= trans::type_id::create("req");
repeat(50) begin
start_item(req);
assert(req.randomize() with {wr_cs==1; wr_en==1; rd_cs==0; rd_en==0;});
finish_item(req);
end
endtask
endclass


class seq_rd extends uvm_sequence #(trans);
`uvm_object_utils(seq_rd)
trans req;

function new(string name="seq_rd");
super.new(name);
endfunction

task body();
req= trans::type_id::create("req");
repeat(50) begin
start_item(req);
assert(req.randomize() with {rd_cs==1; rd_en==1; wr_cs==0; wr_en==0;});
finish_item(req);
end
endtask
endclass


class seq_wr_rd extends uvm_sequence #(trans);
`uvm_object_utils(seq_wr_rd)

function new(string name="seq_wr_rd");
super.new(name);
endfunction

task body();
repeat(50) begin
req = trans::type_id::create("req");
start_item(req);
assert(req.randomize() with {wr_cs==1; wr_en==1; rd_cs==0; rd_en==0;});
finish_item(req);
end

repeat(50) begin
req = trans::type_id::create("req");
start_item(req);
assert(req.randomize() with {rd_cs==1; rd_en==1; wr_cs==0; wr_en==0;});
finish_item(req);
end
endtask
Endclass


class seq_simul extends uvm_sequence #(trans);
`uvm_object_utils(seq_simul)

function new(string name="seq_simul");
super.new(name);
endfunction

task body();
repeat(50) begin
req=trans::type_id::create("req");
start_item(req);
assert(req.randomize() with {wr_cs==1; wr_en==1; rd_en==1; rd_cs==1;});
finish_item(req);
end
endtask
endclass





//only rd_en is high, rd_cs not high
class seq_rd_en extends uvm_sequence #(trans);
`uvm_object_utils(seq_rd_en)
trans req;

function new(string name="seq_rd_en");
super.new(name);
endfunction

task body();
repeat(50) begin
req= trans::type_id::create("req");
start_item(req);
assert(req.randomize() with {rd_en==1; rd_cs==0;});
finish_item(req);
end
endtask
endclass


//only wr_en is high, wr_cs not high
class seq_wr_en extends uvm_sequence #(trans);
`uvm_object_utils(seq_wr_en)
trans req;

function new(string name="seq_wr_en");
super.new(name);
endfunction

task body();
repeat(50) begin
req= trans::type_id::create("req");
start_item(req);
assert(req.randomize() with {wr_en==1;wr_cs==0;});
finish_item(req);
end
endtask
endclass



class seq_full extends uvm_sequence #(trans);
`uvm_object_utils(seq_full)
trans req;
function new(string name="seq_full");
super.new(name);
endfunction
task body();
repeat(260) begin
req = trans::type_id::create("req");
start_item(req);
assert(req.randomize() with {wr_cs==1; wr_en==1; rd_cs==0; rd_en==0;});
finish_item(req);
end
endtask
endclass

