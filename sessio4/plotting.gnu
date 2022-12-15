set term pngcairo size 1000,500
set output "c_vs_T.png"


set xzeroaxis
set yzeroaxis

set ylabel "Cv"
set xlabel "T"

set title "Cv vs T using 0.1T increments and L=48"

N = 48*48

plot "pau_torrente_badia.res" u 2:(($5-($4)**2)/(N*(($2)**2))) w linespoints t ""

pause -1



set output "x_vs_T.png"

set xzeroaxis
set yzeroaxis

set ylabel "X"
set xlabel "T"

set title "X vs T using 0.1T increments and L=48"

N = 48*48

plot "processed_pau_torrente_badia.txt" index 0 u 2:(($9-($7)**2)/(N*$2)) w linespoints t ""

pause -1