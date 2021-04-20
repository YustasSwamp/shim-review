FROM photon:4.0-20210416

# Photon 4.0 repo does not have needed dos2unix package. Use prebuilt binary.
COPY dos2unix /bin/

# Vendor certificate
COPY photon_sb2020.der /

# Golden shim binary
COPY shimx64.efi /

# Install build tools
RUN tdnf install -q -y coreutils wget tar bzip2 build-essential util-linux

# Download and extract original shim-15.4 sources
RUN wget -q https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2
RUN tar -xf shim-15.4.tar.bz2

# Build
WORKDIR /shim-15.4
RUN echo "shim.photon,1,VMware Photon OS,shim,15.4-1.ph4,https://github.com/vmware/photon/tree/4.0/SPECS/shim-signed/" > data/sbat.photon.csv
RUN make VENDOR_CERT_FILE=/photon_sb2020.der EFI_PATH=/usr/lib 'DEFAULT_LOADER=\\\\grubx64.efi' shimx64.efi
WORKDIR /

# FIXME: This only works on x86-64 efi binary
RUN hexdump -Cv /shimx64.efi > orig && \
    hexdump -Cv /shim-15.4/shimx64.efi > build && \
    diff -u orig build
