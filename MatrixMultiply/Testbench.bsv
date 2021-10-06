import FloatingPoint::*;
import StmtFSM::*;
import Matmul::*;
import Vector::*;

(* synthesize *)
module mkTest();
   Matmul#(3, 3, 3, Int#(32)) matmul <- mkMatmul(3, 3, 3);
   Reg#(Vector#(9, Int#(32))) a <- mkReg(replicate(0));
   Reg#(Vector#(9, Int#(32))) b <- mkReg(replicate(0));

   function check(pred, exp, index);
      action
         if (pred != exp) $display("FAIL: pred != exp, test #%0d", index);
      endaction
   endfunction
   Stmt test_seq = seq
                      a[0] <= 3;
                      a[1] <= 8;
                      a[2] <= 7;
                      a[3] <= 2;
                      a[4] <= 4;
                      a[5] <= 1;
                      a[6] <= -1;
                      a[7] <= -4;
                      a[8] <= -9;
                      b[0] <= -10;
                      b[1] <= -7;
                      b[2] <= 4;
                      b[3] <= -2;
                      b[4] <= 5;
                      b[5] <= -4;
                      b[6] <= -4;
                      b[7] <= 4;
                      b[8] <= 5;
                      matmul.set_a(a);
                      matmul.set_b(b);
                      matmul.start_multiply();
                      delay(19);
                      check(matmul.read()[0], -74, 1);
                      check(matmul.read()[1], 47, 2);
                      check(matmul.read()[2], 15, 3);
                      check(matmul.read()[3], -32, 4);
                      check(matmul.read()[4], 10, 5);
                      check(matmul.read()[5], -3, 6);
                      check(matmul.read()[6], 54, 7);
                      check(matmul.read()[7], -49, 8);
                      check(matmul.read()[8], -33, 9);
                      matmul.reset();
                      check(matmul.read()[0], 0, 10);
                      check(matmul.read()[1], 0, 11);
                      check(matmul.read()[2], 0, 12);
                      check(matmul.read()[3], 0, 13);
                      check(matmul.read()[4], 0, 14);
                      check(matmul.read()[5], 0, 15);
                      check(matmul.read()[6], 0, 16);
                      check(matmul.read()[7], 0, 17);
                      check(matmul.read()[8], 0, 18);
                      $display("Tests finished.");
                   endseq;
   mkAutoFSM(test_seq);
endmodule
