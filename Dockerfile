FROM container4hpc/base-mpich314:0.2.0
  
# Compile LAMMPS
# FOR PRODUCTION: PUT ALL IN THE SAME LINE TO AVOID HAVING LAYERS WITH A LOT OF FILES!
RUN apt-get update \
    && apt-get install -y wget libxkbcommon0 libx11-6 libx11-xcb1 libfreetype6 libdbus-1-3 libfontconfig1 libgomp1

# Change working directory for later usage as singularity container
# Add symbolic link for version independent usage
WORKDIR "/opt"
RUN wget -q --no-check-certificate https://download.lammps.org/tars/lammps-23Jun2022.tar.gz
RUN tar xf lammps-23Jun2022.tar.gz
RUN cd lammps-23Jun2022 \
    && cd src \
    && make yes-molecule \
    && make yes-kspace \
    && make -j$(nproc) mpi \
    && ln -s $PWD/lmp_mpi /opt/lammps \
    && cd ../.. && rm -rf lammps-23Jun2022.tar.gz
