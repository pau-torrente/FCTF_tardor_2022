PROGRAM EXERICICI2
    
    
    IMPLICIT NONE
    
    INTEGER*4 I, J, K, L, SEED
    PARAMETER(L=48)
    INTEGER*4 S(1:L, 1:L), PBC(0:L+1)
    REAL*8 ENERG, ENE, GENRAND_REAL2, TEMP, MAGNE, W(-8:8)
    INTEGER*8 MCTOT, RANDI, RANDJ, IMC, SUM1, SUM2, DE
    
    TEMP = 1.2D0
    SEED = 23457
    MCTOT = 3000

    !---------------------------------------------------------------------------

    CALL INIT_GENRAND(SEED)
    
    OPEN(1, FILE='P1-configuration.conf')

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


            SUM1 = S(PBC(RANDI + 1), PBC(RANDJ)) + S(PBC(RANDI-1), PBC(RANDJ))
            SUM2 = S(PBC(RANDI), PBC(RANDJ + 1)) + S(PBC(RANDI), PBC(RANDJ-1))
            DE = 2*S(PBC(RANDI), PBC(RANDJ))*(SUM1 + SUM2)
            

            IF (DE.LT.0) THEN
                S(PBC(RANDI), PBC(RANDJ)) = -S(PBC(RANDI), PBC(RANDJ))
                ENE = ENE + DE 
                
                
            ELSE IF (DE.GT.0) THEN
                IF ((GENRAND_REAL2()).LT.(W(DE))) THEN
                    S(PBC(RANDI), PBC(RANDJ)) = -S(PBC(RANDI), PBC(RANDJ))
                    ENE = ENE + DE
                END IF
                
            END IF
 

        END DO
        
        WRITE(*,*) "IMC: ", IMC, "ENE", ENE, "ENEBIS", ENERG(S,L,PBC), "MAGNE", MAGNE(S,L)

    END DO 

END PROGRAM EXERICICI2



!########################################################################################

REAL*8 FUNCTION MAGNE(S,L)
    INTEGER*4 S(1:L,1:L), I, J, L
    
    MAGNE=0.0D0
    
    DO I =1,L
        DO J=1,L
            MAGNE=MAGNE+S(i,j)
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

