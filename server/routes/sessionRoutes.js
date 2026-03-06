import { Router } from 'express';
import { queries, logAudit } from '../db.js';
import { authenticate } from '../middleware/auth.js';
import { requirePermission } from '../middleware/rbac.js';

const router = Router();

const PRIVATE_RANGES = [
    /^127\./,
    /^10\./,
    /^172\.(1[6-9]|2\d|3[01])\./,
    /^192\.168\./,
    /^::1$/,
    /^::ffff:127\./,
    /^::ffff:10\./,
    /^::ffff:192\.168\./,
    /^localhost$/i,
];

function isInternalIP(ip) {
    return PRIVATE_RANGES.some(r => r.test(ip || ''));
}

// Get all active sessions (admin sees all, user sees own)
router.get('/', authenticate, (req, res) => {
    try {
        const canSeeAll = ['super_admin', 'admin', 'auditor'].includes(req.user.role);

        let sessions;
        if (canSeeAll) {
            sessions = queries.getActiveSessions.all();
        } else {
            sessions = queries.getUserSessions.all(req.user.id);
        }

        // Clean expired
        queries.cleanExpiredSessions.run();

        const enriched = sessions
            .filter(s => !s.revoked && new Date(s.expires_at + 'Z') > new Date())
            .map(s => ({
                id: s.id,
                userId: s.user_id,
                displayName: s.display_name || null,
                email: s.email || null,
                role: s.role || null,
                ipAddress: s.ip_address,
                isInternal: isInternalIP(s.ip_address),
                deviceLabel: s.device_label || 'Unknown',
                userAgent: s.user_agent,
                createdAt: s.created_at,
                lastActive: s.last_active,
                expiresAt: s.expires_at,
                isCurrent: false, // Will be set by frontend
            }));

        res.json({ sessions: enriched, total: enriched.length });
    } catch (err) {
        console.error('Sessions list error:', err);
        res.status(500).json({ error: 'Failed to list sessions' });
    }
});

// Revoke a specific session
router.delete('/:id', authenticate, (req, res) => {
    try {
        const session = queries.getSessionById.get(req.params.id);
        if (!session) return res.status(404).json({ error: 'Session not found' });

        // Users can revoke own sessions; admins can revoke any
        const isOwn = session.user_id === req.user.id;
        const isAdmin = ['super_admin', 'admin'].includes(req.user.role);
        if (!isOwn && !isAdmin) return res.status(403).json({ error: 'Cannot revoke another user\'s session' });

        queries.revokeSession.run(req.user.id, req.params.id);

        logAudit({
            actorId: req.user.id, actorEmail: req.user.email, actorRole: req.user.role,
            action: 'SESSION_REVOKED', targetType: 'session', targetId: req.params.id,
            targetEmail: isOwn ? req.user.email : null,
            details: { ip: session.ip_address, device: session.device_label },
            ip: req.ip,
        });

        res.json({ message: 'Session revoked' });
    } catch (err) {
        res.status(500).json({ error: 'Revoke failed' });
    }
});

// Revoke all sessions for a user (admin only)
router.delete('/user/:userId', authenticate, requirePermission('sessions.revoke'), (req, res) => {
    try {
        queries.revokeAllUserSessions.run(req.user.id, req.params.userId);

        logAudit({
            actorId: req.user.id, actorEmail: req.user.email, actorRole: req.user.role,
            action: 'ALL_SESSIONS_REVOKED', targetType: 'user', targetId: req.params.userId,
            ip: req.ip,
        });

        res.json({ message: 'All sessions revoked for user' });
    } catch (err) {
        res.status(500).json({ error: 'Bulk revoke failed' });
    }
});

export default router;
