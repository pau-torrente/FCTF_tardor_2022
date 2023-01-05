
! SIMULACIO MONTECARLO DEL MODEL D'ISING 2D
! PAU TORRENTE BADIA - TARDOR 2022

! EL SEGÜENT CODI DE FORTRAN 2008 ITERA SOBRE TEMPERATURES I MIDES DE SISTEMA ESTIMANT VALORS ESPERATS I VARIANÇES DE 
! LES MAGNITUDS TERMODMÀMIQUES DEL SISTEMA.

! ESTÀ PENSAT AL VOLTANT DE LA PARAL·LELITZACIÓ DEL BUCLE DE TEMPERATURES. TOT L'INTERVAL T = (1.64, 2.90) S'HA DIVIDIT 
! EN 20 INTERVALS COMPILANT 20 PROGRAMES DIFERENTS PER EXECUTAR-LOS EN PARALE·LEL. PER TAL DE CARACTERITZAR EL MILLOR
! POSSIBLE EL PUNT CRÍTIC, S'HAN CALCULAT ELS INTERVALS [1.64, 2.00] I [2.54, 2.90] EN SALTS DE 0.04 (2 TEMPERATURES PER NUCLI 
! I PER MIDA) I L'INTERVAL [2.005, 2.500] EN SALTS DE 0.005 (5 TEMPERATURES PER NUCLI I PER MIDA)
! EL SEGÜENT CODI DONCS, ES CORRESPON A UN D'AQUESTS 20 PROGRAMES ÚNICAMENT. PER GENERAR LA RESTA NOMÉS CAL CANVIAR ALGUNES
! ANOTACIONS QUE INDIQUEN QUÈ S'ESTÀ CALCULANT I ON, I L'INTERVAL DE TEMPERATURES

! TOT EL PROCESSAMENT DE LES DADES S'HA REALITZAT EN PYTHON I LES GRÀFIQUES S'HAN GENERAT AMB GNUPLOT

!################################################################################################################################


