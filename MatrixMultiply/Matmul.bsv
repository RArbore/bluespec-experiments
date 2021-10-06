package Matmul;

import Vector::*;

interface Matmul#(type rows, type mids, type cols);
   method Vector#(TMul#(rows, cols), Int#(32)) read();
   method Action set_a(Vector#(TMul#(rows, mids), Int#(32)) a);
   method Action set_b(Vector#(TMul#(mids, cols), Int#(32)) b);
   method Bool finished_multiply();
   method Action start_multiply();
endinterface

module mkMatmul#(parameter UInt#(32) rows, UInt#(32) mids, UInt#(32) cols)(Matmul#(rows, mids, cols));

   Reg#(Vector#(TMul#(rows, cols), Int#(32))) internal <- mkReg(replicate(0));
   Reg#(Vector#(TMul#(rows, mids), Int#(32))) a_internal <- mkReg(replicate(0));
   Reg#(Vector#(TMul#(mids, cols), Int#(32))) b_internal <- mkReg(replicate(0));

   Reg#(Bit#(1)) in_process <- mkReg(1);
   Reg#(UInt#(32)) cur_row <- mkReg(32);
   Reg#(UInt#(32)) cur_col <- mkReg(32);

   rule dot(cur_row * cols + cur_col < rows * cols);

   endrule

   method Vector#(TMul#(rows, cols), Int#(32)) read();
      return internal;
   endmethod
   method Action set_a(Vector#(TMul#(rows, mids), Int#(32)) a);
      a_internal <= a;
   endmethod
   method Action set_b(Vector#(TMul#(mids, cols), Int#(32)) b);
      b_internal <= b;
   endmethod
   method Bool finished_multiply();
      return in_process == 0;
   endmethod
   method Action start_multiply();
      in_process <= 1;
      cur_row <= 0;
      cur_col <= 0;
   endmethod

endmodule

endpackage
