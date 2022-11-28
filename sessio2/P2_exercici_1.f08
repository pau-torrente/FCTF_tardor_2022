PROGRAM EXERICICI1
    
    
    IMPLICIT NONE
    
    INTEGER*4 I, J, L, SEED
    PARAMETER(L=48)
    INTEGER*2 S(1:L, 1:L)
    INTEGER*4 PBC(0:L+1)
    INTEGER*8 ENERG, MAGNE
    REAL*8 GENRAND_REAL2
    

    SEED = 23457
    CALL INIT_GENRAND(SEED)
    
    OPEN(1, FILE='P1-configuration.conf')

    PBC(0) = L
    PBC(L+1) = 1
    DO I = 1,L
        PBC(I) = I
    END DO 

    DO I = 1,L
        DO J = 1,L
            IF (GENRAND_REAL2().LT.0.5D0) THEN
                S(I,J) = 1
                WRITE(1, *) I, J
            ELSE
                S(I,J) = -1
            ENDIF
        ENDDO
    ENDDO
   
    WRITE(*,*) "MAGNETIZATION", MAGNE(S,L)

    WRITE(*,*) "ENERGY", ENERG(S,L,PBC)

    DO I = 1,L
        DO J = 1,L
                S(I,J) = -1
        ENDDO
    ENDDO

    WRITE(*,*) "CHECKING THE GROUNDSTATE WITH ALL SPINS POINTING IN THE SAME DIRECTION"

    WRITE(*,*) "MAGNETIZATION", MAGNE(S,L)

    WRITE(*,*) "ENERGY", ENERG(S,L,PBC)

    WRITE(*,*) "2*L*L", -2*L*L

    

    ! we get a value of -60, which is pretty close to the expected values of 0,
    ! and relative to the max/min value of +-96*96, it is a low enough value to 
    ! consider it close to the expected value = 0



END PROGRAM EXERICICI1

INTEGER*8 FUNCTION MAGNE(S,L)
    INTEGER*2 S(1:L,1:L)
    INTEGER*4 I,J,L
    INTEGER*8 MAG
    MAG=0.0D0

    
    DO I =1,L
        DO J=1,L
            MAG=MAG+S(i,j)
        ENDDO
    ENDDO
    

    MAGNE=MAG
    RETURN
    
END

INTEGER*8 FUNCTION ENERG(S, L, PBC)
    INTEGER*2 S(1:L,1:L)
    INTEGER*4 I,J,L,PBC(0:L+1)
    INTEGER*8 ENERGY  
    ENERGY = 0.D0

    
    DO I = 1, L
        DO J= 1 ,L
            ENERGY = ENERGY - S(I, J)*S(I, PBC(J+1)) - S(I, J)*S(PBC(I+1), J)   !WE ONLY CONSIDER THE +1 TERMS TO NOT COUNT INTERACTIONS TWICE AND MAKE HALF THE CALCULATIONS
        ENDDO
    ENDDO

    ENERG = ENERGY
    
    RETURN
END 

