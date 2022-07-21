FROM container4hpc/base-mpich314:0.2.1
  
# Compile LAMMPS
# FOR PRODUCTION: PUT ALL IN THE SAME LINE TO AVOID HAVING LAYERS WITH A LOT OF FILES!
RUN apt-get update \
    && apt-get install -y wget libxkbcommon0 libx11-6 libx11-xcb1 libfreetype6 libdbus-1-3 libfontconfig1 libgomp1
    
RUN wget -q --no-check-certificate https://download.lammps.org/tars/lammps.tar.gz
RUN tar xf lammps.tar.gz
# lammps has per-version folder names. get the name from the tar
# lammps does not support a make install
RUN dirName=`tar tfz lammps.tar.gz | head -1 | cut -f1 -d"/"` \
    && cd $dirName \
    && cd src \
    && make -j$(nproc) mpi \
    && cd ../.. && rm -rf lammps.tar.gz

