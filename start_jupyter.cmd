@echo off
rem Windows: double-click this file in Explorer to start the classic Notebook.
rem It also works from cmd or PowerShell, with the same arguments as start_jupyter.ps1.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0start_jupyter.ps1" %*
if errorlevel 1 pause
