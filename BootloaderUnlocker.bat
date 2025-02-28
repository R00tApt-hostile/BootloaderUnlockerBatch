@echo off
echo Unlocking Bootloader for Android Devices...

:: Check if ADB is installed
adb version >nul 2>&1
if %errorlevel% neq 0 (
    echo ADB is not installed. Please install ADB and Fastboot.
    exit /b
)

:: Check if the device is connected
adb devices
if %errorlevel% neq 0 (
    echo Device not found. Please connect your Android device.
    exit /b
)

:: Reboot to bootloader
echo Rebooting to bootloader...
adb reboot bootloader

:: Wait for the device to enter bootloader mode
timeout /t 5

:: Check if Fastboot is available
fastboot devices
if %errorlevel% neq 0 (
    echo Fastboot is not available. Please ensure your device is in bootloader mode.
    exit /b
)

:: Unlock the bootloader
echo Unlocking the bootloader...
fastboot oem unlock

:: Confirm the unlock
echo Please confirm the unlock on your device.
timeout /t 10

:: Reboot the device
echo Rebooting the device...
fastboot reboot

echo Bootloader unlocking process completed.
pause
