import FloatingPoint::*;
import StmtFSM::*;
import Matmul::*;
import Vector::*;

(* synthesize *)
module mkTest();
   Matmul#(3, 3, 3, FloatingPoint#(11, 52)) matmul <- mkMatmul(3, 3, 3);
   Vector#(9, FloatingPoint#(11, 52)) a = replicate(0);
   Vector#(9, FloatingPoint#(11, 52)) b = replicate(0);

   function check(pred, exp);
      action
         if (pred != exp) $display("FAIL: pred (%s%x.%x) != exp (%s%x.%x)", pred.sign ? "-" : "+", pred.exp, pred.sfd, exp.sign ? "-" : "+", exp.exp, exp.sfd);
      endaction
   endfunction
   Stmt test_seq = seq
                      matmul.set_a(a);
                      matmul.set_b(b);
                      matmul.start_multiply();
                      delay(19);
                      check(matmul.read()[0], 0);
                      check(matmul.read()[1], 0);
                      check(matmul.read()[2], 0);
                      check(matmul.read()[3], 0);
                      check(matmul.read()[4], 0);
                      check(matmul.read()[5], 0);
                      check(matmul.read()[6], 0);
                      check(matmul.read()[7], 0);
                      check(matmul.read()[8], 0);
                      $display("Tests finished.");
                   endseq;
   mkAutoFSM(test_seq);
endmodule
