# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Administrator/Desktop/test1/project_1/project_1.cache/wt [current_project]
set_property parent.project_path C:/Users/Administrator/Desktop/test1/project_1/project_1.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Users/Administrator/Desktop/test1/project_1/project_1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/EXE.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/EXT.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/ID.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/MEM.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/PC.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/RF.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/WB.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/ctrl_encode_def.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/alu.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/ctrl.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/dm.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/im.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/mux.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/sccpu.v
  C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/sources_1/imports/test/sccomp.v
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/constrs_1/new/XDC.xdc
set_property used_in_implementation false [get_files C:/Users/Administrator/Desktop/test1/project_1/project_1.srcs/constrs_1/new/XDC.xdc]


synth_design -top sccomp -part xc7a100tcsg324-1


write_checkpoint -force -noxdef sccomp.dcp

catch { report_utilization -file sccomp_utilization_synth.rpt -pb sccomp_utilization_synth.pb }
