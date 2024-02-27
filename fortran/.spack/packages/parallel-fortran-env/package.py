# Copyright 2013-2022 Lawrence Livermore National Security, LLC and other
# Spack Project Developers. See the top-level COPYRIGHT file for details.
#
# SPDX-License-Identifier: (Apache-2.0 OR MIT)

import sys
from spack import *

class ParallelFortranEnv(BundlePackage):
    """A bundle package that sets the necessary environment variables needed
    to build parallel fortran examples within a Spack environment"""

    version("v0.1.0")

    depends_on("fpm")
    depends_on("mpi")
    depends_on("netcdf-fortran")

    def setup_run_environment(self, env):
        env.set("FPM_FFLAGS", f"-L{self.spec['mpi'].prefix}/lib " +
                              f"-L{self.spec['netcdf-fortran'].prefix}/lib")
