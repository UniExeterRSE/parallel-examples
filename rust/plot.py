import netCDF4 as nc
import matplotlib.pyplot as plt

ds = nc.Dataset("set.nc")

plt.imshow(ds['set'])
plt.show()
