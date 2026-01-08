(function() {
    'use strict';

    const SYSTEM_USE_CONFIG_EN = {
        title: 'Government of Canada',
        message: `
            <h4>System Use</h4>
            <p>This is an official Government of Canada system for authorized use only. By accessing this system, you acknowledge and agree that:</p>
            <ul>
                <li>You are authorized to access this system for legitimate government business purposes</li>
                <li>All activities on this system are monitored and audited</li>
                <li>Unauthorized access or use is strictly prohibited</li>
            </ul>
            <p>By clicking "Accept", you acknowledge that you have read and agree to comply with these terms of use.</p>
        `,
        acceptButtonText: 'Accept',
        declineButtonText: 'Decline'
    };

    const SYSTEM_USE_CONFIG_FR = {
        title: 'Gouvernement du Canada',
        message: `
            <h4>Utilisation du système</h4>
            <p>Il s'agit d'un système officiel du gouvernement du Canada réservé aux utilisateurs autorisés seulement. En accédant à ce système, vous reconnaissez et acceptez que :</p>
            <ul>
                <li>Vous êtes autorisé à accéder à ce système à des fins commerciales gouvernementales légitimes</li>
                <li>Toutes les activités sur ce système sont surveillées et auditées</li>
                <li>L'accès ou l'utilisation non autorisés sont strictement interdits</li>
            </ul>
            <p>En cliquant sur « Accepter », vous reconnaissez avoir lu et acceptez de vous conformer à ces conditions d'utilisation.</p>
        `,
        acceptButtonText: 'Accepter',
        declineButtonText: 'Refuser'
    };

    function getLocale() {
        const script = document.querySelector('script[src*="system-use.js"]');
        return script ? script.getAttribute('data-locale') || 'en' : 'en';
    }

    const SYSTEM_USE_CONFIG = getLocale() === 'fr' ? SYSTEM_USE_CONFIG_FR : SYSTEM_USE_CONFIG_EN;

    function hasAcceptedSystemUse() {
        try {
            return localStorage.getItem('cds_superset_system_use_accepted') === 'true';
        } catch (e) {
            console.warn('Unable to read system use acceptance status from localStorage');
            return false;
        }
    }

    function saveAcceptanceStatus() {
        try {
            localStorage.setItem('cds_superset_system_use_accepted', 'true');
        } catch (e) {
            console.warn('Unable to save system use acceptance status to localStorage');
        }
    }

    function createModalStyles() {
        const styleId = 'system-use-modal-styles';
        if (document.getElementById(styleId)) {
            return;
        }

        const style = document.createElement('style');
        style.id = styleId;
        style.textContent = `
            .system-use-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.65);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 10000;
                animation: fadeIn 0.2s ease-in;
            }

            .system-use-modal {
                background: white;
                padding: 1rem 2rem 2rem 2rem;
                border-radius: 4px;
                max-width: 600px;
                width: 90%;
                max-height: 90vh;
                overflow: auto;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                animation: slideIn 0.3s ease-out;
            }

            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }

            @keyframes slideIn {
                from {
                    transform: translateY(-50px);
                    opacity: 0;
                }
                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }
        `;
        document.head.appendChild(style);
    }

    function showSystemUseNotification() {
        createModalStyles();

        const modalHTML = `
            <div class="system-use-overlay" id="systemUseOverlay" role="dialog" aria-modal="true" aria-labelledby="systemUseModalTitle">
                <div class="system-use-modal">
                    <div class="system-use-modal-header">
                        <h2 class="system-use-modal-title" id="systemUseModalTitle">${SYSTEM_USE_CONFIG.title}</h2>
                    </div>
                    <div class="system-use-modal-body">
                        ${SYSTEM_USE_CONFIG.message}
                    </div>
                    <div class="system-use-modal-footer">
                        <button type="button" class="ant-btn css-pudwsq ant-btn-variant-dashed" id="system-use-decline">
                            ${SYSTEM_USE_CONFIG.declineButtonText}
                        </button>
                        <button type="button" class="ant-btn css-pudwsq ant-btn-variant-solid" id="system-use-accept">
                            ${SYSTEM_USE_CONFIG.acceptButtonText}
                        </button>
                    </div>
                </div>
            </div>
        `;

        document.body.insertAdjacentHTML('beforeend', modalHTML);

        const acceptBtn = document.getElementById('system-use-accept');
        const declineBtn = document.getElementById('system-use-decline');

        acceptBtn.addEventListener('click', function() {
            saveAcceptanceStatus();
            hideModal();
        });

        declineBtn.addEventListener('click', function() {
            window.location.href = 'https://docs.superset.cds-snc.ca/';
        });

        // Focus the accept button after a short delay to ensure modal is rendered
        setTimeout(() => {
            acceptBtn.focus();
        }, 100);

        // Prevent background scrolling
        document.body.style.overflow = 'hidden';
    }

    function hideModal() {
        const overlay = document.getElementById('systemUseOverlay');
        if (overlay) {
            overlay.style.animation = 'fadeOut 0.2s ease-out';
            setTimeout(() => {
                if (overlay.parentNode) {
                    overlay.parentNode.removeChild(overlay);
                    document.body.style.overflow = '';
                }
            }, 200);
        }
    }

    function initSystemUseNotification() {
        if (!hasAcceptedSystemUse()) {
            showSystemUseNotification();
        }
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initSystemUseNotification);
    } else {
        initSystemUseNotification();
    }
})();