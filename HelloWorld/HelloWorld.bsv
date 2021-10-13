/*  This file is part of bluespec-experiments.
    bluespec-experiments is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    any later version.
    bluespec-experiments is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with bluespec-experiments. If not, see <https://www.gnu.org/licenses/>.  */

package HelloWorld;
    String s = "Hello world";

    (* synthesize *)
    module mkPrint(Empty);
        Reg#(UInt#(4)) ctr <- mkReg(0);
        rule ctr_done (ctr >= 5);
            $finish(0);
        endrule
        rule inc (ctr == 0);
            ctr <= 1;
        endrule
        rule hello_world (ctr < 5 && ctr > 0);
            $display(ctr);
            ctr <= ctr * 2;
        endrule
    endmodule
endpackage
