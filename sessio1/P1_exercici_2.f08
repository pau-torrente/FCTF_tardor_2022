PROGRAM EXERICIC2

    
    IMPLICIT NONE
    
    INTEGER*4 I, J, L, SEED
    PARAMETER(L=96)
    INTEGER*2 S(1:L, 1:L)
    REAL*8 GENRAND_REAL2

    SEED = 23456
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

END PROGRAM