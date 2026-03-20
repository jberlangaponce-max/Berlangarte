// ==========================================
// 1. DICCIONARIO DE TRADUCCIONES (i18n)
// ==========================================

const translations = {
    es: {
        nav_logo: "jose berlanga",
        nav_home: "Inicio",
        nav_about: "Sobre Mí",
        nav_gallery: "Galería",
        nav_shop: "Tienda",
        nav_contact: "Contacto",

        hero_title: "José Berlanga",
        hero_subtitle: "SevenArt",

        about_title: "Sobre Mí",
        about_p1: "Soy Jose Berlanga, pintor de Málaga de formación autodidacta, y mi trabajo explora el color, la luz, las formas, la interactuación entre ellas y la perfección simbólica del número 7, siendo este número no una simple cifra, sino el hilo conductor que teje la narrativa de casi toda mi obra. Utilizo principalmente la técnica del óleo, la acuarela y el dibujo para crear imágenes que inviten a la curiosidad, exploración, descubrimiento y la contemplación.",
        about_quote_1: "\"Si formamos en nuestra imaginación una representación icónica de la vida, esquematizada y de alguna manera diagramática, si podemos visualizar geométricamente estos símbolos y tratamos de aplicar diversas fórmulas o reglas de relación entre ellos, habremos creado, de algún modo, un universo gobernado por criterios más o menos coherentes, pero siempre a merced del autor.",
        about_quote_2: "Expresiones figurativas y abstractas, sujetas, unas a la numerología (serie de 7 elementos o seven art), y otras al equilibrio y distribución dentro de un espacio cerrado configurado y enmarcado.",
        about_quote_3: "Los diagramas se transforman y relacionan de diversos modos, buscando en ocasiones la simplicidad, el guiño o la iluminación, pero siempre con la intersección como parte fundamental del juego y el diálogo.\"",

        gallery_title: "Galería",
        filter_all: "Todas",
        filter_expo1: "Mira el pajarito",

        shop_title: "Catálogo / Obras Disponibles",
        shop_item_1: "abejaruco",
        shop_item_2: "aguila calva",
        shop_item_3: "aguila real",
        shop_item_4: "aguilucho",
        shop_item_5: "atuka",
        shop_item_6: "azulejo",
        shop_item_7: "buho",
        shop_item_8: "cardenalillo",
        shop_item_9: "cigueña",
        shop_item_10: "colores",
        shop_item_11: "colorin",
        shop_item_12: "flamenco",
        shop_item_13: "gallito",
        shop_item_14: "gallo",
        shop_item_15: "garza",
        shop_item_16: "gorrion",
        shop_item_17: "guacamayos",
        shop_item_18: "jilguero",
        shop_item_19: "lorito",
        shop_item_20: "martin pescador",
        shop_item_21: "paloma",
        shop_item_22: "perdiz",
        shop_item_23: "picoancho",
        shop_item_24: "tucan",
        shop_item_25: "la mirada del martin",
        shop_item_26: "tukana sepiida",
        shop_item_27: "emperador",
        shop_item_28: "papagallo",
        shop_item_29: "guacamar",

        btn_interest: "Me interesa",

        contact_title: "Contacto",
        label_name: "Nombre",
        label_email: "Correo Electrónico",
        label_subject: "Asunto",
        label_message: "Mensaje",
        btn_send: "Enviar Mensaje",

        footer_rights: "Todos los derechos reservados."
    },
    en: {
        nav_logo: "jose berlanga",
        nav_home: "Home",
        nav_about: "About",
        nav_gallery: "Gallery",
        nav_shop: "Shop",
        nav_contact: "Contact",

        hero_title: "José Berlanga",
        hero_subtitle: "SevenArt",

        about_title: "About Me",
        about_p1: "I am Jose Berlanga, a self-taught painter from Málaga, and my work explores color, light, shapes, their interaction and the symbolic perfection of the number 7, being this number not a simple figure, but the guiding thread that weaves the narrative of almost all my work. I mainly use oil, watercolor and drawing techniques to create images that invite curiosity, exploration, discovery and contemplation.",
        about_quote_1: "\"If we form in our imagination an iconic representation of life, schematized and somewhat diagrammatic, if we can geometrically visualize these symbols and try to apply various formulas or rules of relationship between them, we will have created, in some way, a universe governed by more or less coherent criteria, but always at the mercy of the author.",
        about_quote_2: "Figurative and abstract expressions, subject, some to numerology (series of 7 elements or seven art), and others to balance and distribution within a configured and framed enclosed space.",
        about_quote_3: "The diagrams transform and relate in various ways, sometimes seeking simplicity, a wink or illumination, but always with intersection as a fundamental part of the game and dialogue.\"",

        gallery_title: "Gallery",
        filter_all: "All",
        filter_expo1: "Mira el pajarito",

        shop_title: "Catalog / Available Artworks",
        shop_item_1: "abejaruco",
        shop_item_2: "aguila calva",
        shop_item_3: "aguila real",
        shop_item_4: "aguilucho",
        shop_item_5: "atuka",
        shop_item_6: "azulejo",
        shop_item_7: "buho",
        shop_item_8: "cardenalillo",
        shop_item_9: "cigueña",
        shop_item_10: "colores",
        shop_item_11: "colorin",
        shop_item_12: "flamenco",
        shop_item_13: "gallito",
        shop_item_14: "gallo",
        shop_item_15: "garza",
        shop_item_16: "gorrion",
        shop_item_17: "guacamayos",
        shop_item_18: "jilguero",
        shop_item_19: "lorito",
        shop_item_20: "martin pescador",
        shop_item_21: "paloma",
        shop_item_22: "perdiz",
        shop_item_23: "picoancho",
        shop_item_24: "tucan",
        shop_item_25: "la mirada del martin",
        shop_item_26: "tukana sepiida",
        shop_item_27: "emperador",
        shop_item_28: "papagallo",
        shop_item_29: "guacamar",

        btn_interest: "I am interested",

        contact_title: "Contact",
        label_name: "Name",
        label_email: "Email",
        label_subject: "Subject",
        label_message: "Message",
        btn_send: "Send Message",

        footer_rights: "All rights reserved."
    }
};

