

#########################################################################################################################################################################################


set term pngcairo size 1500,1000 font "Sans,30"


set output 'plots/cv_comparisonL48.png'

set xzeroaxis
set yzeroaxis

set ylabel "c_v^*"
set xlabel "T^*"
set pointsize 2


set datafile missing '0.d0'
plot "processed_data.txt" index 3 u 2:($11 == 0.0 ? NaN : $11/(48**2*$12))  lt rgb 'blue' t 'L=48 amb d<e^*>/dT^*', "processed_data.txt" index 3 u 2:(($5-($4)**2)/((48*48)*((($2)**2))))  lt rgb 'red' w linespoints t "L=48 amb variança"


pause -1


set term pngcairo size 1500,1200 font "Sans,35"


set output "plots/c_vs_T_L48.png"

set xzeroaxis
set yzeroaxis

set ylabel "c_v^*"
set xlabel "T^*"


plot "processed_data.txt" index 3 u 2:(($5-($4)**2)/((48*48)*((($2)**2)))):($6/(($1**2)*$3)) w linespoints t "L=48"

pause -1



set output "plots/x_vs_T_L48.png"

set xzeroaxis
set yzeroaxis

set ylabel "x^*"
set xlabel "T^*"


plot "processed_data.txt" index 3 u 2:(($9-($8)**2)/((48*48)*((($2))))) w linespoints t "L=48"

pause -1



set output "plots/M_vs_T_L48.png"

set xzeroaxis
set yzeroaxis

set ylabel "<|m^*|>"
set xlabel "T^*"


plot "processed_data.txt" index 3 u 2:($8/(48**2)):(sqrt(($10)/($3))/(($1)**2)) w yerrorbars t "<|m^*|> per L=48", "processed_data.txt" index 3 u 2:(sqrt($9)/(48**2)):(sqrt(($10)/($3))/(($1)**2)) w yerrorbars t "√(m^*^2) per L=48"

pause -1



set output "plots/e_vs_T_L48.png"

set xzeroaxis
set yzeroaxis

set ylabel "<e^*>"
set xlabel "T^*"




set key bottom right

plot "processed_data.txt" index 3 u 2:($4/(48**2)):(sqrt(($6)/($3))/(($1)**2)) w yerrorbars t "L=48"

pause -1

set font "Sans,20"



#########################################################################################################################################################################################

#L, TEMP, SUM, SUME, SUME2, VARE, SUMM, SUMAM, SUMM2, VARM, SUME-PREVSUME, DBLE(PASTINDEX)/1000.D0

set term pngcairo size 1600,1000 font "Sans,35"


set output "plots/x_vs_T.png"

set xzeroaxis
set yzeroaxis

set ylabel "x^*"
set xlabel "T^*"

set key top right


plot "processed_data.txt" index 0 u 2:(($9-($8)**2)/((12*12)*((($2))))) w linespoints t "L=12", "processed_data.txt" index 1 u 2:(($9-($8)**2)/((24*24)*((($2))))) w linespoints t "L=24", "processed_data.txt" index 2 u 2:(($9-($8)**2)/((36*36)*((($2))))) w linespoints t "L=36", "processed_data.txt" index 3 u 2:(($9-($8)**2)/((48*48)*((($2))))) w linespoints t "L=48", "processed_data.txt" index 4 u 2:(($9-($8)**2)/((60*60)*((($2))))) w linespoints t "L=60", "processed_data.txt" index 5 u 2:(($9-($8)**2)/((72*72)*((($2))))) w linespoints t "L=72"

pause -1

#######################################################################################################################################################################################


set output "plots/c_vs_T.png"


set xzeroaxis
set yzeroaxis

set ylabel "c_v^*"
set xlabel "T^*"


plot "processed_data.txt" index 0 u 2:(($5-($4)**2)/((12*12)*((($2)**2)))):($6/(($1**2)*$3)) w linespoints t "L=12", "processed_data.txt" index 1 u 2:(($5-($4)**2)/((24*24)*((($2)**2)))) w linespoints t "L=24", "processed_data.txt" index 2 u 2:(($5-($4)**2)/((36*36)*((($2)**2)))) w linespoints t "L=36", "processed_data.txt" index 3 u 2:(($5-($4)**2)/((48*48)*((($2)**2)))) w linespoints t "L=48", "processed_data.txt" index 4 u 2:(($5-($4)**2)/((60*60)*((($2)**2)))) w linespoints t "L=60", "processed_data.txt" index 5 u 2:(($5-($4)**2)/((72*72)*((($2)**2)))) w linespoints t "L=72"

