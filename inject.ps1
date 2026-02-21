# CONFIGURAÇÕES
$CheatUrl = "https://raw.githubusercontent.com/enzin762/wasd/main/cheat.exe" # Seu cheat x64
$TempPath = "$env:TEMP\win_system_update.exe" # Nome disfarçado para a tela

Write-Host "[+] Baixando componentes de segurança..." -ForegroundColor Cyan

# 1. Baixa o cheat para a pasta temporária
Invoke-WebRequest -Uri $CheatUrl -OutFile $TempPath -UseBasicParsing

# 2. Inicia o Soundpad original primeiro
Write-Host "[+] Iniciando Soundpad..." -ForegroundColor Green
Start-Process "C:\Program Files (x86 )\Steam\steamapps\common\Soundpad\Soundpad.exe"

# 3. Inicia o seu cheat x64 em modo oculto
Write-Host "[+] Iniciando Cheat x64..." -ForegroundColor Green
Start-Process $TempPath -WindowStyle Hidden

# 4. Limpa o rastro do PowerShell
Remove-Item (Get-PSReadLineOption).HistorySavePath -ErrorAction SilentlyContinue
Write-Host "[OK] Sucesso!" -ForegroundColor Cyan
