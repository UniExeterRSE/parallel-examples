use std::iter::FromIterator;
use num::complex::{Complex, ComplexFloat};
use ndarray::Array2;

pub fn mandelbrot_set(res:usize, centre:[f32; 2], range:f32) -> Array2::<f32> {

    let n_iters = 50;
    let res_factor = range / (res as f32);

    let x_c = Vec::from_iter((0..res).map(|i| ((i as f32) * res_factor) -
                                                centre[0] - (range / 2.0)));
    let y_c = Vec::from_iter((0..res).map(|i| ((i as f32) * res_factor) -
                                                centre[1] - (range / 2.0)));
    let mut set = Array2::<f32>::zeros((res, res));

    for i in 0..res {
        for j in 0..res {
            if converges(Complex::new(x_c[i], y_c[j]), n_iters) {
                set[[i, j]] = 1.0;
            } else {
                set[[i, j]] = 0.0;
            }
        }
    }

    return set;
}

fn converges(c:Complex<f32>, iters:usize) -> bool {

    let threshold:f32 = 2.0;

    let mut c_iter = Complex::new(0f32, 0f32);
    for _ in 0..iters {
        c_iter = c_iter.powf(2.0) + c;
        if c_iter.abs() > threshold {
            let conv_result = false;
            return conv_result
        }
    }

    let conv_result = true;

    return conv_result;
}