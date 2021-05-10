module EXT(IMM16, EXTOp, IMM32);
    
  input [15:0] IMM16;
  input EXTOp;
  output [31:0] IMM32;
   
  assign IMM32 = (EXTOp)?{{16{IMM16[15]}}, IMM16}:{16'd0, IMM16};
         
endmodule
