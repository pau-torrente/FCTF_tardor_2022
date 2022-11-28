PROGRAM EXERICICI3
    
    
    IMPLICIT NONE
    
    INTEGER*4 I, J, L, SEED
    PARAMETER(L=96)
    INTEGER*2 S(1:L, 1:L)
    REAL*8 GENRAND_REAL2, MAGNE, ENERGY
    

    SEED = 23457
    CALL INIT_GENRAND(SEED)
    
    OPEN(1, FILE='P1-configuration.conf')

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
   
    WRITE(*,*) MAGNE(S,L)

    WRITE(*,*) ENERGY(S,L)

    

    ! we get a value of -60, which is pretty close to the expected values of 0,
    ! and relative to the max/min value of +-96*96, it is a low enough value to 
    ! consider it close to the expected value = 0



END PROGRAM EXERICICI3

REAL*8 FUNCTION MAGNE(S,L)
    INTEGER*2 S(1:L,1:L)
    INTEGER*4 I,J,L
    REAL*8 MAG
    MAG=0.0D0

    
    DO I =1,L
        DO J=1,L
            MAG=MAG+S(i,j)
        ENDDO
    ENDDO
    

    MAGNE=MAG
    RETURN
    
END

REAL*8 FUNCTION ENERG(S, L)
    INTEGER*2 S(1:L,1:L)
    INTEGER*4 I,J,L
    REAL*8 ENERGY  
    ENERGY = 0.D0

    
    DO I = 2, L-1
        DO J=2,L-1
            ENERGY = ENERGY + S(I, J)*S(I, J-1) + S(I, J)*S(I, J+1) + S(I, J)*S(I+1, J) + S(I, J)*S(I-1, J)
        ENDDO
    ENDDO
    
    
    
    DO I = 2, L-1 
        ENERGY = ENERGY + S(1, I)*S(1,I-1) + S(1, I)*S(2,I) + S(1, I)*S(1,I+1)
        ENERGY = ENERGY + S(L, I)*S(L,I-1) + S(L, I)*S(L-1,I) + S(L, I)*S(L,I+1) 
        ENERGY = ENERGY + S(I, 1)*S(I-1,1) + S(I, 1)*S(I, 2) + S(I, 1)*S(I+1, 1) 
        ENERGY = ENERGY + S(I, L)*S(I-1,L) + S(I, L)*S(I, L-1) + S(I, L)*S(I+1, L)
    ENDDO

    
    ENERGY = ENERGY + S(1, 1)*S(2, 1) + S(1, 1)*S(1, 2)
    ENERGY = ENERGY + S(L, 1)*S(L-1, 1) + S(L, 1)*S(L, 2)
    ENERGY = ENERGY + S(1, L)*S(1, L-1) + S(1, L)*S(2, L)
    ENERGY = ENERGY + S(L, L)*S(L-1, L) + S(L, L)*S(L, L-1)

    ENERG = ENERGY
    RETURN
END 

