#   This file is part of bluespec-experiments. \
\
    bluespec-experiments is free software: you can redistribute it and/or modify \
    it under the terms of the GNU General Public License as published by \
    the Free Software Foundation, either version 3 of the License, or \
    any later version. \
\
    bluespec-experiments is distributed in the hope that it will be useful, \
    but WITHOUT ANY WARRANTY; without even the implied warranty of \
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the \
    GNU General Public License for more details. \
\
    You should have received a copy of the GNU General Public License \
    along with bluespec-experiments. If not, see <https://www.gnu.org/licenses/>.

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
