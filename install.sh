# Ada Voice Assistant Installation Script for PowerShell
# Run this script in PowerShell as Administrator for best results

param(
    [switch]$SkipPython,
    [switch]$Help
)

if ($Help) {
    Write-Host "Ada Voice Assistant Installation Script" -ForegroundColor Cyan
    Write-Host "Usage: .\install.ps1 [-SkipPython] [-Help]" -ForegroundColor White
    Write-Host ""
    Write-Host "Options:" -ForegroundColor Yellow
    Write-Host "  -SkipPython    Skip Python installation check" -ForegroundColor White
    Write-Host "  -Help          Show this help message" -ForegroundColor White
    exit 0
}

function Write-Step {
    param($Message)
    Write-Host "`n🔄 $Message..." -ForegroundColor Cyan
}

function Write-Success {
    param($Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Error {
    param($Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Write-Warning {
    param($Message)
    Write-Host "⚠️  $Message" -ForegroundColor Yellow
}

function Test-Command {
    param($Command)
    try {
        if (Get-Command $Command -ErrorAction SilentlyContinue) {
            return $true
        }
        return $false
    }
    catch {
        return $false
    }
}

function Install-Python {
    Write-Step "Checking Python installation"
    
    if (Test-Command "python") {
        $pythonVersion = python --version 2>$null
        if ($pythonVersion -match "Python 3\.([8-9]|\d{2})") {
            Write-Success "Python $pythonVersion is already installed and compatible"
            return $true
        }
        else {
            Write-Warning "Python version $pythonVersion is not compatible (need 3.8+)"
        }
    }
    
    Write-Step "Installing Python via Microsoft Store"
    Write-Host "Opening Microsoft Store for Python installation..." -ForegroundColor Yellow
    Write-Host "Please install Python 3.11 or newer from the Microsoft Store" -ForegroundColor Yellow
    Write-Host "Press any key after Python installation is complete..." -ForegroundColor Yellow
    
    try {
        Start-Process "ms-windows-store://pdp/?productid=9NRWMJP3717K"
        Read-Host
    }
    catch {
        Write-Error "Could not open Microsoft Store. Please manually install Python 3.8+ from python.org"
        return $false
    }
    
    # Verify installation
    if (Test-Command "python") {
        $pythonVersion = python --version 2>$null
        Write-Success "Python installation verified: $pythonVersion"
        return $true
    }
    else {
        Write-Error "Python installation failed or not in PATH"
        return $false
    }
}

function Install-Dependencies {
    Write-Step "Creating virtual environment"
    
    if (Test-Path "venv") {
        Write-Warning "Virtual environment already exists, using existing one"
    }
    else {
        python -m venv venv
        if ($LASTEXITCODE -ne 0) {
            Write-Error "Failed to create virtual environment"
            return $false
        }
        Write-Success "Virtual environment created"
    }
    
    Write-Step "Activating virtual environment"
    & ".\venv\Scripts\Activate.ps1"
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to activate virtual environment"
        return $false
    }
    Write-Success "Virtual environment activated"
    
    Write-Step "Upgrading pip"
    python -m pip install --upgrade pip
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "Pip upgrade failed, continuing anyway"
    }
    
    Write-Step "Installing PyTorch (this may take a while)"
    python -m pip install torch torchaudio --index-url https://download.pytorch.org/whl/cpu
    if ($LASTEXITCODE -ne 0) {
        Write-Error "PyTorch installation failed"
        return $false
    }
    Write-Success "PyTorch installed successfully"
    
    Write-Step "Installing remaining requirements"
    if (-not (Test-Path "requirements.txt")) {
        Write-Error "requirements.txt not found in current directory"
        return $false
    }
    
    python -m pip install -r requirements.txt
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Requirements installation failed"
        return $false
    }
    Write-Success "All requirements installed successfully"
    
    return $true
}

function Test-Installation {
    Write-Step "Testing installation"
    
    $testScript = @"
import sys
packages = ['torch', 'RealtimeSTT', 'openai', 'requests', 'pygame', 'numpy']
failed = []

for package in packages:
    try:
        __import__(package)
        print(f'✅ {package}')
    except ImportError as e:
        print(f'❌ {package}: {e}')
        failed.append(package)

if failed:
    print(f'\\nFailed imports: {", ".join(failed)}')
    sys.exit(1)
else:
    print('\\n🎉 All packages imported successfully!')
    
# Test PyTorch
import torch
print(f'PyTorch version: {torch.__version__}')
if torch.cuda.is_available():
    print(f'🚀 CUDA available: {torch.version.cuda}')
else:
    print('💡 Running on CPU (no CUDA)')
"@
    
    $testScript | python -
    return $LASTEXITCODE -eq 0
}

function Show-NextSteps {
    Write-Host "`n🎉 Installation completed successfully!" -ForegroundColor Green
    Write-Host "`n🚀 Next steps:" -ForegroundColor Cyan
    Write-Host "   1. Add your API keys to ada_clean.py:" -ForegroundColor White
    Write-Host "      - OpenAI API Key (line 130)" -ForegroundColor White
    Write-Host "      - ElevenLabs API Key (line 134)" -ForegroundColor White
    Write-Host "   2. Activate the virtual environment:" -ForegroundColor White
    Write-Host "      .\venv\Scripts\Activate.ps1" -ForegroundColor Yellow
    Write-Host "   3. Run Ada:" -ForegroundColor White
    Write-Host "      python ada_clean.py" -ForegroundColor Yellow
    Write-Host "   4. Click 'Start Listening' and say 'Hey Ada'!" -ForegroundColor White
    Write-Host "`n💡 Tip: Adjust the timing sliders for optimal performance" -ForegroundColor Cyan
    Write-Host "`n📋 To run Ada in the future:" -ForegroundColor Cyan
    Write-Host "   .\venv\Scripts\Activate.ps1" -ForegroundColor Yellow
    Write-Host "   python ada_clean.py" -ForegroundColor Yellow
}

# Main installation process
Write-Host "🎤 Ada Voice Assistant Installation" -ForegroundColor Cyan
Write-Host "=" * 50 -ForegroundColor Cyan

# Check if running as administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Warning "Not running as Administrator. Some installations may fail."
    Write-Host "Consider running: Start-Process PowerShell -Verb RunAs" -ForegroundColor Yellow
}

# Check Python installation
if (-not $SkipPython) {
    if (-not (Install-Python)) {
        Write-Error "Python installation failed"
        exit 1
    }
}

# Install dependencies
if (-not (Install-Dependencies)) {
    Write-Error "Dependency installation failed"
    exit 1
}

# Test installation
if (-not (Test-Installation)) {
    Write-Error "Installation verification failed"
    exit 1
}

# Show next steps
Show-NextSteps

Write-Host "`nInstallation complete! 🎉" -ForegroundColor Green
