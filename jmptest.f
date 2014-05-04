      PROGRAM jmptest
      INTEGER*8 jmp_buf(170)
      INTEGER*8 status, step
      VOLATILE status, jmp_buf, step
      
      status = 0
      step = 0
      
      CALL zsvjmp(jmp_buf, status)
      WRITE(*,*) "Status = ", status, "step = ", step
      IF (status == 0) THEN
         IF (step == 1) THEN
            WRITE(*,*) "Error: Called zsvjmp a second time"
            STOP 3
         ENDIF
         step = 1
         WRITE(*,*) "Calling zdojmp"
         CALL zdojmp(jmp_buf, status)
         WRITE(*,*) "Error: return from ZDOJMP" 
         STOP 1
      ENDIF
      IF (step == 0) THEN
         WRITE(*,*) "Error: ZSVJMP was not called successfully"
         STOP 2
      ENDIF
      WRITE(*,*) "All OK"
      STOP 0
      END

