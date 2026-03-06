// Risk scoring engine — computes 0-100 risk for new signups

const DISPOSABLE_DOMAINS = new Set([
    'mailinator.com', 'guerrillamail.com', 'tempmail.com', 'throwaway.email', 'yopmail.com',
    'sharklasers.com', 'guerrillamailblock.com', 'grr.la', 'dispostable.com', 'trashmail.com',
    'temp-mail.org', 'fakeinbox.com', 'getairmail.com', 'mailnesia.com', 'maildrop.cc',
    'discard.email', 'getnada.com', 'mohmal.com', 'tempail.com', '10minutemail.com',
]);

const GENERIC_PROVIDERS = new Set([
    'gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com', 'aol.com', 'icloud.com',
    'protonmail.com', 'mail.com', 'zoho.com', 'live.com', 'msn.com',
]);

const SUSPICIOUS_KEYWORDS = [
    'test', 'testing', 'just looking', 'trial', 'temp', 'temporary', 'demo', 'fake', 'asdf',
    'none', 'n/a', 'na', 'nothing', 'idk', 'dunno',
];

export function computeRiskScore({ email, department, title, reasonForAccess, referralCode }) {
    let score = 0;
    const factors = [];

    // Email domain analysis
    const domain = email.split('@')[1]?.toLowerCase() || '';

    if (DISPOSABLE_DOMAINS.has(domain)) {
        score += 25;
        factors.push({ signal: 'Disposable email domain', points: 25, severity: 'high' });
    } else if (GENERIC_PROVIDERS.has(domain)) {
        score += 10;
        factors.push({ signal: 'Generic email provider (not org email)', points: 10, severity: 'low' });
    } else {
        // Org email — slight risk reduction
        score -= 5;
        factors.push({ signal: 'Organization email domain', points: -5, severity: 'good' });
    }

    // Department check
    if (!department || department.trim().length < 2) {
        score += 15;
        factors.push({ signal: 'No department provided', points: 15, severity: 'medium' });
    } else {
        factors.push({ signal: 'Department provided', points: 0, severity: 'good' });
    }

    // Title check
    if (!title || title.trim().length < 2) {
        score += 10;
        factors.push({ signal: 'No title provided', points: 10, severity: 'medium' });
    } else {
        factors.push({ signal: 'Title provided', points: 0, severity: 'good' });
    }

    // Reason quality
    const reason = (reasonForAccess || '').trim().toLowerCase();
    if (!reason || reason.length < 10) {
        score += 15;
        factors.push({ signal: 'Vague or missing access reason', points: 15, severity: 'medium' });
    } else if (SUSPICIOUS_KEYWORDS.some(kw => reason.includes(kw))) {
        score += 15;
        factors.push({ signal: 'Suspicious keywords in reason', points: 15, severity: 'high' });
    } else if (reason.length > 30) {
        score -= 5;
        factors.push({ signal: 'Detailed access reason', points: -5, severity: 'good' });
    }

    // Referral code
    if (!referralCode || referralCode.trim().length === 0) {
        score += 20;
        factors.push({ signal: 'No referral code', points: 20, severity: 'medium' });
    } else {
        score -= 20;
        factors.push({ signal: 'Valid referral code provided', points: -20, severity: 'good' });
    }

    // Clamp 0-100
    score = Math.max(0, Math.min(100, score));

    return { score, factors, level: score <= 30 ? 'low' : score <= 60 ? 'medium' : 'high' };
}
