@echo off
rem Cheridan asked for this. - N3X
call "%~dp0\bootstrap\python" changelogs/compile_monthly_changelogs.py
pause
