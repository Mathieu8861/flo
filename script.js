// ============================================
// INITIALISATION AU CHARGEMENT
// ============================================
document.addEventListener('DOMContentLoaded', function() {
    // Initialiser Lucide icons
    lucide.createIcons();
    
    // Démarrer l'effet vague
    startWaveEffect();
    
    // Carrousel témoignages
    initTestimonialsCarousel();
});

// ============================================
// EFFET VAGUE BLEU - COMMENT ÇA MARCHE
// ============================================
function startWaveEffect() {
    const boxes = document.querySelectorAll('.step-box');
    
    if (boxes.length === 0) return;
    
    let currentIndex = 0;
    
    // Activer la première carte
    boxes[0].classList.add('active');
    
    // Changer de carte toutes les 1.5 secondes
    setInterval(function() {
        // Désactiver toutes les cartes
        boxes.forEach(box => box.classList.remove('active'));
        
        // Passer à la carte suivante
        currentIndex = (currentIndex + 1) % boxes.length;
        
        // Activer la nouvelle carte
        boxes[currentIndex].classList.add('active');
    }, 1500);
}

// ============================================
// CARROUSEL TÉMOIGNAGES
// ============================================
function initTestimonialsCarousel() {
    const track = document.getElementById('testimonials-track');
    if (track) {
        const cards = Array.from(track.children);
        cards.forEach(card => {
            const clone = card.cloneNode(true);
            track.appendChild(clone);
        });
    }
}

// ============================================
// HEADER SCROLL
// ============================================
const header = document.getElementById('header');
if (header) {
    window.addEventListener('scroll', function() {
        if (window.scrollY > 100) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });
}

// ============================================
// NAVIGATION MOBILE
// ============================================
const navToggle = document.getElementById('nav-toggle');
const navMenu = document.querySelector('.nav__menu');

if (navToggle && navMenu) {
    navToggle.addEventListener('click', function() {
        navMenu.classList.toggle('active');
    });
    
    document.addEventListener('click', function(e) {
        if (!navToggle.contains(e.target) && !navMenu.contains(e.target)) {
            navMenu.classList.remove('active');
        }
    });
}

// ============================================
// PRICING SLIDER
// ============================================
const employeesSlider = document.getElementById('employees');
if (employeesSlider) {
    const employeesCount = document.getElementById('employees-count');
    const priceDisplay = document.getElementById('price');
    const pricePerUserDisplay = document.getElementById('price-per-user');
    
    employeesSlider.addEventListener('input', function() {
        const emp = parseInt(this.value);
        let ppu;
        if (emp <= 10) ppu = 7.90;
        else if (emp <= 50) ppu = 6.90;
        else if (emp <= 100) ppu = 5.90;
        else if (emp <= 200) ppu = 4.90;
        else ppu = 3.90;
        
        employeesCount.textContent = emp;
        priceDisplay.textContent = Math.round(emp * ppu);
        pricePerUserDisplay.textContent = ppu.toFixed(2);
    });
}

// ============================================
// FAQ ACCORDION
// ============================================
document.querySelectorAll('.faq-item').forEach(function(item) {
    const question = item.querySelector('.faq-item__question');
    const answer = item.querySelector('.faq-item__answer');
    
    if (question && answer) {
        question.addEventListener('click', function() {
            const isOpen = item.classList.contains('active');
            
            // Fermer tous les autres
            document.querySelectorAll('.faq-item').forEach(function(i) {
                i.classList.remove('active');
                const a = i.querySelector('.faq-item__answer');
                if (a) a.style.maxHeight = null;
            });
            
            // Ouvrir celui-ci si fermé
            if (!isOpen) {
                item.classList.add('active');
                answer.style.maxHeight = answer.scrollHeight + 'px';
            }
        });
    }
});

// ============================================
// SMOOTH SCROLL
// ============================================
document.querySelectorAll('a[href^="#"]').forEach(function(anchor) {
    anchor.addEventListener('click', function(e) {
        const href = this.getAttribute('href');
        if (href === '#') {
            e.preventDefault();
            return;
        }
        
        const target = document.querySelector(href);
        if (target && header) {
            e.preventDefault();
            const offset = header.offsetHeight;
            const position = target.getBoundingClientRect().top + window.pageYOffset - offset;
            
            window.scrollTo({
                top: position,
                behavior: 'smooth'
            });
        }
    });
});


