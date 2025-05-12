# STM32H743XIH6-fanke-components

## Overview
Provide an environment for all projects that require manual compilation to be compiled normally.

## Features
- **Build u-boot**: Provide an environment for compiling the source code of the stm32h743xih6-fanke-uboot branch.

## Usage Instructions
1. Execute './enter_build_env.sh' pull the image and enter the container.
2. There exists a unique user [fanke] in the system image, and the password is [fanke].
3. Built-in sudo command, you can use root privileges on fanke users via sudo.
4. User fanke is mapped using the user id of the current host.

## After enter container
### U-boot build usage
1. cd workspace
2. git clone https://github.com/pmonsterR/stm32H743XIH6-fanke.git -b stm32h743xih6-fanke-uboot
3. cd stm32h743xih6-fanke-uboot
4. make stm32h743xih6-fanke_defconfig && make

## License
For more details, please refer to the GPL-2.0 license file.
