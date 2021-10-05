sim: counter test
	bsc -o sim -e mkTest mkTest.v
counter: MyCounter.bsv
	bsc -u -verilog MyCounter.bsv
test: Testbench.bsv
	bsc -u -verilog Testbench.bsv
clean:
	rm *.v *.bo sim
