import { ROLES } from '../db.js';

// Role hierarchy for escalation prevention
export const ROLE_HIERARCHY = {
    'super_admin': 8,
    'admin': 7,
    'data_engineer': 5,
    'data_steward': 4,
    'analyst': 3,
    'auditor': 2,
    'viewer': 1,
    'pending': 0,
};

export function requirePermission(...requiredPermissions) {
    return (req, res, next) => {
        if (!req.user) return res.status(401).json({ error: 'Authentication required' });
        const rolePerms = ROLES[req.user.role] || [];
        const hasAll = requiredPermissions.every(perm => rolePerms.includes(perm));
        if (!hasAll) {
            return res.status(403).json({ error: 'Insufficient permissions', code: 'FORBIDDEN', required: requiredPermissions, yourRole: req.user.role });
        }
        next();
    };
}

export function requireRole(...allowedRoles) {
    return (req, res, next) => {
        if (!req.user) return res.status(401).json({ error: 'Authentication required' });
        if (!allowedRoles.includes(req.user.role)) {
            return res.status(403).json({ error: 'Role not authorized', code: 'ROLE_FORBIDDEN', allowedRoles, yourRole: req.user.role });
        }
        next();
    };
}

export function getRoleLevel(role) {
    return ROLE_HIERARCHY[role] || 0;
}

export function preventEscalation(req, res, next) {
    const actorLevel = getRoleLevel(req.user.role);
    const targetRole = req.body.role;
    if (targetRole && getRoleLevel(targetRole) >= actorLevel) {
        return res.status(403).json({ error: 'Cannot assign a role equal to or higher than your own', code: 'ROLE_ESCALATION' });
    }
    next();
}
