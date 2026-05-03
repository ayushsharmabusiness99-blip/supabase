@echo off
echo Starting Supabase Docker Containers...
cd /d "%~dp0docker"
call docker compose up -d

pause
