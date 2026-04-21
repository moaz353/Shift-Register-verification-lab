vlib work

vlog -f src_files.list +cover -covercells

vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover 

add wave /top/shift_reg_if/*

coverage save top.ucdb -onexit  -du shift_reg

run -all

# functional coverage 
coverage report -detail -cvg -directive -comments -output "./Reports/func_coverage_counter.rpt"

# code coverage 
vcover report top.ucdb -details -all -output  "./Reports/coverage_shift_reg.rpt"
##################################################################### ## after finishing simulation ;;
