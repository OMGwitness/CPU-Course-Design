# CPU设计
本项目为武汉大学计算机学院本科二年级“计算机组成与设计课程设计”课程的代码集合，用到的软件有```Modelsim```、```Vivado```和```MARS```，项目分为单周期CPU和流水线CPU两部分，本项目中的命名分别为```SCCPU(Single Cycle CPU)```和```PLCPU(Pipeline CPU)```，其中流水线CPU实现了下入```Nexys DDR```开发板的学号排序，两种CPU均实现了下列指令：
- ```add/sub/and/or/slt/sltu/addu/subu```
- ```addi/ori/lw/sw/beq```
- ```j/jal```
- ```sll/nor/lui/slti/bne/andi/srl/sllv/srlv/jr/jalr```