// ============================================
// AVANT/APRÈS - CARROUSEL MOBILE (FONDU FLUIDE)
// ============================================
function initBeforeAfterCarousel() {
    // Seulement sur mobile
    if (window.innerWidth > 768) return;
    
    const grid = document.querySelector('.before-after__grid');
    const cards = document.querySelectorAll('.before-after__card');
    const dots = document.querySelectorAll('.before-after__dot');
    
    if (!grid || cards.length < 2) return;
    
    let currentSlide = 0;
    let hasAutoPlayed = false;
    let isAnimating = false;
    
    // Activer la première carte et le premier dot
    cards[0].classList.add('active');
    dots[0].classList.add('active');
    
    function goToSlide(index) {
        if (isAnimating || index === currentSlide) return;
        isAnimating = true;
        
        // Désactiver le dot actuel
        dots[currentSlide].classList.remove('active');
        
        // Activer le nouveau dot
        dots[index].classList.add('active');
        
        // Transition fluide: d'abord montrer la nouvelle carte
        cards[index].classList.add('active');
        
        // Puis cacher l'ancienne après un court délai
        setTimeout(() => {
            cards[currentSlide].classList.remove('active');
            currentSlide = index;
            isAnimating = false;
        }, 50);
    }
    
    // Navigation par dots
    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => {
            goToSlide(index);
        });
    });
    
    // Swipe sur les cartes
    let touchStartX = 0;
    
    grid.addEventListener('touchstart', (e) => {
        touchStartX = e.changedTouches[0].screenX;
    }, { passive: true });
    
    grid.addEventListener('touchend', (e) => {
        const touchEndX = e.changedTouches[0].screenX;
        const diff = touchStartX - touchEndX;
        
        if (Math.abs(diff) > 50) {
            if (diff > 0 && currentSlide < cards.length - 1) {
                goToSlide(currentSlide + 1);
            } else if (diff < 0 && currentSlide > 0) {
                goToSlide(currentSlide - 1);
            }
        }
    }, { passive: true });
    
    // Auto-play une seule fois (après 2.5 secondes)
    setTimeout(() => {
        if (!hasAutoPlayed && currentSlide === 0) {
            goToSlide(1);
            hasAutoPlayed = true;
        }
    }, 2500);
}

// Initialiser au chargement
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(initBeforeAfterCarousel, 100);

    // Init mobile V6 interactions
    initMobileV6();
});


// ============================================
// MOBILE V6 INTERACTIONS
// ============================================
function initMobileV6() {
    // ===== BURGER MENU =====
    const burger = document.getElementById('mobile-burger');
    const mobileMenu = document.getElementById('mobile-menu');

    if (burger && mobileMenu) {
        burger.addEventListener('click', function() {
            burger.classList.toggle('active');
            mobileMenu.classList.toggle('active');
            document.body.classList.toggle('mobile-menu-open');
        });

        // Fermer le menu quand on clique sur un lien
        mobileMenu.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', function() {
                burger.classList.remove('active');
                mobileMenu.classList.remove('active');
                document.body.classList.remove('mobile-menu-open');
            });
        });
    }

    // ===== PROFILES TABS (CAS D'USAGE) =====
    const profileTabs = document.querySelectorAll('.profiles-mobile__tab');
    const profileCards = document.querySelectorAll('.profiles-mobile__card');

    profileTabs.forEach(tab => {
        tab.addEventListener('click', function() {
            const tabId = this.dataset.tab;

            // Désactiver tous les tabs et cards
            profileTabs.forEach(t => t.classList.remove('active'));
            profileCards.forEach(c => c.classList.remove('active'));

            // Activer le tab cliqué et sa card
            this.classList.add('active');
            const targetCard = document.querySelector(`.profiles-mobile__card[data-content="${tabId}"]`);
            if (targetCard) targetCard.classList.add('active');
        });
    });

    // ===== FAQ MOBILE ACCORDION =====
    const faqItems = document.querySelectorAll('.faq-mobile__item');

    faqItems.forEach(item => {
        item.addEventListener('click', function() {
            const isActive = this.classList.contains('active');

            // Fermer tous les autres
            faqItems.forEach(i => i.classList.remove('active'));

            // Ouvrir celui-ci si fermé
            if (!isActive) {
                this.classList.add('active');
            }
        });
    });

    // ===== TÉMOIGNAGES CAROUSEL =====
    const testimonialCards = document.querySelectorAll('.testimonials-mobile__card');
    const testimonialDots = document.querySelectorAll('.testimonials-mobile__dot');

    if (testimonialDots.length > 0 && testimonialCards.length > 0) {
        testimonialDots.forEach((dot, index) => {
            dot.addEventListener('click', function() {
                // Désactiver tous
                testimonialCards.forEach(c => c.classList.remove('active'));
                testimonialDots.forEach(d => d.classList.remove('active'));

                // Activer celui-ci
                if (testimonialCards[index]) testimonialCards[index].classList.add('active');
                this.classList.add('active');
            });
        });

        // Auto-play témoignages
        let currentTestimonial = 0;
        setInterval(() => {
            currentTestimonial = (currentTestimonial + 1) % testimonialCards.length;

            testimonialCards.forEach(c => c.classList.remove('active'));
            testimonialDots.forEach(d => d.classList.remove('active'));

            testimonialCards[currentTestimonial].classList.add('active');
            testimonialDots[currentTestimonial].classList.add('active');
        }, 5000);
    }

    // ===== VIDEO TABS =====
    const videoTabs = document.querySelectorAll('.video-mobile__tab');

    videoTabs.forEach(tab => {
        tab.addEventListener('click', function() {
            videoTabs.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
        });
    });
}
