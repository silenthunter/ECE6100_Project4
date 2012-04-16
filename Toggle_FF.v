//
// ECE4100/6100 Advanced Computer Architecture 
//
// Prof. Hsien-Hsin Sean Lee
// School of Electrical and Computer Engineering
// Georgia Institute of Technology
// Atlanta, GA 30332
// email: leehs@ece.gatech.edu
//
//
// (1) 1-bit Toggle Flip/Flop
// (2) D Latch
//
/////////////////////////////////////////////
module Toggle_FF_GT6100 (out, en, clear_bar, clock);
input en, clear_bar, clock;
output out;

nand INV (clock_bar, clock, clock);
D_latch_GT6100 DL0 (.Q(q1), .D(a1), .en(clock_bar));
D_latch_GT6100 DL1 (.Q(out), .D(q1), .en(clock));
nand A0 (a1, i0, i0);
nand A1 (i0, x1, clear_bar);
xor_2_GT6100 X1 (x1, en, out);

endmodule


////////////////////////////////
module D_latch_GT6100 (Q, D, en);
input en, D;
output Q;
parameter delay=0.1;

nand #delay (Dbar, D, D);
nand #delay N1(o1, D, en), N2(o2, en, Dbar), N3(Q, o1, Qbar), N4(Qbar, Q, o2);  

endmodule

