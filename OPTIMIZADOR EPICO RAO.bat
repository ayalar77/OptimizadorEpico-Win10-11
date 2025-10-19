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
echo ============================================
echo     PROGRAMAS INSTALADOS EN TU EQUIPO
echo ============================================
echo Se abrirá una ventana con la lista completa.
powershell -Command "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*,HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName } | Select-Object DisplayName | Out-File -FilePath '%temp%\ProgramasInstalados.txt'"
start notepad "%temp%\ProgramasInstalados.txt"
echo ============================================
echo Copia el nombre EXACTO del programa que deseas eliminar.
set /p programa=Nombre exacto del programa a desinstalar:
if "%programa%"=="" (
    echo No se proporcionó un nombre válido. Cancelando desinstalación.
    pause
    goto MENU
)
echo Ejecutando desinstalación...
powershell -Command "$app = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*,HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*,HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object { $_.DisplayName -eq '%programa%' }; if ($app.UninstallString) { Start-Process -FilePath $app.UninstallString -Verb RunAs } else { Write-Host 'No se encontró comando de desinstalación.' }"
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
