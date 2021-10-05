package HelloWorld;
    String s = "Hello world";

    (* synthesize *)
    module mkPrint(Empty);
        Reg#(UInt#(3)) ctr <- mkReg(0);
        rule ctr_done (ctr == 5);
            $finish(0);
        endrule
        rule hello_world (ctr < 5);
            $display(s);
            ctr <= ctr + 1;
        endrule
    endmodule
endpackage
