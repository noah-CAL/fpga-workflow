# FPGA Development Workflow

This is a repository for the Vivado scripts and setup necessary for my development workflow for creating GUI-less Vivado FPGA projects on Windows 11 running a Debian Kernel WSL2.

Scripts work for the Vivado non-project mode with specific details for the Basys-3 board running the ARTIX-7 FPGA. This setup took a full day of research and debugging, feel free to clone the template.

## Xilinx Vivado Installation

### 1. Install the AMD Unified Installer (for Linux)

Run the ["AMD Unified Installer for FPGAs & Adaptive SoCs 2024.2: Linux Self Extracting Web Installer"](https://www.xilinx.com/support/download.html) *as root user*


```
> mv ~/desktop/FPGAs_AdaptiveSoCs_Unified_2024.2_1113_1001_Lin64.bin .
> sudo ./FPGAs_AdaptiveSoCs_Unified_2024.2_1113_1001_Lin64.bin
```

### 2. In setup, change the installation directory from `/tools/Xilinx/` to `/opt/Xilinx/`

```
> cd /opt
> mkdir Xilinx
```

### 3. Ensure `/opt/Xilinx` is added to PATH

```
> cat `~/.bashrc`
...
if [ -d /opt/Xilinx ]; then
	PATH=/opt/Xilinx/Vivado/2024.2/bin:$PATH
fi
...
```

### 4. Install dependencies

```
> sudo apt install libtinfo5
```

### 5. Install Digilent Board Files

https://digilent.com/reference/programmable-logic/guides/installing-vivado-and-vitis#install_digilent_s_board_files

### 6. Cleanup

```
> rm FPGAs_AdaptiveSoCs_Unified_2024.2_1113_1001_Lin64.bin
```

## Install Linux Cable Drivers
Sufficient to [follow Digilent guide](https://digilent.com/reference/programmable-logic/guides/installing-vivado-and-sdk?redirect=1#installing_cable_drivers_on_linux)

```
> cd /opt/Xilinx
> find -name "install_drivers"
./data/xicom/cable_drivers/lin64/install_script/install_drivers/install_driver

> sudo ... ./install_drivers
> sudo adduser $USER dialout
```

## Windows->WSL USB Passthrough

### (Windows) Step 1: Install [usbipd-win](https://learn.microsoft.com/en-us/windows/wsl/connect-usb)

Windows Command Prompt as Administrator:

```
C:\Windows\System32> winget install usbipd
```

### (Windows) Step 2: Bind USB (FPGA) device

```
C:\Windows\System32> usbipd list
Connected:
BUSID  VID:PID    DEVICE                                                        STATE
2-1    <ID>:<ID>  USB Serial Converter A, USB Serial Converter B                Not shared

 ^
 +------ this is the FPGA board connected over USB

C:\Windows\System32> usbipd bind --busid=2-1

C:\Windows\System32>usbipd attach -b=2-1 -w -o <LocalHost (address matched in TCL open_hw_server)>
usbipd: info: Using WSL distribution 'Debian' to attach; the device will be available in all WSL 2 distributions.
usbipd: info: Detected networking mode 'nat'.
usbipd: info: Using IP address <IPv4 Address> to reach the host.

```

### (Linux) Step 3:
```
> sudo apt install usbutils
apt-get install usbutils

> lsusb
Bus 002 Device 001: ID <ID>:<ID> Linux Foundation 3.0 root hu
```

## Quickstart FPGA Batch TCL
Run the scripts within `./scripts` or with the commands in the `Makefile`
