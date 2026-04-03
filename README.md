# osu-micro-benchmarks-7.4-ext

This is a fork of the OMB [osu-micro-benchmarks-7.4](https://mvapich.cse.ohio-state.edu/benchmarks/). We have extended OMB to test latency and bandwidth for one-sided MPI across multiple pairs.

Please follow the README of cMPI(https://github.com/skhynix/cMPI) to install the benchmark.

## Use CXL RAPID Allocator

### Build
Please run the `autoreconf -fi` command first to generate the new configure. Make sure to use `--enable-cxl` and `--with-cxl`, and change `/path/to/rapid/install/root` to the path that contains RAPID's `include/` and `lib64/`.

```shell
autoreconf -fi
./configure CC=mpicc CXX=mpicxx --enable-cxl --with-cxl=/path/to/rapid/install/root --prefix=/path/to/install/osu-benchmark
make -j && make -j install
```

### Run A Specific Test
Use `-d cxl` to use the RAPID allocator
```shell
mpirun -np 4 /path/to/install/osu_allgather -d cxl
```