pause -1



set output "plots/absM_vs_T.png"

set xzeroaxis
set yzeroaxis

set ylabel "<|m^*|>"
set xlabel "T^*"

set key top right


plot "processed_data.txt" index 0 u 2:($8/(12**2)):(sqrt(($10)/($3))/(($1)**2)) w yerrorbars t "L=12", "processed_data.txt" index 1 u 2:($8/(24**2)):(sqrt(($10)/($3))/(($1)**2)) w yerrorbars t "L=24", "processed_data.txt" index 2 u 2:($8/(36**2)):(sqrt(($10)/($3))/(($1)**2)) w yerrorbars t "L=36", "processed_data.txt" index 3 u 2:($8/(48**2)):(sqrt(($10)/($3))/(($1)**2)) w yerrorbars t "L=48", "processed_data.txt" index 4 u 2:($8/(60**2)):(sqrt(($10)/($3))/(($1)**2)) w yerrorbars t "L=60", "processed_data.txt" index 5 u 2:($8/(72**2)):(sqrt(($10)/($3))/(($1)**2)) w yerrorbars t "L=72"

pause -1


###########################################################################################

set output "plots/e_vs_T.png"

set xzeroaxis
set yzeroaxis

set ylabel "<e^*>"
set xlabel "T^*"


set key bottom right

plot "processed_data.txt" index 0 u 2:($4/(12**2)):(sqrt(($6)/($3))/(($1)**2)) w yerrorbars t "L=12", "processed_data.txt" index 1 u 2:($4/(24**2)):(sqrt(($6)/($3))/(($1)**2)) w yerrorbars t "L=24", "processed_data.txt" index 2 u 2:($4/(36**2)):(sqrt(($6)/($3))/(($1)**2)) w yerrorbars t "L=36", "processed_data.txt" index 3 u 2:($4/(48**2)):(sqrt(($6)/($3))/(($1)**2)) w yerrorbars t "L=48", "processed_data.txt" index 4 u 2:($4/(60**2)):(sqrt(($6)/($3))/(($1)**2)) w yerrorbars t "L=60", "processed_data.txt" index 5 u 2:($4/(72**2)):(sqrt(($6)/($3))/(($1)**2)) w yerrorbars t "L=72"

pause -1


#########################################################################################


set term pngcairo size 1500,1000 font "Sans,25"


set output 'plots/Tcl_vs_1L.png'

#L    1/L     TCL_C    TCL_X     DTCL_C    TCL_X 

set xzeroaxis
set yzeroaxis

set ylabel "Tc_L^*"
set xlabel "1/L"


set key top left
set pointsize 3


f(x) = 2.2681 + 0.8137*x 
g(x) = 2.2675 + 2.0561*x

plot 'processed_data.txt' index 6 u 2:3:5 w yerrorbars t 'Tc_L^* de c_v^*', f(x) t 'Línia de regressió : 2.268 + 0.81*(1/L)', 'processed_data.txt' index 6 u 2:4:6 w yerrorbars t 'Tc_L^* de x^*', g(x) t 'Línia de regressió : 2.268 + 2.06*(1/L)  '

pause -1





#    L    1/L     TCL_C    TCL_X     DTCL_C    TCL_X     TCL_C-TC    D(TCL_C-TC)     TCL_X-TC    D(TCL_X-TC)       CV      X     |M|X     |X|CV




set output 'plots/lnDt_vs_lnL.png'

set xzeroaxis
set yzeroaxis

set ylabel "ln(Tc_L^*-Tc^*)"
set xlabel "ln(L)"

set key top right
set pointsize 3


f(x) = -0.1578 -1.0111*x 

g(x) = 0.6934 -0.9931*x

plot 'processed_data.txt' index 6 u (log($1)):(log($7)):(($8)/($7)) w yerrorbars t 'Tc_L^* de anàlisi de  c_v^*', 'processed_data.txt' index 6 u (log($1)):(log($9)):(($10)/($9)) w yerrorbars t 'Tc_L^* de anàlisi de x^*', f(x) t 'Línia de regressió: -0.16 - 1.01*ln(L)', g(x) t'Línia de regressió: 0.69 - 0.99*ln(L)'

pause -1


##################################################################################################

set term pngcairo size 1500,800 font "Sans,25"


set output 'plots/lnX_vs_lnL.png'

set xzeroaxis
set yzeroaxis

set ylabel "ln[x^*(Tc_L^*)]"
set xlabel "ln(L)"


set key bottom right



f(x) = -3.0874 +1.7654*x 

