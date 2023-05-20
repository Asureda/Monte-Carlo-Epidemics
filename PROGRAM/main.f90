PROGRAM epi
    !---------------------------------------------
    !      IMPORTING ALL MODULES
    !---------------------------------------------
    use READ_NTWK
    use SIR
      IMPLICIT NONE
      integer :: seed
      real :: rnd1,r1279
      !allocate(avg_rho(tmax), avg_t(tmax))
      ! OPEN THE FILE AND READ DATA FROM INPUT
          call get_command_argument(1, fName, status=fStat)
          if (fStat /= 0) then
                  print*, 'Any file given ---> Exitting program'
                  call exit()
          end if
          file_unit = 10
          open(unit=file_unit, file=trim(fName), status='old')
          call readinput(file_unit)

      !dyn_dt_pos = 1
      call RANDOM_SEED()
      ! CALL SETSEED(seed)
      ! CALL SETR1279(seed)

      !call readinput()
      call readnet()


      OPEN(13,FILE='rates.dat')
      OPEN(14,FILE='size.dat')

    !  n_samples = 1


        call init()
      !------------------------------------

      time = 0.d0
      t_confinment = 0.6d0
      avg_rho = 0.d0
      num_nodes_total = REAL(N)


      call sample()



      dyn_time_loop : DO WHILE (time.le.tmax)
        call random_number(rnd1)
        rnd1 = max(rnd1, 1e-12) ! Avoid rnd = 0
        dt = -(log(rnd1))/dyn_R
        time = time + dt

        dyn_m = dyn_active*lambda/dyn_R

        if (rnd1 < dyn_m) then
          call infect()
         else
           call recover()
           !call traceig()
         end if

         call sample()

         avg_rho =avg_rho + dyn_NI/num_nodes_total


       ! if ((time.ge.t_confinment).and.(confinment.eqv.(.TRUE.))) then
       !   lambda = lambda*0.1
       ! end if

       if (num_nodes_infected.le.0) then
          exit dyn_time_loop
       endif

         if (dyn_NI.le.0) then
            exit dyn_time_loop
         endif
      END DO dyn_time_loop
      avg_rho=avg_rho/N
      write(14,*)avg_rho
      close(13)
      close(14)
      print*,'End program'
END PROGRAM epi
