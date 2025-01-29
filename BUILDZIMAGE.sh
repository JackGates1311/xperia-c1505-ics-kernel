#!/bin/bash

# Step 1: Build the Docker image
echo "Building Docker image..."
docker build -t ubuntu-12-gcc .

# Step 2: Run the Docker container
echo "Running the Docker container..."
docker run --name kernel-build -d ubuntu-12-gcc

# Step 3: Wait for the build to finish (optional, adjust if necessary)
echo "Waiting for the build process to finish..."
# You can add additional checks or sleep if needed
sleep 10 # Adjust this time as needed

# Step 4: Copy the zImage to the local output directory
echo "Copying zImage to local output directory..."
docker cp kernel-build:/usr/src/kernel/arch/arm/boot/zImage ./output/zImage

# Step 5: Clean up the container
echo "Cleaning up the container..."
docker rm kernel-build

# Finish message
echo "Kernel build completed! zImage is saved in ./output/zImage"
