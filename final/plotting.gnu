set term pngcairo size 1500,1000 font "Sans,20"

set output "plots/c_vs_T.png"


set xzeroaxis
set yzeroaxis

set ylabel "c_v^*"
set xlabel "T^*"

set title "c_v^* vs T^*"

plot "processed_data.txt" index 0 u 2:(($5-($4)**2)/((12*12)*((($2)**2)))) w linespoints t "L=12", "processed_data.txt" index 1 u 2:(($5-($4)**2)/((24*24)*((($2)**2)))) w linespoints t "L=24", "processed_data.txt" index 2 u 2:(($5-($4)**2)/((36*36)*((($2)**2)))) w linespoints t "L=36", "processed_data.txt" index 3 u 2:(($5-($4)**2)/((48*48)*((($2)**2)))) w linespoints t "L=48", "processed_data.txt" index 4 u 2:(($5-($4)**2)/((60*60)*((($2)**2)))) w linespoints t "L=60", "processed_data.txt" index 5 u 2:(($5-($4)**2)/((72*72)*((($2)**2)))) w linespoints t "L=72"

pause -1

#########################################################################################################################################################################################

set output 'plots/cv_comparison.png'

set xzeroaxis
set yzeroaxis

set ylabel "c_v^*"
set xlabel "T^*"

set title "c_v^* from variance and dE^*/dT^* comparison"
set datafile missing '0.d0'
plot "processed_data.txt" index 4 u 2:($11 == 0.0 ? NaN : $11/(60**2*$12))  lt rgb 'blue' t 'L=60 with dE^*/dT^*', "processed_data.txt" index 4 u 2:(($5-($4)**2)/((60*60)*((($2)**2))))  lt rgb 'red' w linespoints t "L=60 with variance"


pause -1


#########################################################################################################################################################################################

#L, TEMP, SUM, SUME, SUME2, VARE, SUMM, SUMAM, SUMM2, VARM, SUME-PREVSUME, DBLE(PASTINDEX)/1000.D0


set output "plots/x_vs_T.png"

set xzeroaxis
set yzeroaxis

set ylabel "x^*"
set xlabel "T^*"

set title "X^* vs T^*"

plot "processed_data.txt" index 0 u 2:(($9-($8)**2)/((12*12)*((($2))))) w linespoints t "L=12", "processed_data.txt" index 1 u 2:(($9-($8)**2)/((24*24)*((($2))))) w linespoints t "L=24", "processed_data.txt" index 2 u 2:(($9-($8)**2)/((36*36)*((($2))))) w linespoints t "L=36", "processed_data.txt" index 3 u 2:(($9-($8)**2)/((48*48)*((($2))))) w linespoints t "L=48", "processed_data.txt" index 4 u 2:(($9-($8)**2)/((60*60)*((($2))))) w linespoints t "L=60", "processed_data.txt" index 5 u 2:(($9-($8)**2)/((72*72)*((($2))))) w linespoints t "L=72"

pause -1

#######################################################################################################################################################################################




set output "plots/absM_vs_T.png"

set xzeroaxis
set yzeroaxis

set ylabel "<|m^*|>"
set xlabel "T^*"

set title "<|m^*|> vs T^*"

plot "processed_data.txt" index 0 u 2:($8/(12**2)) w linespoints t "L=12", "processed_data.txt" index 1 u 2:($8/(24**2)) w linespoints t "L=24", "processed_data.txt" index 2 u 2:($8/(36**2)) w linespoints t "L=36", "processed_data.txt" index 3 u 2:($8/(48**2)) w linespoints t "L=48", "processed_data.txt" index 4 u 2:($8/(60**2)) w linespoints t "L=60", "processed_data.txt" index 5 u 2:($8/(72**2)) w linespoints t "L=72"

pause -1


###########################################################################################

set output "plots/e_vs_T.png"

set xzeroaxis
set yzeroaxis

set ylabel "<e^*>"
set xlabel "T^*"

set title "<e^*> vs T^*"

plot "processed_data.txt" index 0 u 2:($4/(12**2)) w linespoints t "L=12", "processed_data.txt" index 1 u 2:($4/(24**2)) w linespoints t "L=24", "processed_data.txt" index 2 u 2:($4/(36**2)) w linespoints t "L=36", "processed_data.txt" index 3 u 2:($4/(48**2)) w linespoints t "L=48", "processed_data.txt" index 4 u 2:($4/(60**2)) w linespoints t "L=60", "processed_data.txt" index 5 u 2:($4/(72**2)) w linespoints t "L=72"

pause -1


#########################################################################################



#    L    1/L     TCL_C    TCL_X     DTCL_C    TCL_X     TCL_C-TC    D(TCL_C-TC)     TCL_X-TC    D(TCL_X-TC)       CV      X     |M|X     |X|CV

set output 'plots/lnDt_vs_lnL.png'

set xzeroaxis
set yzeroaxis

set ylabel "ln(Tc_L^*-Tc^*)"
set xlabel "ln(L)"

set title "ln(Tc_L^*-Tc^*) vs ln(L)"


f(x) = -0.1578 -1.0111*x 

g(x) = 0.6934 -0.9931*x

plot 'processed_data.txt' index 6 u (log($1)):(log($7)):(($8)/($7)) w yerrorbars t 'Tc_L^* from c_v^* analysis', 'processed_data.txt' index 6 u (log($1)):(log($9)):(($10)/($9)) w yerrorbars t 'Tc_L^* from x^* analysis', f(x) t 'Regression line: -0.1578 -1.0111*ln(L)', g(x) t'Regression line: 0.6934 -0.9931*ln(L)'

pause -1


##################################################################################################


set output 'plots/lnX_vs_lnL.png'

set xzeroaxis
set yzeroaxis

set ylabel "ln[x^*(Tc_L^*)]"
set xlabel "ln(L)"

set title "ln[x^*(Tc_L^*)] vs ln(L)"

set key bottom right
set pointsize 3


f(x) = -3.0874 +1.7654*x 

plot 'processed_data.txt' index 6 u (log($1)):(log($12)) t 'Data', f(x) t 'Regression line : -3.0874 + 1.7654*ln(L) '

pause -1


#####################################################################################

set output 'plots/lnm_vs_lnL.png'

set xzeroaxis
set yzeroaxis

set ylabel "ln(<|m^*|>(Tc_L^*))"
set xlabel "$ln(L)$"


set title "ln(<|m^*|>(Tc_L^*)) vs ln(L)"

set key top right

f(x) = -0.2484-0.1433*x 

plot 'processed_data.txt' index 6 u (log($1)):(log($13)) t 'Data', f(x) t 'Regression line: -0.2484 - 0.1433*ln(L) '

pause -1


###############################################################


set output 'plots/lncv_vs_lnL.png'

set xzeroaxis
set yzeroaxis

set ylabel "ln[c_v^*(Tc_L^*)]"
set xlabel "ln(L)"

set title "ln[c_v(Tc_L^*)] vs ln(L)"

set key bottom right


f(x) = -0.3342+0.2775*x 

plot 'processed_data.txt' index 6 u (log($1)):(log($11)) t 'Data', f(x) t 'Regression line: -0.3342+0.2275*ln(L)'

pause -1



