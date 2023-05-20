MODULE READ_NTWK
    IMPLICIT NONE
    !include 'r1279block.h'

    character*1024              :: ewa
    character(25)               :: fName
    integer                     :: fStat,file_unit
    integer                     :: sig,ind ! file read signal
    integer                     :: nlinks,i,j,k,ii,jj,l ! number of lines
    integer                     :: N,a,b,links2
    integer                     :: num_edges_active,num_nodes_suscep,num_nodes_infected,num_infected,n_samples
    integer                     :: infect_i,recover_i,n_recover, n_infect,node1,node2,link1,link2,n_samples_max
    integer                     :: i_neigh,i_link1,i_link2
    real                        :: k_avg,links
    real                        :: lambda,delta
    integer                     :: tmax,n_init,num_recovered,dyn_dt_pos_max
    integer                     :: dyn_NI,dyn_active,dyn_recovered,dyn_dt_pos
    real                        :: dyn_R,avg_rho,avg_samp
    real                        :: dyn_m,time,dt,t_confinment,timeaux,l_max,avg_sqd,lambdacritical,num_nodes_total
    logical                     :: confinment ,print_rates


    integer, dimension(:), allocatable :: V, Pini, Pfin, D
    integer, dimension(:), allocatable :: node_vec, link_vec


  contains

    subroutine readinput(file_unit)
      IMPLICIT NONE
      integer:: file_unit
      !OPEN(file_unit,status = 'old')
      READ(file_unit,*) n_init
      READ(file_unit,*) tmax
      READ(file_unit,*) lambda
      READ(file_unit,*) delta
      READ(file_unit,*) print_rates
      READ(file_unit,*) confinment
      READ(file_unit,*) n_samples


      close(file_unit)

    END SUBROUTINE readinput

    subroutine readnet()

        ! input file is opened
        OPEN (1,FILE='input.dat',STATUS='old')
        N = 0
        nlinks = 0
        do
          read(1,*,IOSTAT=sig) a,b
          if (sig < 0) exit  ! if end of file,
          nlinks = nlinks +1
          N = max(N,a,b)
          if(a.eq.b) print*, 'Error, self-connection found'
          if(a<1.or.b<1) print*,'Must be >=1'
        end do
        links = 2*nlinks
        k_avg = links/N



        close(1)

        allocate(V(1:2*nlinks))
        allocate(Pfin(1:N))  ! final neigbour pointer to V
        allocate(Pini(1:N))  ! initial neigbour pointer to V
        allocate(D(1:N))    ! Degrees vector
        allocate(link_vec(1:2*nlinks))
        allocate(node_vec(1:N))



        OPEN (1,FILE='input.dat',STATUS='old')

        D = 0
        do
             read(1,*,IOSTAT=sig) a, b
             if (sig < 0) exit
             D(a) = D(a) + 1
             D(b) = D(b) + 1
         enddo

         avg_sqd = 0.d0

         DO i = 1,N
           avg_sqd = avg_sqd + D(i)**2.
        end do
          avg_sqd = avg_sqd/N

          lambdacritical = k_avg/(avg_sqd-k_avg)

         close(1) ! we do not need the file anymore

         print*,'Number of vertices', N
         print*, 'Number of edges', nlinks
         print*, '<k> = ', k_avg
         print*,'avg squared degree = ', avg_sqd
         print*,'critical lambda = ', lambdacritical

         ! Pointers
         Pini(1) = 1
         !Pfin(1) = 0
         Pini(1)=1
         DO i=1,N-1
             Pfin(i)=Pini(i)+D(i)-1
             Pini(i+1)=Pfin(i)+1
         END DO
         Pfin(N)=Pfin(N-1)+D(N)

         j = 1
         do i = 1, N
           OPEN (1,FILE='input.dat',STATUS='old')
           do
             read(1,*,IOSTAT=sig) a, b
             if (sig < 0) exit
             if (a .eq.i) then
               V(j) = b
               j = j + 1
             endif
             if (b .eq. i) then
               V(j) = a
               j = j + 1
             endif
           enddo

           close(1)
         enddo

         do i = 1, N
           node_vec(i) = i
         enddo
         do i = 1, 2*nlinks
           link_vec(i) = i
         enddo


  end subroutine

END MODULE READ_NTWK
