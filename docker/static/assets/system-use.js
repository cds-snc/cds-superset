(function() {
    'use strict';

    const SYSTEM_USE_CONFIG_EN = {
        title: 'Government of Canada',
        message: `
            <h4>System Use</h4>
            <p>This is an official Government of Canada system for authorized use only. By accessing this system, you acknowledge and agree that:</p>
            <ul>
                <li>You are authorized to access this system for legitimate government business purposes </li>
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

    function showSystemUseNotification() {
        const modalHTML = `
            <div class="modal fade" id="systemUseModal" tabindex="-1" role="dialog" aria-labelledby="systemUseModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="systemUseModalLabel">${SYSTEM_USE_CONFIG.title}</h4>
                        </div>
                        <div class="modal-body">
                            ${SYSTEM_USE_CONFIG.message}
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" id="system-use-decline">${SYSTEM_USE_CONFIG.declineButtonText}</button>
                            <button type="button" class="btn btn-primary" id="system-use-accept">${SYSTEM_USE_CONFIG.acceptButtonText}</button>
                        </div>
                    </div>
                </div>
            </div>
        `;

        document.body.insertAdjacentHTML('beforeend', modalHTML);
        const modalElement = document.getElementById('systemUseModal');
        
        document.getElementById('system-use-accept').addEventListener('click', function() {
            saveAcceptanceStatus();
            hideModal();
        });

        document.getElementById('system-use-decline').addEventListener('click', function() {
            document.location.href = 'https://docs.superset.cds-snc.ca/';
        });

        $(modalElement).modal({
            backdrop: 'static',
            keyboard: false
        });

        $(modalElement).on('shown.bs.modal', function() {
            document.getElementById('system-use-accept').focus();
        });
    }

    function hideModal() {
        const modalElement = document.getElementById('systemUseModal');
        if (modalElement) {
            $(modalElement).modal('hide');
            
            setTimeout(() => {
                if (modalElement.parentNode) {
                    modalElement.parentNode.removeChild(modalElement);
                }
            }, 300);
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