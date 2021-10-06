import FloatingPoint::*;
import StmtFSM::*;
import Matmul::*;
import Vector::*;

(* synthesize *)
module mkTest();
   Matmul#(3, 3, 3, FloatingPoint#(11, 52)) matmul <- mkMatmul(3, 3, 3);
   Reg#(Vector#(9, FloatingPoint#(11, 52))) a <- mkReg(replicate(0));
   Reg#(Vector#(9, FloatingPoint#(11, 52))) b <- mkReg(replicate(0));

   function check(pred, exp);
      action
         if (pred != exp) $display("FAIL: pred != exp");
      endaction
   endfunction
   Stmt test_seq = seq
                      a[0] <= 2.0;
                      a[4] <= 2.0;
                      a[8] <= 2.0;
                      b[0] <= 1.0;
                      b[4] <= 1.0;
                      b[8] <= 1.0;
                      matmul.set_a(a);
                      matmul.set_b(b);
                      matmul.start_multiply();
                      delay(19);
                      check(matmul.read()[0], 2.0);
                      check(matmul.read()[1], 0);
                      check(matmul.read()[2], 0);
                      check(matmul.read()[3], 0);
                      check(matmul.read()[4], 2.0);
                      check(matmul.read()[5], 0);
                      check(matmul.read()[6], 0);
                      check(matmul.read()[7], 0);
                      check(matmul.read()[8], 2.0);
                      $display("Tests finished.");
                   endseq;
   mkAutoFSM(test_seq);
endmodule
