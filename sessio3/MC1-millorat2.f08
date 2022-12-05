
PROGRAM MC2
IMPLICIT NONE
INTEGER K,L,N,SEED0,NSEED,MCTOT,MCINI,MCD
PARAMETER(L=48,N=L*L,SEED0=1234,NSEED=7)
PARAMETER(MCTOT=10000,MCINI=1000,MCD=10)

INTEGER PBC(0:L+1),S(1:L,1:L),seed,I,J,IMC,IPAS,suma,DE
REAL*8 temp,genrand_real2,ENERG,MAGNE,ENE,MAG,temperatures(1:5)
REAL*8 sum,sume,sume2,summ,summ2,sumam,vare,varm,W(-8:8)

!vector de temperatures
temperatures(1) = 1.5
temperatures(2) = 1.8
temperatures(3) = 2.5
temperatures(4) = 3.5
temperatures(5) = 4.5
! Omplim el vector PBC que caracteritza les condicions de contorn
DO K=1, L
    PBC(K)=K
ENDDO

PBC(0) = L
PBC(L+1)=1

OPEN(20, FILE= "data.csv")
WRITE(20,*) 'Temperatura',',','Passos MC',',','<E>/Passos MC',',','<E^2>/Passos MC',',', &
'Var(<E>)/Passos MC',',','<M>/Passos MC',',','<|M|>/Passos MC',',','<M^2>/Passos MC',',','Var(<M>)/Passos MC'

!Recorrem les diferents temperatures
DO k=1,5
    temp = temperatures(k)

    ! Tabulem els valors del factor de Boltzman per millorar l'eficiència del càlcul
    ! ja que sabem quins valors pot donar
    do DE=-8,8,4
        W(DE) = DEXP(-DBLE(DE)/TEMP)
    enddo

    ! Posem a zero els comptadors de les quantitats d'interès
    sum=0.0d0 !passos MC NO descartats
    sume=0.0d0 !<E>
    sume2=0.0d0 !<E^2>
    summ=0.0d0 !<M>
    summ2=0.0d0 !<M^2>
    sumam=0.0d0 ! <|M|>

    ! Recorrem les llavors i inicialitzem els nombres aleatòris
    DO seed=SEED0,SEED0+NSEED-1
        CALL init_genrand(seed)
                
        ! Generem una matriu d'espins aleatòria
        DO I=1,L
            DO J=1,L
                IF (genrand_real2().lt.0.5d0) THEN
                    S(I,J)=1
                ELSE
                    S(I,J)=-1
                ENDIF
            ENDDO
        ENDDO
        
        ! Simulació MC del model d'Ising 2D amb l'algorisme de Metropolis
        ENE=ENERG(S,L,PBC)

        DO IMC=1,MCTOT
            DO IPAS=1,N
                I=int(genrand_real2()*L)+1
                J=int(genrand_real2()*L)+1
                
                suma=S(I,PBC(J+1))+S(I,PBC(J-1))+S(PBC(I+1),J)+S(PBC(I-1),J)
                DE=2*S(I,J)*suma	!Càlcul de la variació d'energia
                
            !S'accepta el canvi si DE<0		
                IF (DE.LE.0) THEN	
                    S(I,J)=-S(I,J)
                    ENE=ENE+DE
            ! Si DE>0 aleshores s'accepta en funció d'un nombre aleatòri i del factor de Boltzman, que és al vecor W
                ELSEIF (DE.GT.0) THEN
                    IF (genrand_real2().lt.W(DE)) THEN
                        S(I,J)=-S(I,J)
                        ENE=ENE+DE
                    ENDIF
                ENDIF
            ENDDO

            ! Descartem MCINI passes inicials
            IF ((imc.GT.MCINI).AND.(MCD*(imc/MCD).EQ.imc)) THEN

            MAG=MAGNE(s,L)
            sum=sum+1.0d0
            sume=sume+ENE
            sume2=sume2+ENE*ENE
            summ=summ+MAG
            sumam=sumam+dabs(MAG)
            summ2=summ2+mag*MAG
            ENDIF

        ENDDO       
    ENDDO

          
    ! Normalitzem els promitjos i calculem els estimadors de variances fora del bucle de llavors
    sume=sume/sum
    sume2=sume2/sum
    summ=summ/sum
    sumam=sumam/sum
    summ2=summ2/sum
    vare=sume2-sume*sume
    varm=summ2-summ*summ

    ! Sortida de dades
    WRITE(20,*) temp,',',sum,',',sume,',',sume2,',',vare,',',summ,',',sumam,',',summ2,',',varm


ENDDO

CLOSE(20)


END PROGRAM
    
!-----------------------------------------------------------------------
!     Càlcul de la imantació immediata del sistema
!-----------------------------------------------------------------------
REAL*8 FUNCTION MAGNE(S,L)
IMPLICIT NONE
INTEGER L,I,J,S(1:L,1:L)
MAGNE=0.0D0
DO I=1,L
    DO J=1,L
        MAGNE=MAGNE+S(I,J)
    ENDDO
ENDDO

END
    
!-----------------------------------------------------------------------
!    Càlcul de l'energia immediata del sistema
!-----------------------------------------------------------------------
REAL*8 FUNCTION ENERG(S,L,PBC)
IMPLICIT NONE
INTEGER L,I,J,PBC(0:L+1),S(1:L,1:L)
ENERG=0.0D0
DO I=1,L
    DO J=1,L
        ENERG=ENERG-S(I,J)*S(PBC(I+1),J)-S(I,J)*S(I,PBC(J+1))
    ENDDO
ENDDO
END
