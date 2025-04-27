# Use Ubuntu 12.04 as the base image
FROM ubuntu:12.04

# Set environment variables to prevent interaction during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update apt sources to use old-releases
RUN sed -i 's/archive.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# Update the package list and install required tools
RUN apt-get update && apt-get install -y \
    software-properties-common \
    python2.7 \
    python-pip \
    make \
    git \
    wget \
    curl \
    build-essential \
    && apt-get clean

# Clone the arm-eabi-4.6 repository from GitHub
RUN mkdir /android && cd /android && \
    git clone https://github.com/emuikernel/arm-eabi-4.6

# Set the CROSS_COMPILE environment variable to the downloaded toolchain
ENV CROSS_COMPILE=/android/arm-eabi-4.6/bin/arm-eabi-

# Export the cross-compilation environment variable
ENV PATH="/android/arm-eabi-4.6/bin:$PATH"
ENV ARCH=arm

# Set KBUILD_BUILD_USER and KBUILD_BUILD_HOST to custom values
ENV KBUILD_BUILD_USER=jackgates1311
ENV KBUILD_BUILD_HOST=docker-ubuntu-12-04

# Verify the versions of GCC and Python
RUN arm-eabi-gcc --version && python2 --version

# Copy the kernel directory from the build context to /usr/src/kernel in the container
COPY ./kernel /usr/src/kernel

# Set the working directory
WORKDIR /usr/src/kernel

# Modify the Makefile to suppress warnings
RUN echo "export KBUILD_CFLAGS += -Wno-array-bounds -Wno-maybe-uninitialized -Wno-unused-value -Wno-address -Wno-uninitialized" >> /usr/src/kernel/Makefile

# Run kernel build commands (2 CPU cores)
RUN make clean && \
    make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE msm7627a-perf_defconfig && \
    make ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE -j2

# Copy the built zImage to the /output directory, which will be mounted to the local machine
RUN mkdir -p /output && \
    cp /usr/src/kernel/arch/arm/boot/zImage /output/zImage

# Default command
CMD ["bash"]
