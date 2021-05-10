module CTRL(Op, Funct, Zero, RegWrite, MemWrite, EXTOp, ALUOp, NPCOp, ALUSrc, GPRSel, WDSel, ARegSel);
            
  input [5:0] Op;
  input [5:0] Funct;
  input Zero;
  output RegWrite;
  output MemWrite;
  output EXTOp;
  output [3:0] ALUOp;
  output [1:0] NPCOp;
  output ALUSrc;
  output [1:0] GPRSel;
  output [1:0] WDSel;
  output ARegSel;
   
  wire rtype = ~|Op;
  wire i_add = rtype& Funct[5]& ~Funct[4]& ~Funct[3]& ~Funct[2]& ~Funct[1]& ~Funct[0]; //100000
  wire i_sub = rtype& Funct[5]& ~Funct[4]& ~Funct[3]& ~Funct[2]& Funct[1]& ~Funct[0]; //100010
  wire i_and = rtype& Funct[5]& ~Funct[4]& ~Funct[3]& Funct[2]& ~Funct[1]& ~Funct[0]; //100100
  wire i_or = rtype& Funct[5]& ~Funct[4]& ~Funct[3]& Funct[2]& ~Funct[1]& Funct[0]; //100101
  wire i_slt = rtype& Funct[5]& ~Funct[4]& Funct[3]& ~Funct[2]& Funct[1]& ~Funct[0]; //101010
  wire i_sltu = rtype& Funct[5]& ~Funct[4]& Funct[3]& ~Funct[2]& Funct[1]& Funct[0]; //101011
  wire i_addu = rtype& Funct[5]& ~Funct[4]& ~Funct[3]& ~Funct[2]& ~Funct[1]& Funct[0]; //100001
  wire i_subu = rtype& Funct[5]& ~Funct[4]& ~Funct[3]& ~Funct[2]& Funct[1]& Funct[0]; //100011
  wire i_jr = rtype& ~Funct[5]& ~Funct[4]& Funct[3]& ~Funct[2]& ~Funct[1]& ~Funct[0]; //001000
  wire i_jalr = rtype& ~Funct[5]& ~Funct[4]& Funct[3]& ~Funct[2]& ~Funct[1]& Funct[0]; //001001
  wire i_nor = rtype& Funct[5]& ~Funct[4]& ~Funct[3]& Funct[2]& Funct[1]& Funct[0]; //100111
  wire i_sll = rtype& ~Funct[5]& ~Funct[4]& ~Funct[3]& ~Funct[2]& ~Funct[1]& ~Funct[0]; //000000
  wire i_srl = rtype& ~Funct[5]& ~Funct[4]& ~Funct[3]& ~Funct[2]& Funct[1]& ~Funct[0]; //000010
  wire i_sra = rtype& ~Funct[5]& ~Funct[4]& ~Funct[3]& ~Funct[2]& Funct[1]& Funct[0]; //000011
  wire i_sllv = rtype& ~Funct[5]& ~Funct[4]& ~Funct[3]& Funct[2]& ~Funct[1]& ~Funct[0]; //000100
  wire i_srlv = rtype& ~Funct[5]& ~Funct[4]& ~Funct[3]& Funct[2]& Funct[1]& ~Funct[0]; //000110
  wire i_addi = ~Op[5]& ~Op[4]& Op[3]& ~Op[2]& ~Op[1]& ~Op[0]; //001000
  wire i_ori = ~Op[5]& ~Op[4]& Op[3]& Op[2]& ~Op[1]& Op[0]; //001101
  wire i_lw = Op[5]& ~Op[4]& ~Op[3]& ~Op[2]& Op[1]& Op[0]; //100011
  wire i_sw = Op[5]& ~Op[4]& Op[3]& ~Op[2]& Op[1]& Op[0]; //101011
  wire i_beq = ~Op[5]& ~Op[4]& ~Op[3]& Op[2]& ~Op[1]& ~Op[0]; //000100
  wire i_bne = ~Op[5]& ~Op[4]& ~Op[3]& Op[2]& ~Op[1]& Op[0]; //000101
  wire i_slti = ~Op[5]& ~Op[4]& Op[3]& ~Op[2]& Op[1]& ~Op[0]; //001010
  wire i_lui = ~Op[5]& ~Op[4]& Op[3]& Op[2]& Op[1]& Op[0]; //001111
  wire i_andi = ~Op[5]& ~Op[4]& Op[3]& Op[2]& ~Op[1]& ~Op[0]; //001100
  wire i_j = ~Op[5]& ~Op[4]& ~Op[3]& ~Op[2]& Op[1]& ~Op[0];  //000010
  wire i_jal = ~Op[5]& ~Op[4]& ~Op[3]& ~Op[2]& Op[1]& Op[0];  //000011

  assign RegWrite = rtype| i_lw| i_addi| i_ori| i_jal| i_jalr| i_slti| i_lui| i_andi;
  assign MemWrite = i_sw;
  assign ALUSrc = i_lw| i_sw| i_addi| i_ori| i_slti| i_lui| i_andi;
  assign ARegSel = i_sll| i_srl| i_sra;
  assign EXTOp = i_addi| i_lw| i_sw| i_lui| i_andi;

  //RD 00
  //RT 01
  //31register 10
  assign GPRSel[0] = i_lw| i_addi| i_ori| i_lui| i_andi| i_slti;
  assign GPRSel[1] = i_jal| i_jalr;
  
  //ALU 00
  //MEM 01
  //PC 10 
  assign WDSel[0] = i_lw;
  assign WDSel[1] = i_jal| i_jalr;

  //NPC_PLUS4   2'b00
  //NPC_BRANCH  2'b01
  //NPC_JUMP    2'b10
  //NPC_JR      2'b11
  assign NPCOp[0] = (i_beq& Zero)|(i_bne& ~Zero)| i_jr| i_jalr;
  assign NPCOp[1] = i_j| i_jal| i_jr| i_jalr;
  
  //NOP 0000 
  //ADD 0001
  //SUB 0010 
  //AND 0011
  //OR  0100
  //SLT 0101
  //SLTU 0110
  //NOR 0111
  //SLL 1000
  //SRL 1001
  //SRA 1010
  //SLLV 1011
  //SRLV 1100
  //LUI 1101
  assign ALUOp[0] = i_add| i_lw| i_sw| i_addi| i_and| i_slt| i_addu| i_nor| i_srl| i_sllv| i_slti| i_lui| i_andi;
  assign ALUOp[1] = i_sub| i_beq| i_and| i_sltu| i_subu| i_bne| i_nor| i_sra| i_sllv| i_andi;
  assign ALUOp[2] = i_or | i_ori| i_slt| i_sltu| i_nor| i_srlv| i_slti| i_lui;
  assign ALUOp[3] = i_sll| i_sra| i_srl| i_sllv| i_srlv| i_lui;

endmodule