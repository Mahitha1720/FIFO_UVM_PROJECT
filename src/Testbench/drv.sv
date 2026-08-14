class drv extends uvm_driver #(trans);
`uvm_component_utils(drv)

trans drv2dut;
fifo_config cfg;
virtual fifo_if.DRV vif;

function new(string name="drv", uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db #(fifo_config)::get(this, "", "fifo_config", cfg))
`uvm_fatal("DRV", "Driver does not have config db")

vif= cfg.vif;
endfunction

task run_phase(uvm_phase phase);
@(negedge vif.rst);
forever
begin
seq_item_port.get_next_item(drv2dut);
drive(drv2dut);
seq_item_port.item_done();
end
endtask

task drive(trans drv2dut);
@(vif.drv_cb);
vif.drv_cb.wr_cs <= drv2dut.wr_cs;
vif.drv_cb.rd_cs <= drv2dut.rd_cs;
vif.drv_cb.wr_en <= drv2dut.wr_en;
vif.drv_cb.rd_en <= drv2dut.rd_en;
vif.drv_cb.data_in <= drv2dut.data_in;
endtask
endclass
