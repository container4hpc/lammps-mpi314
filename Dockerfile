FROM container4hpc/base-mpich314:0.2.0

# compile LAMMPS
RUN apt-get update && apt-get install -y libxkbcommon0 libx11-6 libx11-xcb1 libfreetype6 libdbus-1-3 libfontconfig1 libgomp1 \
    && wget -q https://download.lammps.org/tars/lammps-14Dec2021.tar.gz \
    && tar xf lammps-14Dec2021.tar.gz \
    && cd lammps-14Dec2021/src \
    && make -j$(nproc) mpi