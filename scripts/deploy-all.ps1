# Script de déploiement combiné (Git + GitHub Pages ou Vercel)
# Usage: .\deploy-all.ps1

param(
    [string]$message = "Update site"
)

Write-Host "🚀 Déploiement automatique complet" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

# Étape 1: Commit et push sur master
Write-Host "`n📦 Étape 1: Commit sur Git..." -ForegroundColor Yellow
Set-Location "C:\Users\Jaeme\Desktop\leadgen-site"
git add flo-landing/
git commit -m "$message - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git push origin master
Write-Host "✅ Push sur master réussi" -ForegroundColor Green

# Étape 2: Choix du déploiement
Write-Host "`n🌐 Étape 2: Déploiement..." -ForegroundColor Yellow
Write-Host "Choisissez votre plateforme:"
Write-Host "1 - GitHub Pages"
Write-Host "2 - Vercel"
Write-Host "3 - Les deux"
$choice = Read-Host "Votre choix (1/2/3)"

switch ($choice) {
    "1" {
        Write-Host "`n📄 Déploiement sur GitHub Pages..." -ForegroundColor Cyan
        # Mise à jour gh-pages
        git checkout gh-pages
        Remove-Item * -Recurse -Force -Exclude .git,.gitignore
        Copy-Item -Path flo-landing\* -Destination . -Recurse -Force
        git add .
        git commit -m "Deploy: $message"
        git push origin gh-pages
        git checkout master
        Write-Host "✅ Déployé sur https://jaemeson-ra.github.io/leadgen-site/" -ForegroundColor Green
    }
    "2" {
        Write-Host "`n🔺 Déploiement sur Vercel..." -ForegroundColor Cyan
        Set-Location flo-landing
        vercel --prod
        Set-Location ..
        Write-Host "✅ Déployé sur Vercel" -ForegroundColor Green
    }
    "3" {
        Write-Host "`n📄 Déploiement sur GitHub Pages..." -ForegroundColor Cyan
        git checkout gh-pages
        Remove-Item * -Recurse -Force -Exclude .git,.gitignore
        Copy-Item -Path flo-landing\* -Destination . -Recurse -Force
        git add .
        git commit -m "Deploy: $message"
        git push origin gh-pages
        git checkout master
        
        Write-Host "`n🔺 Déploiement sur Vercel..." -ForegroundColor Cyan
        Set-Location flo-landing
        vercel --prod
        Set-Location ..
        
        Write-Host "✅ Déployé sur GitHub Pages ET Vercel" -ForegroundColor Green
    }
    default {
        Write-Host "❌ Choix invalide" -ForegroundColor Red
        exit 1
    }
}

Write-Host "`n🎉 Déploiement terminé !" -ForegroundColor Green
