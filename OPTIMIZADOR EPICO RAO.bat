@echo off
title Optimizador Épico - Raul Edition
color 0A
setlocal enabledelayedexpansion

:MENU
cls
echo ============================================
echo     OPTIMIZADOR ÉPICO DE WINDOWS 10/11
echo ============================================
echo 1. Limpiar archivos temporales y caché
echo 2. Optimizar rendimiento del sistema
echo 3. Desinstalar programas profundamente
echo 4. Verificar integridad del sistema
echo 5. Salir
echo ============================================
set /p opcion=Selecciona una opción [1-5]:

if "%opcion%"=="1" goto LIMPIEZA
if "%opcion%"=="2" goto OPTIMIZACION
if "%opcion%"=="3" goto DESINSTALAR
if "%opcion%"=="4" goto INTEGRIDAD
if "%opcion%"=="5" exit
goto MENU

:LIMPIEZA
cls
echo ¿Deseas limpiar archivos temporales y caché? (S/N)
set /p resp=
if /I "%resp%"=="S" (
    del /s /q "%temp%\*.*"
    del /s /q "C:\Windows\Temp\*.*"
    del /q C:\Windows\Prefetch\*.*
    del /q C:\Windows\Logs\*.*
    cleanmgr /sagerun:1
    echo Limpieza completada.
) else (
    echo Saltando limpieza...
)
pause
goto MENU

:OPTIMIZACION
cls
echo ¿Deseas optimizar el rendimiento del sistema? (S/N)
set /p resp=
if /I "%resp%"=="S" (
    sc config "DiagTrack" start= disabled
    sc config "SysMain" start= disabled
    powercfg -hibernate on
    echo Optimización completada.
) else (
    echo Saltando optimización...
)
pause
goto MENU

:DESINSTALAR
cls
echo ¿Deseas desinstalar algún programa? (S/N)
set /p resp=
if /I "%resp%"=="S" (
    powershell -Command "Get-WmiObject -Class Win32_Product | Select-Object Name"
    echo ============================================
    set /p programa=Escribe el nombre EXACTO del programa a eliminar:
    echo ¿Eliminar también sus registros? (S/N)
    set /p eliminarReg=
    powershell -Command "Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -eq '%programa%' } | ForEach-Object { $_.Uninstall() }"
    if /I "%eliminarReg%"=="S" (
        reg export HKLM\Software\%programa% "%userprofile%\Desktop\Backup_%programa%.reg"
        powershell -Command "Remove-Item -Path 'HKLM:\Software\%programa%' -Recurse -Force -ErrorAction SilentlyContinue"
        powershell -Command "Remove-Item -Path 'HKCU:\Software\%programa%' -Recurse -Force -ErrorAction SilentlyContinue"
    )
    echo Desinstalación completada.
) else (
    echo Saltando desinstalación...
)
pause
goto MENU

:INTEGRIDAD
cls
echo ¿Deseas verificar la integridad del sistema? (S/N)
set /p resp=
if /I "%resp%"=="S" (
    sfc /scannow
    DISM /Online /Cleanup-Image /RestoreHealth
    echo Verificación completada.
) else (
    echo Saltando verificación...
)
pause
goto MENU