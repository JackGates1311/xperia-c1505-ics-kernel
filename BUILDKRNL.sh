#!/bin/bash

# Step 1: Build the Docker image
echo "Building Docker image..."
docker build -t ubuntu-12-gcc .

# Step 2: Run the Docker container
echo "Running the Docker container..."
docker run --name kernel-build -d ubuntu-12-gcc

# Step 3: Wait for the build to finish (optional, adjust if necessary)
echo "Waiting for the build process to finish..."

# Short delay before performing copying from Docker containter
sleep 10

# Step 4: Copy the zImage and ELF files to the local output directory
echo "Copying zImage and ELF files to the local output directory..."
docker cp kernel-build:/usr/src/kernel/arch/arm/boot/zImage ./output/zImage
docker cp kernel-build:/output/kernel.elf ./output/kernel.elf

# Step 5: Clean up the container
echo "Cleaning up the container..."
docker rm kernel-build

# Step 6: Finish message
echo "Kernel build completed! zImage and kernel ELF files are saved in ./output directory"
