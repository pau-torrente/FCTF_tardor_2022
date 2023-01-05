set term pngcairo size 1000,500
set output "plot1_diff_temp_energy.png"


set xzeroaxis
set yzeroaxis

set ylabel "e = E/N"
set xlabel "Pas Montecarlo"

set rmargin 20
set key at screen 1, graph 1

N = 48*48

plot "SIM-L-048-MCTOT-10K-TEMP-1500K.out" u 2:($4/N) t "T* = 1.5" w l, "SIM-L-048-MCTOT-10K-TEMP-1800K.out" u 2:($4/N) t "T* = 1.8" w l, "SIM-L-048-MCTOT-10K-TEMP-2500K.out" u 2:($4/N) t "T* = 2.5" w l, "SIM-L-048-MCTOT-10K-TEMP-3500K.out" u 2:($4/N) t "T* = 3.5" w l, "SIM-L-048-MCTOT-10K-TEMP-4500K.out" u 2:($4/N) t "T* = 4.5" w l


pause -1


set term pngcairo size 1000,500
set output "plot1_diff_temp_magne.png"


set xzeroaxis
set yzeroaxis

set xlabel "Pas Montecarlo"
set ylabel "m* = M*/N"

set rmargin 20
set key at screen 1, graph 1

N = 48*48

plot "SIM-L-048-MCTOT-10K-TEMP-1500K.out" u 2:($8/N) t "T* = 1.5" w l, "SIM-L-048-MCTOT-10K-TEMP-1800K.out" u 2:($8/N) t "T* = 1.8" w l, "SIM-L-048-MCTOT-10K-TEMP-2500K.out" u 2:($8/N) t "T* = 2.5" w l, "SIM-L-048-MCTOT-10K-TEMP-3500K.out" u 2:($8/N) t "T* = 3.5" w l, "SIM-L-048-MCTOT-10K-TEMP-4500K.out" u 2:($8/N) t "T* = 4.5" w l


pause -1
