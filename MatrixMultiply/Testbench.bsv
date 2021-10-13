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

import FloatingPoint::*;
import RegFile::*;
import StmtFSM::*;
import Matmul::*;
import Matadd::*;
import Vector::*;

(* synthesize *)
module mkTest();
   RegFile#(Bit#(5), Bit#(32)) regFile <- mkRegFileLoad("data.hex", 0, 26);
   Matmul#(3, 3, 3, Int#(32)) matmul <- mkMatmul(3, 3, 3);
   Matadd#(3, 3, 3, Int#(32)) matadd <- mkMatadd(3, 3, 3);
   Reg#(Vector#(9, Int#(32))) a <- mkReg(replicate(0));
   Reg#(Vector#(9, Int#(32))) b <- mkReg(replicate(0));

   function check(pred, exp, index);
      action
         if (pred != exp) $display("FAIL: pred != exp, test #%0d", index);
      endaction
   endfunction
   Stmt test_seq = seq
                      a[0] <= unpack(regFile.sub(0));
                      a[1] <= unpack(regFile.sub(1));
                      a[2] <= unpack(regFile.sub(2));
                      a[3] <= unpack(regFile.sub(3));
                      a[4] <= unpack(regFile.sub(4));
                      a[5] <= unpack(regFile.sub(5));
                      a[6] <= unpack(regFile.sub(6));
                      a[7] <= unpack(regFile.sub(7));
                      a[8] <= unpack(regFile.sub(8));
                      b[0] <= unpack(regFile.sub(9));
                      b[1] <= unpack(regFile.sub(10));
                      b[2] <= unpack(regFile.sub(11));
                      b[3] <= unpack(regFile.sub(12));
                      b[4] <= unpack(regFile.sub(13));
                      b[5] <= unpack(regFile.sub(14));
                      b[6] <= unpack(regFile.sub(15));
                      b[7] <= unpack(regFile.sub(16));
                      b[8] <= unpack(regFile.sub(17));
                      matadd.set_a(a);
                      matadd.set_b(b);
                      matadd.start();
                      delay(27);
                      check(matadd.finished(), True, 0);
                      check(matadd.read()[0], unpack(regFile.sub(18)), 1);
                      check(matadd.read()[1], unpack(regFile.sub(19)), 2);
                      check(matadd.read()[2], unpack(regFile.sub(20)), 3);
                      check(matadd.read()[3], unpack(regFile.sub(21)), 4);
                      check(matadd.read()[4], unpack(regFile.sub(22)), 5);
                      check(matadd.read()[5], unpack(regFile.sub(23)), 6);
                      check(matadd.read()[6], unpack(regFile.sub(24)), 7);
                      check(matadd.read()[7], unpack(regFile.sub(25)), 8);
                      check(matadd.read()[8], unpack(regFile.sub(26)), 9);
                      matadd.reset();
                      check(matadd.read()[0], 0, 10);
                      check(matadd.read()[1], 0, 11);
                      check(matadd.read()[2], 0, 12);
                      check(matadd.read()[3], 0, 13);
                      check(matadd.read()[4], 0, 14);
                      check(matadd.read()[5], 0, 15);
                      check(matadd.read()[6], 0, 16);
                      check(matadd.read()[7], 0, 17);
                      check(matadd.read()[8], 0, 18);
                      $display("Tests finished.");
                   endseq;
   mkAutoFSM(test_seq);
endmodule
