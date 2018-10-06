CC := ghdl

src_dir := sources
tb_dir := testbench
sim_dir := simulation
src_files := $(wildcard $(src_dir)/*.vhd) $(wildcard $(src_dir)/*.vhdl)
tb_files := $(wildcard $(tb_dir)/*.vhd) $(wildcard $(tb_dir)/*.vhdl)

.DEFAULT_GOAL := simulate

syntax:
	$(CC) -s $(src_files) $(tb_files)

analyse: syntax
	$(CC) -a $(src_files) $(tb_files)

build: analyse
	$(CC) -e t_$(top)

simulate: build
	$(CC) -r t_$(top) --vcd=$(sim_dir)/$(top).vcd

display: simulate
	gtkwave $(sim_dir)/$(top).vcd

clean:
	rm -f *.cf

mrproper: clean
	rm -f $(sim_dir)/*
