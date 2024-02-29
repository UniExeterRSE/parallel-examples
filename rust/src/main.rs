mod mandelbrot;
mod io;
use crate::mandelbrot::mandelbrot_set;
use crate::io::write;
use std::path::Path;


fn main() {
    let res = 4000;
    let centre = [0.0, 0.0];
    let range = 2.0;

    let set = mandelbrot_set(res, centre, range);

    write(Path::new("set.nc"), set);
    println!("Done!");
}
