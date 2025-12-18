# ============================================
# SCRIPT DE REORGANISATION - PROJET FLO
# Regen Agency - Decembre 2024
# ============================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  REORGANISATION DU PROJET FLO" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Verifier qu on est dans le bon dossier
if (-not (Test-Path "index.html")) {
    Write-Host "ERREUR: index.html non trouve!" -ForegroundColor Red
    Write-Host "Assurez-vous d etre dans le dossier du projet." -ForegroundColor Yellow
    exit 1
}

Write-Host "Dossier actuel: $(Get-Location)" -ForegroundColor Gray
Write-Host ""

# ============================================
# ETAPE 1: Creer les dossiers
# ============================================
Write-Host "Creation de la structure de dossiers..." -ForegroundColor Yellow

$folders = @(
    "assets",
    "assets/images",
    "assets/profiles",
    "assets/video",
    "scripts",
    "docs"
)

foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder -Force | Out-Null
        Write-Host "   Cree: $folder" -ForegroundColor Green
    } else {
        Write-Host "   Existe deja: $folder" -ForegroundColor Gray
    }
}

Write-Host ""

# ============================================
# ETAPE 2: Deplacer les images generales
# ============================================
Write-Host "Deplacement des images..." -ForegroundColor Yellow

$images = @(
    "logo-flo.png",
    "hero-illustration.png",
    "tanguy.webp"
)

foreach ($img in $images) {
    if (Test-Path $img) {
        Move-Item -Path $img -Destination "assets/images/$img" -Force
        Write-Host "   Deplace: $img vers assets/images/" -ForegroundColor Green
    }
}

# ============================================
# ETAPE 3: Deplacer les images de profils
# ============================================
Write-Host ""
Write-Host "Deplacement des images de profils..." -ForegroundColor Yellow

$profiles = Get-ChildItem -Name "profile-*.jpg" -ErrorAction SilentlyContinue

foreach ($profile in $profiles) {
    if (Test-Path $profile) {
        Move-Item -Path $profile -Destination "assets/profiles/$profile" -Force
        Write-Host "   Deplace: $profile vers assets/profiles/" -ForegroundColor Green
    }
}

# ============================================
# ETAPE 4: Deplacer les videos
# ============================================
Write-Host ""
Write-Host "Deplacement des videos..." -ForegroundColor Yellow

$videos = @(
    "hero-video.mp4"
)

foreach ($video in $videos) {
    if (Test-Path $video) {
        Move-Item -Path $video -Destination "assets/video/$video" -Force
        Write-Host "   Deplace: $video vers assets/video/" -ForegroundColor Green
    }
}

# ============================================
# ETAPE 5: Deplacer les scripts PowerShell
# ============================================
Write-Host ""
Write-Host "Deplacement des scripts..." -ForegroundColor Yellow

$psScripts = @(
    "deploy-all.ps1",
    "deploy-github-pages.ps1",
    "deploy-vercel.ps1"
)

foreach ($script in $psScripts) {
    if (Test-Path $script) {
        Move-Item -Path $script -Destination "scripts/$script" -Force
        Write-Host "   Deplace: $script vers scripts/" -ForegroundColor Green
    }
}

# ============================================
# ETAPE 6: Supprimer les fichiers inutiles
# ============================================
Write-Host ""
Write-Host "Suppression des fichiers inutiles..." -ForegroundColor Yellow

$toDelete = @(
    "mobile.css",
    "desktop.ini"
)

foreach ($file in $toDelete) {
    if (Test-Path $file) {
        Remove-Item -Path $file -Force
        Write-Host "   Supprime: $file" -ForegroundColor Green
    }
}

# ============================================
# ETAPE 7: Mettre a jour les chemins dans index.html
# ============================================
Write-Host ""
Write-Host "Mise a jour des chemins dans index.html..." -ForegroundColor Yellow

