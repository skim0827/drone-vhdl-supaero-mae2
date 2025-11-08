ifndef TEST
	$(error You must specify a testbench)
endif

SRC_DIR = src
TB_DIR =  tb


GHDL = ghdl 

WAVE_DIR = waves 
WAVE = $(WAVE_DIR)/wave.vcd

SRC = $(wildcard $(SRC_DIR)/*.vhd)
TB_SRC = $(wildcard $(TB_DIR)/*.vhd)

all : run 

# Compile sources
analyse : 
	@mkdir -p $(WAVE_DIR)
	$(GHDL) -a $(SRC) $(TB_SRC)

# Elaborate (link) the selected testbench
elaborate : analyse
	$(GHDL) -e $(TEST)


# Run simulation and generate waveform
run : elaborate
	$(GHDL) -r $(TEST) --vcd=$(WAVE)

# View waveform
wave : run 
	gtkwave $(WAVE)

clean : 
	rm -f *.o *.cf $(WAVE_DIR)/*.vcd $(TB_DIR)/*.o $(SRC_DIR)/*.o
	rm -f $(TEST)

