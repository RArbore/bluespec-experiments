sim: matmul matadd test
	bsc -o sim -e mkTest mkTest.v
matmul: Matmul.bsv
	bsc -u -verilog Matmul.bsv
matadd: Matadd.bsv
	bsc -u -verilog Matadd.bsv
test: Testbench.bsv
	bsc -u -verilog Testbench.bsv
clean:
	rm *.v *.bo sim
