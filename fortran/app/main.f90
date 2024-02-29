program main

  use mandelbrot, only: mandelbrot_set
  use io,         only: nc_write

  !use mpi

  implicit none

  real, allocatable :: set(:,:)
  integer           :: res, ierr
  real              :: centre(2), range

  ! Setup MPI comm
  !call mpi_init(ierr)

  res = 4000
  centre = [0.0, 0.0]
  range = 4.0

  set = mandelbrot_set(res, centre, range)
  call nc_write("set.nc", set)

  print*, "Done"

  !call mpi_finalize(ierr)

end program main
