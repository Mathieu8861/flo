# Script de deploiement GitHub Pages automatique
Write-Host "Deploiement sur GitHub Pages..." -ForegroundColor Cyan
Set-Location "C:\Site Flo\drive-download-20251202T184223Z-3-001"
git add .
git commit -m "Update site"
git push origin gh-pages
Write-Host "Deploiement termine !" -ForegroundColor Green
Write-Host "Site disponible sur: https://mathieu8861.github.io/leadgen-site/" -ForegroundColor Cyan
