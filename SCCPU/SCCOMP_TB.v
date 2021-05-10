// testbench for simulation
module SCCOMP_TB();
    
  reg clk, rstn;
  reg [4:0] reg_sel;
  wire [31:0] reg_data;
    
  // instantiation of sccomp    
  SCCOMP U_SCCOMP(
    .clk(clk), .rstn(rstn), .reg_sel(reg_sel), .reg_data(reg_data) 
  );

 	integer foutput;
 	integer counter = 0;
   
  initial 
    begin
      $readmemh( "mips.dat" , U_SCCOMP.U_IM.ROM); // load instructions into instruction memory
      //  $monitor("PC = 0x%8X, instr = 0x%8X", U_SCCOMP.PC, U_SCCOMP.instr); // used for debug
      foutput = $fopen("results.txt");
      clk = 1;
      rstn = 1;
      #5 ;
      rstn = 0;
      #20 ;
      rstn = 1;
      #1000 ;
      reg_sel = 7;
    end
   
  always 
    begin
    #(50) clk = ~clk;
    if (clk == 1'b1) 
      begin
        if ((counter == 1000) || (U_SCCOMP.U_SCPU.PC === 32'hxxxxxxxx)) 
          begin
            $fclose(foutput);
            $stop;
          end
        else
              begin
                counter = counter + 1;
                $display("pc: %h", U_SCCOMP.U_SCPU.PC);
                $display("instr: %h", U_SCCOMP.U_SCPU.instr);
              end
      end
    end
   
endmodule

