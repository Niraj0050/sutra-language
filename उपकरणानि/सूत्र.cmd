@echo off
chcp 65001 > nul
set SCRIPT_DIR=%~dp0
"%SCRIPT_DIR%..\build\sutra.exe" %*
