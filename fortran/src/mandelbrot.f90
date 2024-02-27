module mandelbrot

    implicit none

    private
    public :: mandelbrot_set

contains

    function mandelbrot_set(grid_size, centre, range) result(set)

        implicit none

        integer,        intent(in) :: grid_size
        real, optional, intent(in) :: centre(2)
        real, optional, intent(in) :: range

        integer, parameter :: n_iters = 50
        integer            :: i, j, rank, ierr, comm_size
        real, allocatable  :: x_c(:), y_c_r(:), y_c(:), set(:,:)
        real               :: centre_l(2), range_l

        centre_l = [0.0, 0.0]
        if (present(centre)) centre_l = centre
        range_l = 4.0
        if (present(centre)) range_l = range

        ! Create grid arrays
        allocate(x_c(grid_size))
        allocate(y_c(grid_size))
        allocate(set(grid_size, grid_size))
        x_c = (/(i, i=1,grid_size, 1)/) * (2 * range_l / real(grid_size)) - range_l + centre_l(1)
        y_c = (/(i, i=1,grid_size, 1)/) * (2 * range_l / real(grid_size)) - range_l + centre_l(2)

        !$acc parallel loop
        do i = 1, size(x_c)
            do j = 1, size(y_c)
                if (converges(cmplx(x_c(i), y_c(j)), n_iters)) then
                    set(i, j) = 1.0
                else
                    set(i, j) = 0.0
                end if
            end do
        end do
        !$acc end parallel loop


    end function mandelbrot_set

    function converges(c, iters) result(conv_result)

        implicit none

        complex, intent(in) :: c
        integer, intent(in) :: iters
        logical             :: conv_result

        real, parameter :: threshold = 2.0
        integer         :: i
        complex         :: c_iter

        c_iter = (0,0)

        do i=0, iters
            c_iter = c_iter**2 + c
            if (abs(c_iter) > threshold) then
                conv_result = .false.
                return
            end if
        end do

        conv_result = .true.

        return

    end function converges

end module mandelbrot
