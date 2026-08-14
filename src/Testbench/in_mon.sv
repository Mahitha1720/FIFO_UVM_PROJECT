class in_mon extends uvm_monitor;
`uvm_component_utils(in_mon)

uvm_analysis_port #(trans) in_mon_port;
trans drv2mon;
fifo_config cfg;
virtual fifo_if.IN_MON vif;

function new(string name="in_mon", uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
in_mon_port = new("in_mon_port", this);

if(!uvm_config_db #(fifo_config):: get(this,"", "fifo_config", cfg))
`uvm_fatal("IN_MON","Input monitor did not get config")
vif= cfg.vif;
endfunction

task run_phase(uvm_phase phase);
forever
begin
drv2mon= trans::type_id::create("drv2mon");
collect_in_data(drv2mon);
in_mon_port.write(drv2mon);
`uvm_info("IN_MON", "Input monitor capturing data", UVM_NONE)
end
endtask

task collect_in_data( trans drv2mon);
@(vif.in_mon_cb);

drv2mon.wr_cs = vif.in_mon_cb.wr_cs;
drv2mon.rd_cs = vif.in_mon_cb.rd_cs;
drv2mon.wr_en = vif.in_mon_cb.wr_en;
drv2mon.rd_en = vif.in_mon_cb.rd_en;
drv2mon.data_in = vif.in_mon_cb.data_in;
endtask

endclass
