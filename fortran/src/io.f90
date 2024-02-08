module io

    use netcdf

    implicit none

    private
    public :: nc_write

contains

    subroutine nc_write(path, data)

        implicit none

        character(*), intent(in) :: path
        real,         intent(in) :: data(:,:)

        integer :: stat, ncid, dims(2), xdimid, ydimid, varid

        stat = nf90_create(path=trim(path), cmode=nf90_clobber, ncid=ncid)
        dims = shape(data)

        stat = nf90_def_dim(ncid, "x", dims(1), xdimid)
        stat = nf90_def_dim(ncid, "y", dims(2), ydimid)

        stat = nf90_def_var(ncid, "set", nf90_double, &
            [xdimid, ydimid], varid)

        stat = nf90_enddef(ncid)

        stat = nf90_put_var(ncid, varid, data)

        stat = nf90_close(ncid)

    end subroutine nc_write

end module io