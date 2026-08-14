class out_mon extends uvm_monitor;
`uvm_component_utils(out_mon)

uvm_analysis_port #(trans) out_mon_port;
fifo_config cfg;
virtual fifo_if.OUT_MON vif;
trans dut2mon;

function new(string name="out_mon", uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
out_mon_port= new("out_mon_port", this);

if(!uvm_config_db #(fifo_config)::get(this,"", "fifo_config", cfg))
`uvm_fatal("OUT_MON", "Output monitor is not getting the config db")

vif= cfg.vif;
endfunction

task run_phase(uvm_phase phase);
forever
begin
dut2mon= trans::type_id::create("dut2mon");
collect_out_data(dut2mon);
out_mon_port.write(dut2mon);
end
endtask

task collect_out_data( trans dut2mon);
@(vif.out_mon_cb);

dut2mon.wr_cs = vif.out_mon_cb.wr_cs;
dut2mon.rd_cs = vif.out_mon_cb.rd_cs;
dut2mon.wr_en = vif.out_mon_cb.wr_en;
dut2mon.rd_en = vif.out_mon_cb.rd_en;
dut2mon.data_in = vif.out_mon_cb.data_in;
dut2mon.data_out = vif.out_mon_cb.data_out;
dut2mon.full = vif.out_mon_cb.full;
dut2mon.empty = vif.out_mon_cb.empty;
endtask

endclass

