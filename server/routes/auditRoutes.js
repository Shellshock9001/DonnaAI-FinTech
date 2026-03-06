import { Router } from 'express';
import { queryAuditLog } from '../db.js';
import { authenticateToken } from '../middleware/auth.js';
import { requirePermission } from '../middleware/rbac.js';

const router = Router();

router.use(authenticateToken);

// ───────────── GET AUDIT LOG (paginated, filterable) ─────────────
router.get('/', requirePermission('audit.read'), (req, res) => {
    const { page, limit, action, actor, target, from, to } = req.query;

    const result = queryAuditLog({
        page: parseInt(page) || 1,
        limit: Math.min(parseInt(limit) || 50, 200),
        action, actor, target, from, to,
    });

    res.json(result);
});

// ───────────── GET AUDIT LOG SUMMARY (stats) ─────────────
router.get('/summary', requirePermission('audit.read'), (req, res) => {
    const today = queryAuditLog({ from: new Date().toISOString().split('T')[0], limit: 9999 });
    const actionCounts = {};
    const outcomeCounts = { success: 0, failure: 0, warn: 0 };

    for (const entry of today.entries) {
        actionCounts[entry.action] = (actionCounts[entry.action] || 0) + 1;
        outcomeCounts[entry.outcome] = (outcomeCounts[entry.outcome] || 0) + 1;
    }

    res.json({
        todayTotal: today.total,
        actionCounts,
        outcomeCounts,
    });
});

export default router;
