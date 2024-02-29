use ndarray::Array2;
use netcdf::NcPutGet;
use std::path::Path;

pub fn write(path: &Path, data: Array2::<f32>) {
    let mut file = netcdf::create(path).expect("O");

    let shape = data.shape()[0];

    let dim1_name = "x";
    let _ = file.add_dimension(dim1_name, data.shape()[0]);
    let dim2_name = "y";
    let _ = file.add_dimension(dim2_name, data.shape()[1]);

    let mut var = file.add_variable::<f32>("set", &[dim1_name, dim2_name]).unwrap();
    let arr = data.as_slice().ok_or("Missing slice data.").unwrap();
    var.put_values::<f32, _>(&arr, ..).unwrap();

}