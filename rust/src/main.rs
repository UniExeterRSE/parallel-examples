mod mandelbrot;
use crate::mandelbrot::mandelbrot_set;

fn main() {
    let res = 4000;
    let centre = [0.0, 0.0];
    let range = 2.0;

    let set = mandelbrot_set(res, centre, range);

    println!("Done!");
}
