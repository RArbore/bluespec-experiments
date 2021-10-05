package Matmul;

import Vector::*;

interface Matmul#(type row, type mid, type col, type row_col, type row_mid, type mid_col);
   method Vector#(row_col, Int#(32)) read();
   method Action set_a(Vector#(row_mid, Int#(32)) a);
   method Action set_b(Vector#(mid_col, Int#(32)) b);
   method Bool finished_multiply();
   method Action start_multiply();
endinterface

module mkMatmul(Matmul#(row, mid, col, row_col, row_mid, mid_col));

   Vector#(row_col, Int#(32)) internal;
   Vector#(row_mid, Int#(32)) a_internal;
   Vector#(mid_col, Int#(32)) b_internal;

   method Vector#(row_col, Int#(32)) read();
      return read;
   endmethod
   method Action set_a(Vector#(row_mid, Int#(32)) a);
      a_internal <= a;
   endmethod
   method Action set_b(Vector#(mid_col, Int#(32)) b);
      b_internal <= b;
   endmethod
   method Action start_multiply();
   endmethod

endmodule

endpackage
