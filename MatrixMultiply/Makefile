sim: matmul test
	bsc -o sim -e mkTest mkTest.v
matmul: Matmul.bsv
	bsc -u -verilog Matmul.bsv
test: Testbench.bsv
	bsc -u -verilog Testbench.bsv
clean:
	rm *.v *.bo sim
