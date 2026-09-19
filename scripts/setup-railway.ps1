$ErrorActionPreference = 'Stop'

Write-Host 'Checking Railway CLI...' -ForegroundColor Cyan
if (-not (Get-Command railway -ErrorAction SilentlyContinue)) {
  throw 'Railway CLI is not installed. Install it from https://docs.railway.com/cli and run railway login.'
}

Write-Host 'Deploying the current repository...' -ForegroundColor Cyan
railway up -y

Write-Host 'Creating or attaching the persistent /data volume...' -ForegroundColor Cyan
railway volume add --mount-path /data

Write-Host 'Generating a Railway service domain...' -ForegroundColor Cyan
railway domain

Write-Host 'Setup finished. Check the Railway dashboard for the generated domain.' -ForegroundColor Green
