library verilog;
use verilog.vl_types.all;
entity EXT is
    port(
        IMM16           : in     vl_logic_vector(15 downto 0);
        EXTOp           : in     vl_logic;
        IMM32           : out    vl_logic_vector(31 downto 0)
    );
end EXT;
