import jwt from 'jsonwebtoken';
import crypto from 'crypto';
import { queries } from '../db.js';

const JWT_SECRET = process.env.JWT_SECRET || crypto.randomBytes(64).toString('hex');
const JWT_EXPIRY = '8h';
const REFRESH_EXPIRY = '7d';

export { JWT_SECRET, JWT_EXPIRY, REFRESH_EXPIRY };

export function hashToken(token) {
    return crypto.createHash('sha256').update(token).digest('hex');
}

export function generateTokens(user) {
    const payload = { id: user.id, email: user.email, role: user.role, displayName: user.display_name };
    const accessToken = jwt.sign(payload, JWT_SECRET, { expiresIn: JWT_EXPIRY });
    const refreshToken = jwt.sign({ id: user.id, type: 'refresh' }, JWT_SECRET, { expiresIn: REFRESH_EXPIRY });

    const accessHash = hashToken(accessToken);
    const refreshHash = hashToken(refreshToken);
    const expiresAt = new Date(Date.now() + 8 * 3600000).toISOString();

    return { accessToken, refreshToken, accessHash, refreshHash, expiresAt };
}

export function authenticate(req, res, next) {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) return res.status(401).json({ error: 'Authentication required', code: 'NO_TOKEN' });

    try {
        const decoded = jwt.verify(token, JWT_SECRET);
        const tokenHash = hashToken(token);
        const session = queries.getSession.get(tokenHash);
        if (!session) return res.status(401).json({ error: 'Session expired or revoked', code: 'INVALID_SESSION' });

        // Update session activity
        try { queries.updateSessionActivity.run(session.id); } catch (_) { }

        const user = queries.getUserById.get(decoded.id);
        if (!user) return res.status(401).json({ error: 'User not found', code: 'USER_NOT_FOUND' });
        if (user.status !== 'active') return res.status(403).json({ error: `Account is ${user.status}`, code: 'ACCOUNT_INACTIVE' });

        req.user = {
            id: user.id, email: user.email, role: user.role,
            displayName: user.display_name, status: user.status,
            avatarInitials: user.avatar_initials,
        };
        req.sessionId = session.id;
        req.tokenHash = tokenHash;
        next();
    } catch (err) {
        if (err.name === 'TokenExpiredError') return res.status(401).json({ error: 'Token expired', code: 'TOKEN_EXPIRED' });
        return res.status(401).json({ error: 'Invalid token', code: 'INVALID_TOKEN' });
    }
}

// Keep backward compat
export const authenticateToken = authenticate;
