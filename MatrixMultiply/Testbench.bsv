import StmtFSM::*;
import Matmul::*;
import Vector::*;

(* synthesize *)
module mkTest();
   Matmul#(3, 3, 3) matmul <- mkMatmul(3, 3, 3);
   Vector#(9, Int#(32)) a = replicate(1);
   Vector#(9, Int#(32)) b = replicate(1);

   function check(pred, exp);
      action
         if (pred != exp) $display("FAIL: pred (%0d) != exp (%0d)", pred, exp);
      endaction
   endfunction
   Stmt test_seq = seq
                      matmul.set_a(a);
                      matmul.set_b(b);
                      matmul.start_multiply();
                      delay(100);
                      check(matmul.read()[0], 3);
                      check(matmul.read()[1], 3);
                      check(matmul.read()[2], 3);
                      check(matmul.read()[3], 3);
                      check(matmul.read()[4], 3);
                      check(matmul.read()[5], 3);
                      check(matmul.read()[6], 3);
                      check(matmul.read()[7], 3);
                      check(matmul.read()[8], 3);
                      $display("Tests finished.");
                   endseq;
   mkAutoFSM(test_seq);
endmodule
