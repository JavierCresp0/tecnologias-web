function emailEsUMH(email) {
    if (!email) return false;
    email = email.trim().toLowerCase();
    var at = email.indexOf('@');
    if (at === -1) return false;
    return email.slice(at + 1).endsWith('umh.es');
}

function validarDNI(dni) {
    if (!dni) return false;
    var s = dni.toUpperCase().trim().replace(/\s+/g, '');
    if (!/^[0-9]{8}[A-Z]$/.test(s)) return false;
    var num = parseInt(s.slice(0,8), 10);
    var letras = 'TRWAGMYFPDXBNJZSQVHLCKE';
    return s[8] === letras.charAt(num % 23);
}

function validarIBAN(iban) {
    if (!iban) return false;
    var s = iban.toUpperCase().replace(/\s+/g, '');
    if (s.length < 15 || s.length > 34) return false; // rango válido IBAN
    s = s.slice(4) + s.slice(0,4);
    var conv = '';
    for (var i = 0; i < s.length; i++) {
        var c = s.charAt(i);
        if (c >= 'A' && c <= 'Z') conv += (c.charCodeAt(0) - 55);
        else conv += c;
    }
    var resto = 0;
    for (var j = 0; j < conv.length; j += 7) {
        var bloque = resto.toString() + conv.substr(j, 7);
        resto = parseInt(bloque, 10) % 97;
    }
    return resto === 1;
}

function clearFieldError(id) {
    var el = document.getElementById(id);
    if (el) {
        el.classList.remove('error');
    }
    var msg = document.getElementById(id + 'Error');
    if (msg) msg.textContent = '';
}

function setFieldError(id, text) {
    var el = document.getElementById(id);
    if (el) el.classList.add('error');
    var msg = document.getElementById(id + 'Error');
    if (msg) msg.textContent = text;
}

function validar () {
    var emailEl = document.getElementById('email');
    var dniEl = document.getElementById('dni');
    var ibanEl = document.getElementById('iban');

    // limpiar errores previos
    clearFieldError('email');
    clearFieldError('dni');
    clearFieldError('iban');

    var email = emailEl ? emailEl.value : '';
    var dni = dniEl ? dniEl.value : '';
    var iban = ibanEl ? ibanEl.value : '';

    if (!emailEsUMH(email)) {
        setFieldError('email', 'El email debe pertenecer a UMH (terminar en "umh.es").');
        if (emailEl) emailEl.focus();
        return false;
    }
    if (!validarDNI(dni)) {
        setFieldError('dni', 'DNI inválido (8 números + letra correcta).');
        if (dniEl) dniEl.focus();
        return false;
    }
    if (!validarIBAN(iban)) {
        setFieldError('iban', 'IBAN inválido.');
        if (ibanEl) ibanEl.focus();
        return false;
    }
    return true;
};
