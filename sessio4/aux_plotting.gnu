set term pngcairo size 1000,500
set output "c_vs_T.png"


set xzeroaxis
set yzeroaxis

set ylabel "Cv"
set xlabel "T"

set title "Cv vs T using 0.01 T-increments and L=12"

N = 12*12

set xrange [1:3.5]

file = "data_files/pau_torrente_badia.res"

plot file u 2:(($5-($4)**2)/(N*(($2)**2))) w linespoints t ""

pause -1
