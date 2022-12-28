set term pngcairo size 1500,1000 font "Sans,15"

set output "c_vs_T.png"


set xzeroaxis
set yzeroaxis

set ylabel "Cv"
set xlabel "T"

set title "Cv vs T"

plot "processed_data.txt" index 0 u 2:(($5-($4)**2)/((12*12)*((($2)**2)))) w linespoints t "L=12", "processed_data.txt" index 1 u 2:(($5-($4)**2)/((24*24)*((($2)**2)))) w linespoints t "L=24", "processed_data.txt" index 2 u 2:(($5-($4)**2)/((36*36)*((($2)**2)))) w linespoints t "L=36", "processed_data.txt" index 3 u 2:(($5-($4)**2)/((48*48)*((($2)**2)))) w linespoints t "L=48", "processed_data.txt" index 4 u 2:(($5-($4)**2)/((60*60)*((($2)**2)))) w linespoints t "L=60", "processed_data.txt" index 5 u 2:(($5-($4)**2)/((72*72)*((($2)**2)))) w linespoints t "L=72"

pause -1

#########################################################################################################################################################################################

set output 'cv_comparison.png'

set xzeroaxis
set yzeroaxis

set ylabel "Cv"
set xlabel "T"

set title "Cv  from variance and dE/dT comparison"
set datafile missing '0.d0'
plot "processed_data.txt" index 4 u 2:($11 == 0.0 ? NaN : $11/(60**2*$12))  lt rgb 'blue' t 'L=60 with dE/dT', "processed_data.txt" index 4 u 2:(($5-($4)**2)/((60*60)*((($2)**2))))  lt rgb 'red' w linespoints t "L=60 with variance"


pause -1


#########################################################################################################################################################################################

#L, TEMP, SUM, SUME, SUME2, VARE, SUMM, SUMAM, SUMM2, VARM, SUME-PREVSUME, DBLE(PASTINDEX)/1000.D0


set output "x_vs_T.png"

set xzeroaxis
set yzeroaxis

set ylabel "X"
set xlabel "T"

set title "X vs T"

plot "processed_data.txt" index 0 u 2:(($9-($8)**2)/((12*12)*((($2))))) w linespoints t "L=12", "processed_data.txt" index 1 u 2:(($9-($8)**2)/((24*24)*((($2))))) w linespoints t "L=24", "processed_data.txt" index 2 u 2:(($9-($8)**2)/((36*36)*((($2))))) w linespoints t "L=36", "processed_data.txt" index 3 u 2:(($9-($8)**2)/((48*48)*((($2))))) w linespoints t "L=48", "processed_data.txt" index 4 u 2:(($9-($8)**2)/((60*60)*((($2))))) w linespoints t "L=60", "processed_data.txt" index 5 u 2:(($9-($8)**2)/((72*72)*((($2))))) w linespoints t "L=72"

pause -1

#######################################################################################################################################################################################
