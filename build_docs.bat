@echo off
rem batch file written by Louka
rem must have lua51 in your %PATH%
where lua51 >nul 2>nul
if errorlevel 0 (
	echo build_docs - building documentation
	rem cd docs
	rem del /s /q "*.*" >nul
	rem cd ..
	lua51 docgenx.lua docapi.lua syn_
) else (
	echo build_docs - please install lua51 into your path before using build_docs
)