let currentLang = 'es';

function changeLanguage(lang) {
    currentLang = lang;

    document.getElementById('btn-es').classList.toggle('active', lang === 'es');
    document.getElementById('btn-en').classList.toggle('active', lang === 'en');

    const elements = document.querySelectorAll('[data-i18n]');
    elements.forEach(el => {
        const key = el.getAttribute('data-i18n');
        if (translations[lang][key]) {
            el.textContent = translations[lang][key];
        }
    });

    document.documentElement.lang = lang;
}

document.getElementById('btn-es').addEventListener('click', () => changeLanguage('es'));
document.getElementById('btn-en').addEventListener('click', () => changeLanguage('en'));


// ==========================================
// 2. FILTRADO DE LA GALERÍA
// ==========================================
function setupGalleryFilters() {
    const filterBtns = document.querySelectorAll('.filter-btn');
    const galleryItems = document.querySelectorAll('.gallery-item');

    galleryItems.forEach(item => item.classList.add('show'));

    filterBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            filterBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const filterValue = btn.getAttribute('data-filter');

            galleryItems.forEach(item => {
                if (filterValue === 'all') {
                    item.classList.add('show');
                } else {
                    if (item.classList.contains(filterValue)) {
                        item.classList.add('show');
                    } else {
                        item.classList.remove('show');
                    }
                }
            });
        });
    });
}


// ==========================================
// 3. BOTONES "ME INTERESA" DE LA TIENDA
// ==========================================
function setupShopInterestButtons() {
    const interestBtns = document.querySelectorAll('.btn-interest');
    const contactSection = document.getElementById('contact');
    const subjectInput = document.getElementById('subject');

    interestBtns.forEach(btn => {
        btn.addEventListener('click', () => {

            const infoDiv = btn.parentElement;
            const titleElement = infoDiv.querySelector('h3');

            const targetTitle = titleElement.getAttribute('data-name') || titleElement.textContent;

            if (currentLang === 'es') {
                subjectInput.value = `Me interesa la obra: ${targetTitle}`;
            } else {
                subjectInput.value = `I am interested in the artwork: ${targetTitle}`;
            }

            contactSection.scrollIntoView({ behavior: 'smooth' });

            setTimeout(() => {
                const nameInput = document.getElementById('name');
                if (nameInput) nameInput.focus();
            }, 600);
        });
    });
}

// ==========================================
// 4. EFECTO FADE IN LOGO
// ==========================================
function setupLogoVisibility() {
    const logo = document.querySelector('.logo');
    const heroSection = document.getElementById('hero');

    if (!logo || !heroSection) return;

    window.addEventListener('scroll', () => {
        // If we scrolled past half of the hero section or 100px down, show it.
        // It's much more reliable on all mobile devices than IntersectionObserver bounds
        if (window.scrollY > (heroSection.offsetHeight * 0.5) || window.scrollY > 300) {
            logo.classList.add('show-logo');
        } else {
            logo.classList.remove('show-logo');
        }
    });

    // Run once to catch initial state (e.g. if user refreshed halfway down)
    const event = new Event('scroll');
    window.dispatchEvent(event);
}

// ==========================================
// 5. INICIALIZACIÓN GENERAL
// ==========================================
document.addEventListener('DOMContentLoaded', () => {
    changeLanguage('es');
    setupGalleryFilters();
    setupShopInterestButtons();
    setupLogoVisibility();

    const yearSpan = document.getElementById('year');
    if (yearSpan) {
        yearSpan.textContent = new Date().getFullYear();
    }
});
