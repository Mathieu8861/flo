# Script de déploiement Vercel automatique
# Usage: .\deploy-vercel.ps1

Write-Host "🚀 Déploiement sur Vercel..." -ForegroundColor Cyan

# Aller dans le dossier flo-landing
Set-Location "C:\Users\Jaeme\Desktop\leadgen-site\flo-landing"

# Déployer sur Vercel
vercel --prod

Write-Host "✅ Déploiement terminé !" -ForegroundColor Green
