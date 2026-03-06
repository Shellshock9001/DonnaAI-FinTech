<# 
.SYNOPSIS
  Donna FinTech — Automated Setup Script (Windows)
.DESCRIPTION
  Checks prerequisites, installs dependencies, configures environment,
  builds the production frontend, and prints getting-started instructions.
#>

$ErrorActionPreference = "Stop"

function Write-Banner {
  Write-Host ""
  Write-Host "  ╔═══════════════════════════════════════════════╗" -ForegroundColor Cyan
  Write-Host "  ║  Donna FinTech — Financial Intelligence Graph ║" -ForegroundColor Cyan
  Write-Host "  ║        Automated Setup for Windows            ║" -ForegroundColor Cyan
  Write-Host "  ╚═══════════════════════════════════════════════╝" -ForegroundColor Cyan
  Write-Host ""
}

function Write-Step  { param($msg) Write-Host "`n▸ $msg" -ForegroundColor Green }
function Write-Ok    { param($msg) Write-Host "  ✓ $msg" -ForegroundColor Green }
function Write-Warn  { param($msg) Write-Host "  ⚠ $msg" -ForegroundColor Yellow }
function Write-Fail  { param($msg) Write-Host "  ✕ $msg" -ForegroundColor Red; exit 1 }

# ── Check prerequisites ──
function Test-Prerequisites {
  Write-Step "Checking prerequisites..."
  
  # Node.js
  try {
    $nodeVer = (node -v) -replace 'v', ''
    $nodeMajor = [int]($nodeVer.Split('.')[0])
    if ($nodeMajor -ge 18) {
      Write-Ok "Node.js $nodeVer"
    } else {
      Write-Fail "Node.js 18+ required (found $nodeVer). Download from https://nodejs.org"
    }
  } catch {
    Write-Fail "Node.js not found. Download from https://nodejs.org (v18 or later)"
  }

  # npm
  try {
    $npmVer = npm -v 2>$null
    Write-Ok "npm $npmVer"
  } catch {
    Write-Fail "npm not found. It should come with Node.js."
  }

  # Git
  try {
    $gitVer = (git --version) -replace 'git version ', ''
    Write-Ok "Git $gitVer"
  } catch {
    Write-Warn "Git not found — not required but recommended."
  }

  # Docker
  $script:DockerAvailable = $false
  try {
    $dockerVer = (docker --version) -replace 'Docker version ', '' -replace ',.*', ''
    Write-Ok "Docker $dockerVer"
    $script:DockerAvailable = $true
  } catch {
    Write-Warn "Docker not found — Docker deployment will be unavailable."
  }
}

# ── Install dependencies ──
function Install-Dependencies {
  Write-Step "Installing Node.js dependencies..."
  npm install --no-audit --no-fund 2>&1 | Select-Object -Last 1
  Write-Ok "Dependencies installed"
}

# ── Setup environment ──
function Initialize-Environment {
  Write-Step "Setting up environment..."
  if (-not (Test-Path ".env")) {
    Copy-Item ".env.example" ".env"
    $jwt = node -e "console.log(require('crypto').randomBytes(64).toString('hex'))"
    (Get-Content ".env") -replace 'CHANGE_ME_TO_A_RANDOM_64_CHAR_HEX_STRING', $jwt | Set-Content ".env"
    Write-Ok "Created .env with generated JWT secret"
  } else {
    Write-Ok ".env already exists — skipping"
  }
}

# ── Create data directory ──
function Initialize-DataDir {
  Write-Step "Creating data directory..."
  if (-not (Test-Path "data")) { New-Item -ItemType Directory -Path "data" | Out-Null }
  Write-Ok "data/ directory ready"
}

# ── Build frontend ──
function Build-Frontend {
  Write-Step "Building frontend for production..."
  npm run build 2>&1 | Select-Object -Last 3
  Write-Ok "Frontend built to dist/"
}

# ── Summary ──
function Write-Summary {
  Write-Host ""
  Write-Host "  ╔═══════════════════════════════════════════════╗" -ForegroundColor Cyan
  Write-Host "  ║             Setup Complete! 🎉                ║" -ForegroundColor Cyan
  Write-Host "  ╚═══════════════════════════════════════════════╝" -ForegroundColor Cyan
  Write-Host ""
  Write-Host "  Start development server:" -ForegroundColor White
  Write-Host "    npm run dev" -ForegroundColor Cyan
  Write-Host "    → Frontend: http://localhost:5173" -ForegroundColor Green
  Write-Host "    → API:      http://localhost:3001" -ForegroundColor Green
  Write-Host ""
  Write-Host "  Start production server:" -ForegroundColor White
  Write-Host "    npm start" -ForegroundColor Cyan
  Write-Host "    → App: http://localhost:3001" -ForegroundColor Green
  Write-Host ""

  if ($script:DockerAvailable) {
    Write-Host "  Docker deployment (for sharing on LAN):" -ForegroundColor White
    Write-Host "    docker compose up --build -d" -ForegroundColor Cyan
    Write-Host "    → App: http://<YOUR_IP>:3001" -ForegroundColor Green
    Write-Host ""
  }

  Write-Host "  Default admin accounts:" -ForegroundColor White
  Write-Host ""
  Write-Host "    Shellshock (Super Admin)" -ForegroundColor Yellow
  Write-Host "    Email:    shellshock9001@gmail.com"
  Write-Host "    Password: DonnAI2026!"
  Write-Host ""
  Write-Host "    DonnaAI (Admin)" -ForegroundColor Yellow
  Write-Host "    Email:    donna@donnaai.com"
  Write-Host "    Password: DonnAI2026!"
  Write-Host ""
  Write-Host "  ⚠ Change these passwords after first login!" -ForegroundColor Red
  Write-Host ""
}

# ── Main ──
Write-Banner
Test-Prerequisites
Install-Dependencies
Initialize-Environment
Initialize-DataDir
Build-Frontend
Write-Summary
