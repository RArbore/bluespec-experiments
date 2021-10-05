import StmtFSM::*;
import MyCounter::*;

(* synthesize *)
module mkTest();
    MyCounter counter <- mkMyCounter();
    function check(expected_val);
        action
            if (counter.read() != expected_val) $display("FAIL: counter != %0d", expected_val);
        endaction
    endfunction
    function inc_dec();
        action
            counter.increment();
            counter.decrement();
        endaction
    endfunction
    Stmt test_seq = seq
        counter.load(42);
        inc_dec();
        check(42);
        $display("Tests finished.");
    endseq;
mkAutoFSM(test_seq);
endmodule
