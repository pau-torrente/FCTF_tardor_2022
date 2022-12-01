set term pngcairo size 1000,500
set output "plot1_diff_temp_energy.png"


set xzeroaxis
set yzeroaxis

set ylabel "E"
set xlabel "IMC"

set rmargin 20
set key at screen 1, graph 1

N = 48*48

plot "SIM-L-048-MCTOT-10K-TEMP-1500K.out" u 2:($4/N) t "Temp = 1.5K" w l, "SIM-L-048-MCTOT-10K-TEMP-1800K.out" u 2:($4/N) t "Temp = 1.8K" w l, "SIM-L-048-MCTOT-10K-TEMP-2500K.out" u 2:($4/N) t "Temp = 2.5K" w l, "SIM-L-048-MCTOT-10K-TEMP-3500K.out" u 2:($4/N) t "Temp = 3.5K" w l, "SIM-L-048-MCTOT-10K-TEMP-4500K.out" u 2:($4/N) t "Temp = 4.5K" w l


pause -1


set term pngcairo size 1000,500
set output "plot1_diff_temp_magne.png"


set xzeroaxis
set yzeroaxis

set xlabel "Magnetization"
set ylabel "E"

set rmargin 20
set key at screen 1, graph 1

N = 48*48

plot "SIM-L-048-MCTOT-10K-TEMP-1500K.out" u 2:($8/N) t "Temp = 1.5K" w l, "SIM-L-048-MCTOT-10K-TEMP-1800K.out" u 2:($8/N) t "Temp = 1.8K" w l, "SIM-L-048-MCTOT-10K-TEMP-2500K.out" u 2:($8/N) t "Temp = 2.5K" w l, "SIM-L-048-MCTOT-10K-TEMP-3500K.out" u 2:($8/N) t "Temp = 3.5K" w l, "SIM-L-048-MCTOT-10K-TEMP-4500K.out" u 2:($8/N) t "Temp = 4.5K" w l


pause -1
