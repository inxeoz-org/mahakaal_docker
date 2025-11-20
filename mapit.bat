@echo off

docker compose -f mapit_pwd.yml down --volumes

for /f "delims=" %%i in ('powershell -command "[Convert]::ToBase64String([IO.File]::ReadAllBytes('apps_mapit.json'))"') do set APPS_JSON_BASE64=%%i

set FRONTEND_PORT=8881

echo ############# APPS_JSON_BASE64 ################
echo.
echo %APPS_JSON_BASE64%
echo.
echo ############# APPS_JSON_BASE64 ################
echo.

docker compose -f mapit_pwd.yml build

docker compose -f mapit_pwd.yml up -d

echo Visit this Url
echo http://localhost:%FRONTEND_PORT%/