PROGRAM MC3  
    
    
    ! INICIALITZEM TOTES LES VARIABLES DEL PROGRAMA PRINCIPAL I DEFINIM QUINES LLAVORS I PASSOS DE MONTECARLO FAREM SERVIR

    IMPLICIT NONE
    
    INTEGER*4 :: I, J, K, L, NSEED, SEED0, SEED
    INTEGER*4, ALLOCATABLE :: S(:,:), PBC(:)
    REAL*8 :: ENERG, ENE, GENRAND_REAL2, TEMP, MAGNE, MAG, W(-8:8)
    INTEGER*8 :: MCTOT, MCINI, MCD, RANDI, RANDJ, IMC, SUM1, SUM2, DE, ITINDEX, FTINDEX, PASTINDEX, TEMPINDEX
    REAL*8 :: SUM, PREVSUME, SUME, SUME2, SUMM, SUMM2, SUMAM, VARE, VARM
    REAL*4 :: TIME1, TIME2
    
    NSEED = 200
    SEED0 = 117654
    MCTOT = 60000
    MCINI = 10000
    MCD = 20

    ! S'OBRE EL FIXTER DE DADES, ÚNIC PER CADA EXECUTABLE (EL CODI DE PYTHON DESPRÉS HO AJUNTA I ORDENA TOT), ES DEFINEIX
    ! EL RANG DE TEMPERATURES I ELS SALTS AMB ELS QUE TREBALLA EL PROGRAMA ACTUAL, I S'INDICA PER PANTALLA QUIN NUCLI
    ! CORRE EL PROGRAM I QUÈ ES EL QUE ESTÀ CALCULANT


    OPEN(1, FILE = "data/C5_1960_2000.res")  

    WRITE(*,*) "CORE 5 : Temperature from 1.960 to 2.000 in 0.040 increments"

    ITINDEX = 1960
    FTINDEX = 2000
    PASTINDEX = 40

    CALL CPU_TIME(TIME1)

    ! S'INICIA EL BUCLE SOBRE LES MIDES DEL SISTEMA, INDICANT PER PANTALLA PER QUINA L VA EL PROGRAMA I ES DONA DIMENSIÓ
    ! A LA MATRIU DE SPINS I AL VECTOR DE CONDICIONS PERIÒDIQUES DE CONTORN
    
    DO L = 12, 72, 12

        WRITE(*,*) " "
        WRITE(*,*) "######################################"
        WRITE(*,*) " "
        WRITE(*,*) "-------------L = ", L, " -------------"
        WRITE(*,*) " "

        ALLOCATE(S(1:L,1:L), PBC(0:L+1))

        ! S'INICIALITZA LA VARIABLE PREVSUME A 0, QUE ES FA SERVIR DESPRÉS PER CALCULAR DE/DT I ES COMENÇA EL BUCLE DE 
        ! TEMPERATURES, IMPRIMINT PER PATNTALLA QUINA T S'ESTÀ CALCULANT PER SEGUIR EL PROGRÉS DEL PROGRAMA

        PREVSUME = 0.D0

        DO TEMPINDEX = ITINDEX, FTINDEX, PASTINDEX

            TEMP = DBLE(TEMPINDEX)/1000.D0
            WRITE(*,*) "Temperature = ", TEMP
            
            ! S'INICIALITZEN A 0 LES VARIABLES DE SUMES QUE AL FINAL SERVIRAN PER FER ELS PROMITJOS I ES COMENÇA EL 
            ! BUCLE DE LLAVORS PER TAL D'EXPLORAR EL MÀXIM POSSIBLE DE L'ESPAI FÀSIC DEL SISTEMA

            SUM=0.0D0
            SUME=0.0D0
            SUME2=0.0D0
            SUMM=0.0D0
            SUMM2=0.0D0
            SUMAM=0.0D0

            
            
            DO SEED = SEED0, SEED0+NSEED-1, 1

                ! SE LI DONA LA LLAVOR AL GENERADOR DE NOMBRES ALEATORIS, I ES DEFINEIXEN ELS VECTORS DE CONDICIONS PERIÒDIQUES
                ! CONTORN I DE PESOS DE BOLTZMANN, I LA MATRIU DE SPINS S'INICIALITZA AMB TOTS ELS SPINS ORIENTATS DE MANERA 
                ! TOTALMENT ALEATÒRIA

                CALL INIT_GENRAND(SEED)
                

                DO I = 1,L
                    PBC(I) = I
                END DO 

                PBC(0) = L
                PBC(L+1) = 1

                
                DO DE = -8, 8
                    W(DE) = DEXP(-DBLE(DE)/TEMP)
                END DO 

                

                DO I = 1,L
                    DO K = 1,L
                        IF (GENRAND_REAL2().LT.0.5D0) THEN
                            S(I,K) = 1
                        ELSE
                            S(I,K) = -1
                        ENDIF
                        
                    ENDDO
                ENDDO
                
                ! ES CALCULA L'ENERGIA ABANS DE FER CAP CANVI I S'INICIA EL BUCLE DE PASSES DE MONTECARLO 

                ENE = ENERG(S,L,PBC)

                DO IMC = 1, MCTOT

                    DO J = 1, L**2  ! A CADA PASSA ES FA EL PROCÉS D'ACCEPTACIÓ-REBUIG N=L*L COPS

                        RANDI = INT(GENRAND_REAL2()*(L))+1  !ES TRIA DE MANERA ALEATÒRIA UN SPIN, I ES CALCULA
                        RANDJ = INT(GENRAND_REAL2()*(L))+1  ! EL CANVIA D'ENERGIA "DE" QUE SUPOSARIA GIRAR-LO

                        SUM1 = S(PBC(RANDI + 1), RANDJ) + S(PBC(RANDI-1), RANDJ)
                        SUM2 = S(RANDI, PBC(RANDJ + 1)) + S(RANDI, PBC(RANDJ-1))
                        DE = 2*S(RANDI, RANDJ)*(SUM1 + SUM2)

                        IF (DE.LE.0) THEN                         ! ES FA EL PROCÉS D'ACCEPTACIÓ-REBUIG SEGONS
                            S(RANDI, RANDJ) = -S(RANDI, RANDJ)    ! A PARTIR DEL VALOR DE "DE"
                            ENE = ENE + DE 
                            
                        ELSE IF (DE.GT.0) THEN
                            IF ((GENRAND_REAL2()).LT.(W(DE))) THEN
                                S(RANDI, RANDJ) = -S(RANDI, RANDJ)
                                ENE = ENE + DE
                            END IF

                        ENDIF
            
                    END DO

                    ! PER ÚLTIM, S'AFEGEIXEN ELS VALORS ALS SUMATORIS QUE S'HAN INICIALITZANT ABANS A 0.0
                    ! NOMÉS CADA "MCD" PASSES DE MONTECARLO

                    IF ((IMC.GT.MCINI).AND.(MCD*(IMC/MCD).EQ.IMC)) THEN  

                        MAG = MAGNE(S,L)
                        SUM = SUM + 1.0D0
                        SUME = SUME + ENE
                        SUME2 = SUME2 + ENE*ENE
                        SUMM = SUMM + MAG
                        SUMAM = SUMAM + ABS(MAG)
                        SUMM2 = SUMM2 + MAG*MAG
                    
                    END IF 
                    

                END DO

            !-----------------------------------------------------------------------------------------

            
            END DO

            ! UN COP S'HAN RECORREGUT TOTES LES LLAVORS, CADASCUNA AMB LES SEVES PASSES DE MONTECARLO, 
            ! ES FAN ELS PROMITJOS I S'ESCRIUEN EN EL FITXER DE DADES PER LA CORRESPONENT MIDA DEL SISTEMA
            ! I TEMPERATURA. 
            ! S'AFEGEIX UN IF PER CALCULAR LES VARIACIONS D'ENERGIA, SEGONS SI ENS TROBEM EN EL PRIMER PAS DE 
            ! TEMPERATURA O NO. EN ELS CASOS ON LA TEMPERATURA ES LA PRIMERA DEL BUCLE, COM QUE NO TÉ UN ALTRE
            ! VALOR ANTERIOR PER FER LA COMPARACIÓ DE/DT, S'ESCRIU UN 0 AL FITXER DE DADES, QUE DESPRÉS ES 
            ! DESCARTA A L'HORA DE GRAFICAR LES DADES

            SUME = SUME/SUM
            SUME2 = SUME2/SUM
            SUMM = SUMM/SUM
            SUMAM = SUMAM/SUM
            SUMM2 = SUMM2/SUM
            VARE = SUME2-SUME*SUME
            VARM = SUMM2-SUMM*SUMM

            IF (ABS(PREVSUME-0.D0).LT.(1.D-8)) THEN

                WRITE(1,*) L, TEMP, SUM, SUME, SUME2, VARE, SUMM, SUMAM, SUMM2, VARM, 0.D0, DBLE(PASTINDEX)/1000.D0

            ELSE 

                WRITE(1,*) L, TEMP, SUM, SUME, SUME2, VARE, SUMM, SUMAM, SUMM2, VARM, SUME-PREVSUME, DBLE(PASTINDEX)/1000.D0
            
            END IF

            PREVSUME = SUME  !S'ACTUALITZA LA VARIABLE PREVSUME AMB EL L'ÚLTIM VALOR DE L'ENERGIA CALCULAT

            !-----------------------------------------------------------------------------------------------------

        END DO

        ! UN COP HA ACABAT LA PASSA PER "L", ES TREU LA DIMENSIÓ ALS VECTORS I LA MATRIU DE SPINS PER PODER-LOS
        ! TORNAR A DIMENSIONAR AL SEGÜENT PAS

        IF ((ALLOCATED(S)).AND.(ALLOCATED(PBC))) THEN
            DEALLOCATE(S)
            DEALLOCATE(PBC)
        END IF 

    END DO 

    CALL CPU_TIME(TIME2)
    WRITE(*,*) 'CPUTIME = ', TIME2-TIME1

END PROGRAM MC3



!########################################################################################

! FUNCIÓ QUE CALCULA LA MAGNETITZACIÓ TOTAL DEL SISTEMA SUMANT ELS VALORS DE TOTS ELS SPINS DE 
! LA MATRIU S


REAL*8 FUNCTION MAGNE(S,L)
    INTEGER*4 S(1:L,1:L), I, J, L
    
    MAGNE=0.0D0
    
    DO I =1,L
        DO J=1,L
            MAGNE=MAGNE+S(I,J)
        ENDDO
    ENDDO

END

!########################################################################################

! FUNCIÓ QUE CALCULA L'ENERGIA A PRIMERS VEÏNS ASSOCIADA A LA MATRIU S

REAL*8 FUNCTION ENERG(S, L, PBC)
    IMPLICIT NONE
    INTEGER*4 S(1:L,1:L),PBC(0:L+1),I,J,L

    ENERG = 0.D0
    
    DO I = 1, L
        DO J= 1 ,L
            ENERG = ENERG - S(I, J)*(S(I, PBC(J+1)) + S(PBC(I+1), J))  
        ENDDO
    ENDDO

END 