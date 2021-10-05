package HelloWorld;
    String s = "Hello world";

    (* synthesize *)
    module mkPrint(Empty);
        Reg#(UInt#(4)) ctr <- mkReg(0);
        rule ctr_done (ctr >= 5);
            $finish(0);
        endrule
        rule inc (ctr == 0);
            ctr <= 1;
        endrule
        rule hello_world (ctr < 5 && ctr > 0);
            $display(ctr);
            ctr <= ctr * 2;
        endrule
    endmodule
endpackage
