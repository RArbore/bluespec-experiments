import StmtFSM::*;
import Matmul::*;
import Vector::*;

(* synthesize *)
module mkTest();
   Matmul#(3, 3, 3, UInt#(32)) matmul <- mkMatmul(3, 3, 3);
   Vector#(9, UInt#(32)) a = replicate(2);
   Vector#(9, UInt#(32)) b = replicate(1);

   function check(pred, exp);
      action
         if (pred != exp) $display("FAIL: pred (%0d) != exp (%0d)", pred, exp);
      endaction
   endfunction
   Stmt test_seq = seq
                      matmul.set_a(a);
                      matmul.set_b(b);
                      matmul.start_multiply();
                      delay(19);
                      check(matmul.read()[0], 6);
                      check(matmul.read()[1], 6);
                      check(matmul.read()[2], 6);
                      check(matmul.read()[3], 6);
                      check(matmul.read()[4], 6);
                      check(matmul.read()[5], 6);
                      check(matmul.read()[6], 6);
                      check(matmul.read()[7], 6);
                      check(matmul.read()[8], 6);
                      $display("Tests finished.");
                   endseq;
   mkAutoFSM(test_seq);
endmodule
