MODULE SIR
  use READ_NTWK
    IMPLICIT NONE
  contains
    subroutine infect()
      IMPLICIT NONE
      real :: r1279,rnd
      logical :: condition

      call random_number(rnd)
      infect_i=1+INT(rnd*dble(num_nodes_suscep))
      n_infect = node_vec(infect_i)
      !write(*,*) 'new_infected = ', infect_i, n_infect
      do i = Pini(n_infect),Pfin(n_infect)
        node1 = V(i)
        do j = Pini(node1),Pfin(node1)
          if(V(j).eq.n_infect) then
            link1 = j
          end if
        end do
        node2 = n_infect
        link2 = i

        DO k = 1,N
          if(node_vec(k)==node1) then
            i_neigh = k
          end if
        end do
        DO k = 1,2*nlinks
          if(link_vec(k)==link1) then
            i_link1 = k
          end if
        end do
        DO k = 1,2*nlinks
          if(link_vec(k)==link2) then
            i_link2 = k
          end if
        end do


        if((num_nodes_suscep.lt.i_neigh).and.(i_neigh.le.num_nodes_infected)) then
          condition = (.TRUE.)
          !write(*,*) 'Neigh infected Deactivate link', V(link1),i_link1
          !write(*,*) 'Neigh infected Deactivate link',  V(link2),i_link2
          call heap(condition)
        else if (i_neigh.le.num_nodes_suscep) then  ! If neigh is susceptible
          condition = (.FALSE.)
          !write(*,*) 'Neigh susceptible Activate link', V(link1),i_link1
          !write(*,*) 'Neigh susceptible Activate link',  V(link2),i_link2

          call heap(condition)
        endif

      enddo
      print*,'num_edges_active',num_edges_active,'num_nodes_suscep',num_nodes_suscep

      call inactive(N, node_vec, infect_i, num_nodes_suscep)
        if (num_nodes_suscep .eq.(N-1)) then
          num_nodes_infected = N
        end if
      return

    end subroutine infect


    subroutine recover()
      IMPLICIT NONE
      real :: r1279,rnd,x
      logical :: condition

      call random_number(rnd)
      num_infected = num_nodes_infected - num_nodes_suscep
      recover_i=num_nodes_suscep + floor(num_infected*rnd)+1
      n_recover = node_vec(recover_i)
      !write(*,*) 'new_recovered = ', recover_i, n_recover
      do i = Pini(n_recover),Pfin(n_recover)
        node1 = V(i)
        do j = Pini(node1),Pfin(node1)
          if(V(j).eq.n_recover) then
            link1 = j
          end if
        end do
        node2 = n_recover
        link2 = i

        DO k = 1,N
          if(node_vec(k)==node1) then
            i_neigh = k
          end if
        end do
        DO k = 1,2*nlinks
          if(link_vec(k)==link1) then
            i_link1 = k
          end if
        end do
        DO k = 1,2*nlinks
          if(link_vec(k)==link2) then
            i_link2 = k
          end if
        end do
        if (i_neigh.le.num_nodes_suscep) then
          condition = (.TRUE.)
          !write(*,*) 'neigh susceptible Deactivate Link', V(link1),i_link1 ! Deactivate link
          !write(*,*) 'neigh susceptible Deactivate Link', V(link2),i_link2 ! Deactivate link
          call heap(condition)
        endif
      enddo

      call inactive(N, node_vec, recover_i, num_nodes_infected)
      return

    end subroutine recover

    subroutine traceig()
      real(8) :: prob_trac,rnd_trac,r1279
      call random_number(rnd_trac)
      rnd_trac = max(rnd_trac, 1e-12) ! Avoid rnd = 0
      prob_trac = 0.5
      !print*,'rand',rnd_trac
      if (rnd_trac < prob_trac) then
        call recover()
      end if
    end subroutine traceig
        subroutine inactive(length, array, selected,last)
          integer ::  length, old_last, selected, last, old
          integer, dimension(1:length) :: array

          old_last = array(last)
          old = array(selected)
          array(last) = old! Switch nodes
          array(selected) = old_last
          last = last - 1

        return
      end subroutine inactive

    subroutine heap(condition)
      integer ::  old_first1,old_first2, selected1,selected2, last, old1,old2
      integer :: old_last1,old_last2
      logical :: condition

      if (condition.eqv.(.TRUE.)) then

      old_last1 =  link_vec(num_edges_active)
      old1 = link_vec(i_link1)
      link_vec(num_edges_active) = old1! Switch nodes
      link_vec(i_link1) = old_last1
      num_edges_active = num_edges_active-1

      old_last2 = link_vec(num_edges_active)
      old2 = link_vec(i_link2)
      link_vec(num_edges_active) = old2! Switch nodes
      link_vec(i_link2) = old_last2
      num_edges_active = num_edges_active-1
    else if ((condition.eqv.(.FALSE.))) then
      old_first1 = link_vec(num_edges_active+1)
      old1 = link_vec(i_link1)
      link_vec(num_edges_active+1) = old1! Switch nodes
      link_vec(i_link1) = old_first1
      num_edges_active = num_edges_active+1

      old_first2 = link_vec(num_edges_active+1)
      old2 = link_vec(i_link2)
      link_vec(num_edges_active+1) = old2! Switch nodes
      link_vec(i_link2) = old_first2
      num_edges_active = num_edges_active+1
    end if
    return
  end subroutine heap

  subroutine init()
    num_edges_active = 0
    num_nodes_suscep = N
    num_nodes_infected=N+1

  !---------Initial infection-----------
  DO i = 1,n_init
  call infect()
  END DO

end subroutine init

  subroutine sample()
    IMPLICIT NONE
    !avg_rho = delta*dyn_NI/N

    dyn_active = num_edges_active/2
    dyn_NI = num_nodes_infected-num_nodes_suscep
    dyn_R = dyn_active*lambda+dyn_NI*delta
    dyn_recovered = N - num_nodes_infected
    write(*,*) N,num_nodes_infected
    if(print_rates.eqv.(.TRUE.)) then

      write (13,*) N, time, dyn_NI, dyn_recovered,dyn_m
    end if
    ! do i =1,N
    !   print*,node_vec(i)
    ! end do
  end subroutine


  end module SIR
