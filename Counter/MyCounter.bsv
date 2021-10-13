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

package MyCounter;
interface MyCounter;
   method Bit#(8) read();
   method Action load(Bit#(8) newval);
   method Action increment();
   method Action decrement();
endinterface

(* synthesize *)
module mkMyCounter(MyCounter);
   Reg#(Bit#(8)) value <- mkReg(0);
   PulseWire increment_called <- mkPulseWire();
   PulseWire decrement_called <- mkPulseWire();
   rule do_increment(increment_called && !decrement_called);
      value <= value + 1;
   endrule
   rule do_decrement(!increment_called && decrement_called);
      value <= value - 1;
   endrule
   method Bit#(8) read();
      return value;
   endmethod
   method Action load(Bit#(8) newvalue);
      value <= newvalue;
   endmethod
   method Action increment();
      increment_called.send();
   endmethod
   method Action decrement();
      decrement_called.send();
   endmethod
endmodule
endpackage
