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
