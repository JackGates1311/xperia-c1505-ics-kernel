# Sony Xperia E Dual (C1605) Kernel Port for Xperia E (C1505)

This project ports the **Sony Xperia E Dual (C1605) kernel (11.1.A.0.68)** to work on the **Xperia E (C1505)**, enabling support for **Android ICS (4.0)**.

## 📌 Features & Goals  
- ✅ Adapt **C1605 (Dual SIM) kernel** to **C1505 (Single SIM)**.  
- ✅ Ensure full compatibility with **ICS (Android 4.0)**.  
- ✅ Provide both **manual and Docker-based build methods**.  
- ✅ Build both **zImage and boot.img** for flashing.  

---

## 🔧 **Building the Kernel**  

### **1️⃣ Install Dependencies**  
#### **Manual Setup (Native Compilation)**  
Install required packages:  
```bash
sudo apt update && sudo apt install -y build-essential gcc-arm-linux-gnueabi bc
```

#### **Docker Setup (Automated Environment)**  
Ensure Docker is installed, then proceed with the next step.

---

### **2️⃣ Clone & Configure the Kernel**  
```bash
git clone https://github.com/your-username/xperia-e-kernel.git  
cd xperia-e-kernel  
```

---

### **3️⃣ Build the Kernel**  
#### **A) Manual Compilation**  
```bash
export ARCH=arm  
export CROSS_COMPILE=arm-linux-gnueabi-  
make clean && make menuconfig  
make -j$(nproc)
```

#### **B) Docker-Based Compilation**  
```bash
docker build -t xperia-kernel .  
docker run --rm -v $(pwd):/kernel xperia-kernel  
```
> **Note:** Docker automatically configures the toolchain and environment.

---

### **4️⃣ Locate and Package the Kernel**  
- **Compiled zImage:**  
  ```plaintext
  arch/arm/boot/zImage
  ```
- **Create boot.img:**  
  ```bash
  mkbootimg --kernel arch/arm/boot/zImage --ramdisk ramdisk.img -o boot.img
  ```

---

## 📲 **Flashing Instructions**  
1. Copy the compiled **boot.img** to your device.  
2. Flash using **fastboot**:  
   ```bash
   fastboot flash boot boot.img
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
For discussions, open an **Issue** or contact me via mail **makimitrovic07@gmail.com**.  