if (Test-Path "index.html") {
    $content = Get-Content "index.html" -Raw -Encoding UTF8
    
    # Images generales
    $content = $content -replace 'src="logo-flo.png"', 'src="assets/images/logo-flo.png"'
    $content = $content -replace 'href="logo-flo.png"', 'href="assets/images/logo-flo.png"'
    $content = $content -replace 'src="hero-illustration.png"', 'src="assets/images/hero-illustration.png"'
    $content = $content -replace 'src="tanguy.webp"', 'src="assets/images/tanguy.webp"'
    
    # Profils
    $content = $content -replace 'src="profile-rh.jpg"', 'src="assets/profiles/profile-rh.jpg"'
    $content = $content -replace 'src="profile-commercial.jpg"', 'src="assets/profiles/profile-commercial.jpg"'
    $content = $content -replace 'src="profile-developpeur.jpg"', 'src="assets/profiles/profile-developpeur.jpg"'
    $content = $content -replace 'src="profile-manager.jpg"', 'src="assets/profiles/profile-manager.jpg"'
    $content = $content -replace 'src="profile-support.jpg"', 'src="assets/profiles/profile-support.jpg"'
    $content = $content -replace 'src="profile-avis1.jpg"', 'src="assets/profiles/profile-avis1.jpg"'
    
    # Video
    $content = $content -replace 'src="hero-video.mp4"', 'src="assets/video/hero-video.mp4"'
    
    # Supprimer le lien vers mobile.css si present
    $content = $content -replace '<link rel="stylesheet" href="mobile.css">\s*\r?\n?', ''
    
    # Sauvegarder
    Set-Content "index.html" -Value $content -Encoding UTF8
    Write-Host "   index.html mis a jour" -ForegroundColor Green
}

# ============================================
# ETAPE 8: Mettre a jour les chemins dans demo.html
# ============================================
Write-Host ""
Write-Host "Mise a jour des chemins dans demo.html..." -ForegroundColor Yellow

if (Test-Path "demo.html") {
    $content = Get-Content "demo.html" -Raw -Encoding UTF8
    
    # Images generales
    $content = $content -replace 'src="logo-flo.png"', 'src="assets/images/logo-flo.png"'
    $content = $content -replace 'href="logo-flo.png"', 'href="assets/images/logo-flo.png"'
    $content = $content -replace 'src="hero-illustration.png"', 'src="assets/images/hero-illustration.png"'
    $content = $content -replace 'src="tanguy.webp"', 'src="assets/images/tanguy.webp"'
    
    # Supprimer le lien vers mobile.css si present
    $content = $content -replace '<link rel="stylesheet" href="mobile.css">\s*\r?\n?', ''
    
    # Sauvegarder
    Set-Content "demo.html" -Value $content -Encoding UTF8
    Write-Host "   demo.html mis a jour" -ForegroundColor Green
}

# ============================================
# ETAPE 9: Mettre a jour les chemins dans style.css
# ============================================
Write-Host ""
Write-Host "Mise a jour des chemins dans style.css..." -ForegroundColor Yellow

if (Test-Path "style.css") {
    $content = Get-Content "style.css" -Raw -Encoding UTF8
    
    # URLs d images dans le CSS
    $content = $content -replace 'url\(logo-flo\.png\)', 'url(assets/images/logo-flo.png)'
    $content = $content -replace 'url\(hero-illustration\.png\)', 'url(assets/images/hero-illustration.png)'
    
    # Sauvegarder
    Set-Content "style.css" -Value $content -Encoding UTF8
    Write-Host "   style.css mis a jour" -ForegroundColor Green
}

# ============================================
# RESUME FINAL
# ============================================
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  REORGANISATION TERMINEE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Nouvelle structure:" -ForegroundColor White
Write-Host ""
Write-Host "   Site FLO/" -ForegroundColor Gray
Write-Host "   |-- index.html" -ForegroundColor White
Write-Host "   |-- demo.html" -ForegroundColor White
Write-Host "   |-- style.css" -ForegroundColor White
Write-Host "   |-- script.js" -ForegroundColor White
Write-Host "   |" -ForegroundColor Gray
Write-Host "   |-- assets/" -ForegroundColor Yellow
Write-Host "   |   |-- images/" -ForegroundColor Yellow
Write-Host "   |   |-- profiles/" -ForegroundColor Yellow
Write-Host "   |   |-- video/" -ForegroundColor Yellow
Write-Host "   |" -ForegroundColor Gray
Write-Host "   |-- scripts/" -ForegroundColor Yellow
Write-Host "   |-- docs/" -ForegroundColor Yellow
Write-Host ""

# ============================================
# PROCHAINES ETAPES
# ============================================
Write-Host "Prochaines etapes:" -ForegroundColor Cyan
Write-Host ""
Write-Host "   1. Verifier le site en local (ouvrir index.html)" -ForegroundColor White
Write-Host ""
Write-Host "   2. Commit et push:" -ForegroundColor White
Write-Host "      git add ." -ForegroundColor Yellow
Write-Host "      git commit -m Reorganisation-structure" -ForegroundColor Yellow
Write-Host "      git push origin gh-pages" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
