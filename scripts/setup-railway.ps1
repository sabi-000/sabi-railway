$ErrorActionPreference = 'Stop'

Write-Host 'Checking Railway CLI...' -ForegroundColor Cyan
if (-not (Get-Command railway -ErrorAction SilentlyContinue)) {
  if (Get-Command npm -ErrorAction SilentlyContinue) {
    Write-Host 'Railway CLI not found. Installing @railway/cli with npm...' -ForegroundColor Yellow
    npm install -g @railway/cli
  } else {
    throw 'Railway CLI and npm are not installed. Install Node.js/npm first, then rerun this script.'
  }
}

if (-not (Get-Command railway -ErrorAction SilentlyContinue)) {
  throw 'Railway CLI installation did not complete. Open a new PowerShell window and rerun this script.'
}

Write-Host 'Deploying the current repository...' -ForegroundColor Cyan
railway up -y

Write-Host 'Creating or attaching the persistent /data volume...' -ForegroundColor Cyan
railway volume add --mount-path /data

Write-Host 'Generating a Railway service domain...' -ForegroundColor Cyan
railway domain

Write-Host 'Setup finished. Check the Railway dashboard for the generated domain.' -ForegroundColor Green
