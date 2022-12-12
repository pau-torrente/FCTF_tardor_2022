PROGRAM MC2   
    IMPLICIT NONE
    
    INTEGER*4 I, J, K, L, NSEED, SEED0, SEED
    PARAMETER(L=48)
    INTEGER*4 S(1:L, 1:L), PBC(0:L+1)
    REAL*8 ENERG, ENE, GENRAND_REAL2, TEMP, MAGNE, MAG, W(-8:8)
    INTEGER*8 MCTOT, MCINI, MCD, RANDI, RANDJ, IMC, SUM1, SUM2, DE, TEMPINDEX
    REAL*8 SUM, SUME, SUME2, SUMM, SUMM2, SUMAM, VARE, VARM
    
    
    
    NSEED = 10
    SEED0 = 117654
    MCTOT = 10000
    MCINI = 1000
    MCD = 10

    OPEN(1, FILE = "pau_torrente_badia.res", ACCESS = 'APPEND')

    DO TEMPINDEX = 15, 20, 5

        TEMP = DBLE(TEMPINDEX)/10.D0
        
        DO SEED = SEED0, SEED0+NSEED-1, 1

            WRITE(*,*) "LLAVOR = ", SEED


            SUM=0.0D0
            SUME=0.0D0
            SUME2=0.0D0
            SUMM=0.0D0
            SUMM2=0.0D0
            SUMAM=0.0D0

            !---------------------------------------------------------------------------

            CALL INIT_GENRAND(SEED)
            !---------------------------------------------------------------------------

            DO I = 1,L
                PBC(I) = I
            END DO 

            PBC(0) = L
            PBC(L+1) = 1

            !---------------------------------------------------------------------------

            DO DE = -8, 8
                W(DE) = DEXP(-DBLE(DE)/TEMP)
            END DO 

            !---------------------------------------------------------------------------


            DO I = 1,L
                DO K = 1,L
                    IF (GENRAND_REAL2().LT.0.5D0) THEN
                        S(I,K) = 1
                    ELSE
                        S(I,K) = -1
                    ENDIF
                    
                ENDDO
            ENDDO
            
            !-------------------------------------------------------------------------------

            ENE = ENERG(S,L,PBC)

            DO IMC = 1, MCTOT

                DO J = 1, L**2

                    RANDI = INT(GENRAND_REAL2()*(L))+1
                    RANDJ = INT(GENRAND_REAL2()*(L))+1

                    SUM1 = S(PBC(RANDI + 1), RANDJ) + S(PBC(RANDI-1), RANDJ)
                    SUM2 = S(RANDI, PBC(RANDJ + 1)) + S(RANDI, PBC(RANDJ-1))
                    DE = 2*S(RANDI, RANDJ)*(SUM1 + SUM2)

                    IF (DE.LE.0) THEN
                        S(RANDI, RANDJ) = -S(RANDI, RANDJ)
                        ENE = ENE + DE 
                        
                    ELSE IF (DE.GT.0) THEN
                        IF ((GENRAND_REAL2()).LT.(W(DE))) THEN
                            S(RANDI, RANDJ) = -S(RANDI, RANDJ)
                            ENE = ENE + DE
                        END IF

                    ENDIF
        

                END DO

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

            
            
            
        
        END DO

        SUME = SUME/SUM
        SUME2 = SUME2/SUM
        SUMM = SUMM/SUM
        SUMAM = SUMAM/SUM
        SUMM2 = SUMM2/SUM
        VARE = SUME2-SUME*SUME
        VARM = SUMM2-SUMM*SUMM

        
        

        
        WRITE(1,*) L, TEMP, SUM, SUME, SUME2, VARE, SUMM, SUMAM, SUMM2, VARM

    END DO 

    


END PROGRAM MC2



!########################################################################################

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

REAL*8 FUNCTION ENERG(S, L, PBC)
    IMPLICIT NONE
    INTEGER*4 S(1:L,1:L),PBC(0:L+1),I,J,L

    ENERG = 0.D0
    
    DO I = 1, L
        DO J= 1 ,L
            ENERG = ENERG - S(I, J)*(S(I, PBC(J+1)) + S(PBC(I+1), J))  !WE ONLY CONSIDER THE +1 TERMS TO NOT COUNT INTERACTIONS TWICE AND MAKE HALF THE CALCULATIONS
        ENDDO
    ENDDO

END 