plot 'processed_data.txt' index 6 u (log($1)):(log($12)) t 'ln[x^*(Tc_L^*)]', f(x) t 'Línia de regressió : -3.087 + 1.765*ln(L) '

pause -1


##################################################################################################





#####################################################################################

set output 'plots/lnm_vs_lnL.png'

set xzeroaxis
set yzeroaxis

set ylabel "ln(<|m^*|>(Tc_L^*))"
set xlabel "ln(L)"


set key top right

f(x) = -0.2484-0.1433*x 

plot 'processed_data.txt' index 6 u (log($1)):(log($13)):(($15)/($13)) w yerrorbars t 'ln(<|m^*|>(Tc_L^*))', f(x) t 'Línia de regressió: -0.25 - 0.143*ln(L) '

pause -1


###############################################################


set output 'plots/lncv_vs_lnL.png'

set xzeroaxis
set yzeroaxis

set ylabel "ln[c_v^*(Tc_L^*)]"
set xlabel "ln(L)"

set key bottom right


f(x) = -0.3342+0.2775*x 

plot 'processed_data.txt' index 6 u (log($1)):(log($11)) t 'ln[c_v(Tc_L^*)]', f(x) t 'Línia de regressió: -0.3342 + 0.2275*ln(L)'

pause -1



#################################################################################################################

Tc = 2.268
G = 1.77
B = 0.143

set term pngcairo size 1500,1200 font "Sans,33"

set output "plots/x_ffs.png"


set xzeroaxis
set yzeroaxis

set ylabel "x^*·L^{-{/Symbol g}/v}"
set xlabel "L^{1/v}(T^*-Tc^*)/Tc^*"

set pointsize 1

set key top right

Tc = 2.268

#L, TEMP, SUM, SUME, SUME2, VARE, SUMM, SUMAM, SUMM2, VARM, SUME-PREVSUME, DBLE(PASTINDEX)/1000.D0

plot "processed_data.txt" index 0 u (($1)*($2-Tc)/Tc):((($9-($8)**2)/((($1)**2)*((($2)))))*(($1)**-G)) w linespoints t "L=12", "processed_data.txt" index 1 u (($1)*($2-Tc)/Tc):((($9-($8)**2)/((($1)**2)*((($2)))))*(($1)**-G)) w linespoints t "L=24", "processed_data.txt" index 2 u (($1)*($2-Tc)/Tc):((($9-($8)**2)/((($1)**2)*((($2)))))*(($1)**-G)) w linespoints t "L=36", "processed_data.txt" index 3 u (($1)*($2-Tc)/Tc):((($9-($8)**2)/((($1)**2)*((($2)))))*(($1)**-G)) w linespoints t "L=48", "processed_data.txt" index 4 u (($1)*($2-Tc)/Tc):((($9-($8)**2)/((($1)**2)*((($2)))))*(($1)**-G)) w linespoints t "L=60", "processed_data.txt" index 5 u (($1)*($2-Tc)/Tc):((($9-($8)**2)/((($1)**2)*((($2)))))*(($1)**-G)) w linespoints t "L=72"

pause -1


#################################################################################################################


set output "plots/m_ffs.png"


set xzeroaxis
set yzeroaxis

set ylabel "<|m^*|>^*·L^{-{/Symbol b}/v}"
set xlabel "L^{1/v}(T^*-Tc^*)/Tc^*"

set pointsize 1



#L, TEMP, SUM, SUME, SUME2, VARE, SUMM, SUMAM, SUMM2, VARM, SUME-PREVSUME, DBLE(PASTINDEX)/1000.D0

plot "processed_data.txt" index 0 u (($1)*($2-Tc)/Tc):(($8/(($1)**2))*(($1)**B)) w linespoints t "L=12", "processed_data.txt" index 1 u (($1)*($2-Tc)/Tc):(($8/(($1)**2))*(($1)**B)) w linespoints t "L=24", "processed_data.txt" index 2 u (($1)*($2-Tc)/Tc):(($8/(($1)**2))*(($1)**B)) w linespoints t "L=36", "processed_data.txt" index 3 u (($1)*($2-Tc)/Tc):(($8/(($1)**2))*(($1)**B)) w linespoints t "L=48", "processed_data.txt" index 4 u (($1)*($2-Tc)/Tc):(($8/(($1)**2))*(($1)**B)) w linespoints t "L=60", "processed_data.txt" index 5 u (($1)*($2-Tc)/Tc):(($8/(($1)**2))*(($1)**B)) w linespoints t "L=72"

pause -1



