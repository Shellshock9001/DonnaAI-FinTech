import { Router } from 'express';
import { queries, logAudit } from '../db.js';
import { authenticate } from '../middleware/auth.js';
import { requirePermission } from '../middleware/rbac.js';

const router = Router();

// Get all policies
router.get('/', authenticate, requirePermission('policies.read'), (req, res) => {
    try {
        const rows = queries.getAllPolicies.all();
        const policies = {};
        for (const r of rows) policies[r.key] = { value: r.value, updatedAt: r.updated_at, updatedBy: r.updated_by };
        res.json(policies);
    } catch (err) {
        res.status(500).json({ error: 'Failed to load policies' });
    }
});

// Update policies (super_admin only)
router.patch('/', authenticate, requirePermission('policies.write'), (req, res) => {
    try {
        const updates = req.body; // { "key": "value", ... }
        const changed = [];

        for (const [key, value] of Object.entries(updates)) {
            const existing = queries.getPolicy.get(key);
            if (existing) {
                queries.updatePolicy.run(String(value), req.user.email, key);
                changed.push(key);
            }
        }

        logAudit({
            actorId: req.user.id, actorEmail: req.user.email, actorRole: req.user.role,
            action: 'POLICIES_UPDATED', targetType: 'system',
            details: { keys: changed, values: updates },
            ip: req.ip,
        });

        res.json({ message: `Updated ${changed.length} policies`, changed });
    } catch (err) {
        res.status(500).json({ error: 'Failed to update policies' });
    }
});

export default router;
