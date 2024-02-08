# mandelfort

An example FPM project that calculates the Mandelbrot set with OpenMP and MPI parallelism.
To run this project, install spack and activate and install the spack environment:
```
spack env activate .
spack install
```

Then build and run the code with fpm:
```
fpm build
fpm run
```