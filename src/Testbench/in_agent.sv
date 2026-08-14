class in_agent extends uvm_agent;
`uvm_component_utils(in_agent)

drv drv_h;
seqr seqr_h;
in_mon in_mon_h;
fifo_config cfg;


function new(string name= "in_agent", uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

if(!uvm_config_db #(fifo_config) :: get(this,"", "fifo_config", cfg))
`uvm_fatal("IN_AGENT", "Input agent does not have config")

in_mon_h= in_mon::type_id::create("in_mon_h", this);

if(cfg.input_agent_is_active== UVM_ACTIVE) begin
drv_h= drv::type_id::create("drv_h", this);
seqr_h= seqr::type_id::create("seqr_h", this);
end
endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
if(cfg.input_agent_is_active == UVM_ACTIVE)
drv_h.seq_item_port.connect(seqr_h.seq_item_export);
endfunction

endclass
