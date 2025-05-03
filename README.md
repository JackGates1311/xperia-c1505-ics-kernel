# Sony Xperia E Dual (C1605) Kernel Port for Xperia E (C1505)

This project ports the **Sony Xperia E Dual (C1605) kernel (11.1.A.0.68)** to work on the **Xperia E (C1505)**, enabling support for **Android ICS (4.0)**.

## 📌 Features & Goals  
- ✅ Adapt **C1605 (Dual SIM) kernel** to **C1505 (Single SIM)**.  
- ✅ Ensure full compatibility with **ICS (Android 4.0)**.  
- ✅ Provide both **manual and Docker-based build methods**.  
- ✅ Build both **zImage and kernel.elf** for flashing.
- ✅ Implemented **1.3 and 1.5 GHz CPU overclock**.   
- ✅ Ramdisk now includes fully working **CWM recovery mode**.  
---

## 🔧 **Building the Kernel**  

### **1️⃣ Install Dependencies**  
#### **Manual Setup (Native Compilation)**  
Install required packages:  
```bash
sudo apt update && sudo apt install -y build-essential gcc-arm-linux-gnueabi bc
```

#### **Docker Setup (for Automated Environment only)**  
Ensure Docker is installed on your system by executing this command
```bash
docker -v
```

If it is not already installed on your system, execute these commands

```bash
# Install Docker (for Ubuntu/Debian)
sudo apt update
sudo apt install -y docker.io

# Enable and start the Docker service
sudo systemctl enable docker
sudo systemctl start docker

# (Optional) Allow current user to run Docker without sudo
sudo usermod -aG docker $USER
```

---

### **2️⃣ Clone & Configure the Kernel**  
```bash
git clone https://github.com/JackGates1311/xperia-c1505-ics-kernel
cd xperia-e-kernel  
```

---

### **3️⃣ Build the Kernel**
> **Note:**  Before compiling the final ELF image, make sure you have the required `ramdisk.cpio.gz` and `bootcmd` files.
> - These files are already included in this repository under `makeelf/krlparts/` specifically for the **Xperia E (C1505)** device.
> - The `ramdisk.cpio.gz` is a modified version from the Xperia E Dual (C1605) with **ClockworkMod Recovery**, ported to the C1505.
> - The `bootcmd` file contains the necessary kernel command-line arguments.
>
> 🔄 **Customization Tip:**  
> If you want to use your own `ramdisk` or `bootcmd`, replace the files in `makeelf/krlparts/` before building.  
>
> 💾 It's recommended to back up the original files first.  
> ✏️ You may also edit the existing files directly if only minor changes are needed.
>
> 🐳 **Docker Note:**  
> If you choose to use the **B) Docker-based build method**, this entire ELF-building process is **fully automated**—no manual steps are needed for `ramdisk` or `bootcmd`.
#### **A) Manual Compilation**  
```bash
export ARCH=arm  
export CROSS_COMPILE=arm-linux-gnueabi-  
make clean && make menuconfig  
make -j$(nproc)
```
To generate the kernel ELF file, run the following command after the zImage is built:
```bash
python2 makeelf/mkelf.py -o output/kernel.elf kernel/arch/arm/boot/zImage@0x00208000 kernel/krlparts/ramdisk.cpio.gz@0x01400000,ramdisk kernel/krlparts/bootcmd@cmdline
```
#### **B) Docker-Based Compilation (recommended)**
You only need to execute **./BUILDKRNL.sh** from the root of project
```bash
./BUILDKRNL.sh
```
> **Note:** Docker automatically configures the toolchain and environment. zImage and Kernel ELF files will be saved in **./output** directory using this method.
---

### **4️⃣ Locate Kernel files**  
- **Compiled zImage:**  
  ```plaintext
  arch/arm/boot/zImage
  ```
- **Compiled kernel.elf file:**  
  ```plaintext
  output/kernel.elf
  ```
---

## 📲 **Flashing Instructions**  
1. Flash **kernel.elf** file using **fastboot**:  
   ```bash
   fastboot flash boot kernel.elf
   fastboot reboot
   ```
---

## ⚠️ **Known Issues**  
- 🔄 **Potential device-specific bugs** (testing required).  
- 🔄 **ICS compatibility tweaks for Xperia E (C1505)**.  

---

## 📜 **License**  
This project is based on **Sony Open Source Kernel (GPL v2)**, and all modifications comply with **GPLv2 license**.  

---

## 🤝 **Contributing**  
Pull requests are welcome! Steps to contribute:  
1. **Fork** this repository.  
2. **Create a new branch** with your changes.  
3. **Submit a pull request** explaining your modifications.  

---

## 📧 **Contact**  
For discussions, open an **Issue** or contact me via mail: **makimitrovic07@gmail.com**.  

