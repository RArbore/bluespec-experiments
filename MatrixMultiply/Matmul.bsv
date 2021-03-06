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

package Matmul;

import Vector::*;

interface Matmul#(type rows, type mids, type cols, type val_type);

   method Vector#(TMul#(rows, cols), val_type) read();
   method Action set_a(Vector#(TMul#(rows, mids), val_type) a);
   method Action set_b(Vector#(TMul#(mids, cols), val_type) b);
   method Action reset();
   method Bool finished();
   method Action start();

endinterface

module mkMatmul#(parameter UInt#(32) rows, UInt#(32) mids, UInt#(32) cols)(Matmul#(rows, mids, cols, val_type))
   provisos(Arith#(val_type), Bits#(val_type, val_type_sz));

   Reg#(Vector#(TMul#(rows, cols), val_type)) internal <- mkReg(replicate(0));
   Reg#(Vector#(TMul#(rows, mids), val_type)) a_internal <- mkReg(replicate(0));
   Reg#(Vector#(TMul#(mids, cols), val_type)) b_internal <- mkReg(replicate(0));

   Reg#(Bit#(1)) in_progress <- mkReg(1);
   Reg#(UInt#(32)) cur_row <- mkReg(32);
   Reg#(UInt#(32)) cur_col <- mkReg(32);
   Reg#(UInt#(32)) cur_mid <- mkReg(32);

   rule dot(in_progress == 1);
      internal[cur_row * cols + cur_col] <= internal[cur_row * cols + cur_col] + a_internal[cur_row * cols + cur_mid] * b_internal[cur_mid * cols + cur_col];
   endrule
   rule update_pos(in_progress == 1);
      if (cur_mid < mids - 1) cur_mid <= cur_mid + 1;
      else if (cur_col < cols - 1) begin
         cur_mid <= 0;
         cur_col <= cur_col + 1;
      end
      else if (cur_row < rows - 1) begin
         cur_mid <= 0;
         cur_col <= 0;
         cur_row <= cur_row + 1;
      end
      else in_progress <= 0;
   endrule

   method Vector#(TMul#(rows, cols), val_type) read();
      return internal;
   endmethod
   method Action set_a(Vector#(TMul#(rows, mids), val_type) a);
      a_internal <= a;
   endmethod
   method Action set_b(Vector#(TMul#(mids, cols), val_type) b);
      b_internal <= b;
   endmethod
   method Action reset();
      internal <= replicate(0);
   endmethod
   method Bool finished();
      return in_progress == 0;
   endmethod
   method Action start();
      in_progress <= 1;
      cur_row <= 0;
      cur_col <= 0;
      cur_mid <= 0;
   endmethod

endmodule

endpackage
