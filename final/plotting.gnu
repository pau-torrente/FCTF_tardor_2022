set term pngcairo size 1500,1000
set output "c_vs_T.png"


set xzeroaxis
set yzeroaxis

set ylabel "Cv"
set xlabel "T"

set title "Cv vs T"


N = (24*24)

plot "processed_pau_torrente_badia2.txt" index 0 u 2:(($5-($4)**2)/((12*12)*(($2)**2))) w linespoints t "L=12", "processed_pau_torrente_badia2.txt" index 1 u 2:(($5-($4)**2)/((24*24)*(($2)**2))) w linespoints t "L=24", "processed_pau_torrente_badia2.txt" index 2 u 2:(($5-($4)**2)/((36*36)*(($2)**2))) w linespoints t "L=36", "processed_pau_torrente_badia2.txt" index 3 u 2:(($5-($4)**2)/((48*48)*(($2)**2))) w linespoints t "L=48", "processed_pau_torrente_badia2.txt" index 4 u 2:(($5-($4)**2)/((60*60)*(($2)**2))) w linespoints t "L=60", "processed_pau_torrente_badia2.txt" index 5 u 2:(($5-($4)**2)/((72*72)*(($2)**2))) w linespoints t "L=72"

pause -1



set output "x_vs_T.png"

set xzeroaxis
set yzeroaxis

set ylabel "X"
set xlabel "T"

set title "X vs T"

plot "processed_pau_torrente_badia2.txt" index 0 u 2:(($9-($7)**2)/((12*12)*(($2)**2))) w linespoints t "L=12", "processed_pau_torrente_badia2.txt" index 1 u 2:(($9-($7)**2)/((24*24)*(($2)**2))) w linespoints t "L=24", "processed_pau_torrente_badia2.txt" index 2 u 2:(($9-($7)**2)/((36*36)*(($2)**2))) w linespoints t "L=36", "processed_pau_torrente_badia2.txt" index 3 u 2:(($9-($7)**2)/((48*48)*(($2)**2))) w linespoints t "L=48", "processed_pau_torrente_badia2.txt" index 4 u 2:(($9-($7)**2)/((60*60)*(($2)**2))) w linespoints t "L=60", "processed_pau_torrente_badia2.txt" index 5 u 2:(($9-($7)**2)/((72*72)*(($2)**2))) w linespoints t "L=72"

pause -1