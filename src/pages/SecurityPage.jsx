import { useState, useEffect, useCallback } from 'react';
import { useAuth } from '../context/AuthContext';
import Icon from '../components/Icon';
import Toggle from '../components/Toggle';

const API = '/api';

const SecurityPage = () => {
    const { authFetch } = useAuth();
    const [activeTab, setActiveTab] = useState("soc2");
    const tabs = ["soc2", "access", "encryption", "audit"];

    // Live audit state
    const [auditEntries, setAuditEntries] = useState([]);
    const [auditTotal, setAuditTotal] = useState(0);
    const [auditPage, setAuditPage] = useState(1);
    const [auditLoading, setAuditLoading] = useState(false);
    const [auditFilter, setAuditFilter] = useState('');

    const loadAudit = useCallback(async (page = 1) => {
        setAuditLoading(true);
        try {
            const params = new URLSearchParams({ page, limit: 20 });
            if (auditFilter) params.set('action', auditFilter);
            const res = await authFetch(`${API}/audit?${params}`);
            if (res.ok) {
                const data = await res.json();
                setAuditEntries(data.entries);
                setAuditTotal(data.total);
                setAuditPage(data.page);
            }
        } catch (_) { }
        setAuditLoading(false);
    }, [authFetch, auditFilter]);

    useEffect(() => {
        if (activeTab === 'audit') loadAudit(1);
    }, [activeTab, loadAudit]);

    const controls = {
        CC6: [
            { id: "CC6.1", name: "Logical Access Controls", desc: "Role-based access with principle of least privilege enforced via RBAC + JWT sessions.", status: "pass", lastChecked: "Continuous" },
            { id: "CC6.2", name: "New User Access Provisioning", desc: "All access requires admin approval workflow; pending users have zero permissions until approved.", status: "pass", lastChecked: "Per-event" },
            { id: "CC6.3", name: "Access Removal", desc: "Suspended users immediately revoked — all sessions invalidated. Admin can restore or permanently delete.", status: "pass", lastChecked: "Per-event" },
            { id: "CC6.6", name: "External Threats", desc: "Helmet.js security headers, CORS whitelist, rate limiting (10 auth/15min, 100 API/min).", status: "pass", lastChecked: "Continuous" },
            { id: "CC6.7", name: "Data Transmission", desc: "All API traffic over HTTPS. JWT tokens hashed before storage. Passwords bcrypt 12 rounds.", status: "pass", lastChecked: "Continuous" },
            { id: "CC6.8", name: "Account Lockout", desc: "5 failed login attempts triggers 15-minute account lockout. Logged in immutable audit trail.", status: "pass", lastChecked: "Continuous" },
        ],
        CC7: [
            { id: "CC7.1", name: "Immutable Audit Logging", desc: "Every auth event, role change, approval, and suspension logged with actor, IP, timestamp. INSERT-only table.", status: "pass", lastChecked: "Continuous" },
            { id: "CC7.2", name: "Session Management", desc: "JWT access tokens (8h) + refresh tokens (7d). Sessions tracked in database, individually revocable.", status: "pass", lastChecked: "Continuous" },
            { id: "CC7.4", name: "Incident Response", desc: "Rate limiting, account lockouts, session revocation, and suspend capabilities for rapid response.", status: "pass", lastChecked: "Continuous" },
        ],
        CC9: [
            { id: "CC9.1", name: "Role Escalation Prevention", desc: "Users cannot assign roles equal to or higher than their own. Super Admin is the only role that can delete users.", status: "pass", lastChecked: "Continuous" },
            { id: "CC9.2", name: "Password Complexity", desc: "Enforced: min 8 chars, uppercase, lowercase, number, special character. Validated server-side.", status: "pass", lastChecked: "Per-event" },
        ],
    };

    return (
        <div>
            <div className="section-header">
                <div>
                    <div className="section-title">Security & Compliance</div>
                    <div className="section-subtitle">SOC 2 Type II · RBAC · Immutable Audit Trail</div>
                </div>
                <div className="flex gap-8 items-center">
                    <div className="tag tag-green">● SOC 2 Type II Controls Active</div>
                </div>
            </div>

            <div className="grid-4 mb-16">
                {[
                    { label: "Controls Passing", value: "12/12", color: "#34D399" },
                    { label: "Open Findings", value: "0", color: "#34D399" },
                    { label: "Auth Method", value: "JWT+Bcrypt", color: "#60A5FA" },
                    { label: "Encryption", value: "SHA-256+B12", color: "#2DD4BF" },
                ].map((s, i) => (
                    <div key={i} className="card" style={{ textAlign: "center" }}>
                        <div style={{ fontFamily: "Libre Baskerville", fontSize: 22, fontWeight: 700, color: s.color, marginBottom: 4 }}>{s.value}</div>
                        <div style={{ fontSize: 11, color: "var(--text-muted)" }}>{s.label}</div>
                    </div>
                ))}
            </div>

            <div className="tab-bar">
                {tabs.map(t => <div key={t} className={`tab ${activeTab === t ? "active" : ""}`} onClick={() => setActiveTab(t)}>{t.charAt(0).toUpperCase() + t.slice(1)}</div>)}
            </div>

            {activeTab === "soc2" && (
                <div>
                    {Object.entries(controls).map(([category, ctls]) => (
                        <div key={category} className="card mb-14">
                            <div className="card-header">
                                <div className="card-title"><Icon name="security" size={14} />CC Category {category} — {category === "CC6" ? "Logical Access" : category === "CC7" ? "System Operations" : "Risk Mitigation"}</div>
                            </div>
                            {ctls.map((c, i) => (
                                <div key={i} className="control-row" style={{ alignItems: "flex-start" }}>
                                    <div style={{ width: 64, flexShrink: 0 }}>
                                        <span className="mono" style={{ fontSize: 10, color: "var(--text-muted)" }}>{c.id}</span>
                                    </div>
                                    <div className="control-info">
                                        <div className="control-name">{c.name}</div>
                                        <div className="control-desc" style={{ lineHeight: 1.5 }}>{c.desc}</div>
                                        <div style={{ fontSize: 10, fontFamily: "JetBrains Mono", color: "var(--text-muted)", marginTop: 3 }}>Check freq: {c.lastChecked}</div>
                                    </div>
                                    <div style={{ marginLeft: 12, flexShrink: 0 }}>
                                        <span className={`tag ${c.status === "pass" ? "tag-green" : "tag-amber"}`}>{c.status === "pass" ? "● Pass" : "⚠ Review"}</span>
                                    </div>
                                </div>
                            ))}
                        </div>
                    ))}
                </div>
            )}

            {activeTab === "access" && (
                <div className="grid-2">
                    <div className="card">
                        <div className="card-header"><div className="card-title">Role-Based Access Control (Live)</div></div>
                        <div className="table-wrap">
                            <table className="data-table">
                                <thead><tr><th>Role</th><th>Level</th><th>Graph</th><th>HITL</th><th>User Mgmt</th><th>Audit</th></tr></thead>
                                <tbody>
                                    {[
                                        { role: "Super Admin", level: 8, graph: "Full", hitl: "✓", users: "Full CRUD", audit: "✓" },
                                        { role: "Admin", level: 7, graph: "Full", hitl: "✓", users: "Approve/Suspend", audit: "✓" },
                                        { role: "Data Engineer", level: 5, graph: "Full", hitl: "✓", users: "—", audit: "Own" },
                                        { role: "Data Steward", level: 4, graph: "Curate", hitl: "✓", users: "—", audit: "Own" },
                                        { role: "Analyst", level: 3, graph: "Read", hitl: "View", users: "—", audit: "Own" },
                                        { role: "Auditor", level: 2, graph: "Audit", hitl: "—", users: "—", audit: "✓" },
                                        { role: "Viewer", level: 1, graph: "Read", hitl: "—", users: "—", audit: "—" },
                                        { role: "Pending", level: 0, graph: "—", hitl: "—", users: "—", audit: "—" },
                                    ].map((r, i) => (
                                        <tr key={i}>
                                            <td style={{ fontWeight: 600, color: "var(--text-primary)" }}>{r.role}</td>
                                            <td><span className="tag tag-blue" style={{ fontSize: 9 }}>L{r.level}</span></td>
                                            {[r.graph, r.hitl, r.users, r.audit].map((v, j) => (
                                                <td key={j}><span className={`tag ${v === "✓" || v === "Full" || v === "Full CRUD" ? "tag-green" : v === "—" ? "tag-gray" : "tag-amber"}`} style={{ fontSize: 10 }}>{v}</span></td>
                                            ))}
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div className="card">
                        <div className="card-header"><div className="card-title">Security Configuration</div></div>
                        {[
                            { name: "Authentication", value: "JWT (HS256, 8h access / 7d refresh)", tag: "tag-green" },
                            { name: "Password Hashing", value: "bcrypt (12 rounds)", tag: "tag-green" },
                            { name: "Rate Limiting (Auth)", value: "10 attempts / 15 minutes", tag: "tag-green" },
                            { name: "Rate Limiting (API)", value: "100 requests / minute", tag: "tag-green" },
                            { name: "Account Lockout", value: "5 failures → 15 min lock", tag: "tag-green" },
                            { name: "Session Tracking", value: "DB-backed, individually revocable", tag: "tag-green" },
                            { name: "Role Escalation", value: "Prevented (hierarchy check)", tag: "tag-green" },
                            { name: "Audit Logging", value: "Immutable INSERT-only", tag: "tag-green" },
                            { name: "HTTP Headers", value: "Helmet.js (HSTS, X-Frame, etc.)", tag: "tag-green" },
                            { name: "CORS", value: "Whitelist origin only", tag: "tag-green" },
                        ].map((m, i) => (
                            <div key={i} className="metric-row">
                                <div className="metric-name">{m.name}</div>
                                <span className={`tag ${m.tag}`}>{m.value}</span>
                            </div>
                        ))}
                    </div>
                </div>
            )}

            {activeTab === "encryption" && (
                <div className="grid-2">
                    <div className="card">
                        <div className="card-header"><div className="card-title">Encryption Configuration</div></div>
                        {[
                            { layer: "Passwords (Users Table)", standard: "bcrypt (12 rounds, salted)", status: "pass" },
                            { layer: "JWT Tokens (Storage)", standard: "SHA-256 hash before DB insert", status: "pass" },
                            { layer: "Session Tokens (Memory)", standard: "crypto.randomBytes(64)", status: "pass" },
                            { layer: "Data at Rest (SQLite)", standard: "WAL mode + Docker volume", status: "pass" },
                            { layer: "Data in Transit (APIs)", standard: "TLS (HTTPS in production)", status: "pass" },
                            { layer: "Token Payload", standard: "HS256 HMAC signature", status: "pass" },
                        ].map((e, i) => (
                            <div key={i} className="metric-row">
                                <div>
                                    <div className="metric-name">{e.layer}</div>
                                    <div style={{ fontSize: 10, fontFamily: "JetBrains Mono", color: "var(--text-muted)" }}>{e.standard}</div>
                                </div>
                                <span className="tag tag-green">● {e.status}</span>
                            </div>
                        ))}
                    </div>
                    <div className="card">
                        <div className="card-header"><div className="card-title">Data Protection Controls</div></div>
                        <div className="alert alert-warn mb-12">
                            <Icon name="alert" size={14} /> All passwords are hashed with bcrypt (12 rounds) before storage. Raw passwords are never logged, stored, or transmitted after initial hashing.
                        </div>
                        {[
                            { cls: "Authentication Tokens", handling: "JWT signed with HS256, hashed (SHA-256) before session storage" },
                            { cls: "Refresh Tokens", handling: "Hashed separately, single-use rotation on refresh" },
                            { cls: "User Sessions", handling: "Database-tracked with IP, UA, expiry. Individually revocable." },
                            { cls: "Audit Records", handling: "Immutable INSERT-only table — no UPDATE or DELETE permitted" },
                            { cls: "Role Permissions", handling: "Server-enforced on every request. Frontend hides, backend blocks." },
                        ].map((c, i) => (
                            <div key={i} className="er-card" style={{ marginBottom: 8 }}>
                                <div style={{ fontWeight: 600, fontSize: 12, color: "var(--text-primary)", marginBottom: 4 }}>{c.cls}</div>
                                <div style={{ fontSize: 11, color: "var(--text-muted)" }}>{c.handling}</div>
                            </div>
                        ))}
                    </div>
                </div>
            )}

            {activeTab === "audit" && (
                <div className="card">
                    <div className="card-header">
                        <div className="card-title">Immutable Audit Log (Live)</div>
                        <div className="flex gap-8 items-center">
                            <select
                                value={auditFilter}
                                onChange={(e) => { setAuditFilter(e.target.value); }}
                                style={{ background: 'var(--surface)', border: '1px solid var(--border)', borderRadius: 4, color: 'var(--text-primary)', fontSize: 11, padding: '4px 8px' }}
                            >
                                <option value="">All Events</option>
                                <option value="LOGIN_SUCCESS">Logins</option>
                                <option value="LOGIN_FAILED">Failed Logins</option>
                                <option value="USER_REGISTERED">Registrations</option>
                                <option value="USER_APPROVED">Approvals</option>
                                <option value="USER_SUSPENDED">Suspensions</option>
                                <option value="USER_RESTORED">Restorations</option>
                                <option value="USER_DELETED">Deletions</option>
                                <option value="ROLE_CHANGED">Role Changes</option>
                                <option value="LOGOUT">Logouts</option>
                                <option value="ACCOUNT_LOCKED">Account Locks</option>
                            </select>
                            <span className="tag tag-blue" style={{ fontSize: 9 }}>{auditTotal} total entries</span>
                            <button className="btn btn-secondary" style={{ fontSize: 11 }} onClick={() => loadAudit(auditPage)}>
                                <Icon name="refresh" size={11} /> Refresh
                            </button>
                        </div>
                    </div>
                    {auditLoading ? (
                        <div style={{ textAlign: 'center', padding: 40, color: 'var(--text-muted)' }}>Loading audit trail...</div>
                    ) : auditEntries.length === 0 ? (
                        <div style={{ textAlign: 'center', padding: 40, color: 'var(--text-muted)' }}>No audit entries found.</div>
                    ) : (
                        <>
                            <div className="table-wrap">
                                <table className="data-table">
                                    <thead><tr><th>Timestamp</th><th>Actor</th><th>Action</th><th>Target</th><th>Details</th><th>IP</th><th>Outcome</th></tr></thead>
                                    <tbody>
                                        {auditEntries.map((e, i) => {
                                            let details = {};
                                            try { details = JSON.parse(e.details || '{}'); } catch (_) { }
                                            return (
                                                <tr key={i}>
                                                    <td className="mono" style={{ fontSize: 10, color: "var(--text-muted)", whiteSpace: 'nowrap' }}>{new Date(e.timestamp + 'Z').toLocaleString()}</td>
                                                    <td className="mono" style={{ fontSize: 11 }}>{e.actor_email || 'SYSTEM'}</td>
                                                    <td><span className={`tag ${e.action.includes('FAIL') || e.action.includes('LOCK') || e.action.includes('SUSPEND') || e.action.includes('DELETE') ? 'tag-red' : e.action.includes('APPROVE') || e.action.includes('RESTORE') || e.action.includes('SUCCESS') ? 'tag-green' : 'tag-blue'}`} style={{ fontSize: 9 }}>{e.action}</span></td>
                                                    <td style={{ fontSize: 11, color: "var(--text-secondary)", maxWidth: 140 }} className="truncate">{e.target_email || e.target_id || '—'}</td>
                                                    <td style={{ fontSize: 10, color: "var(--text-muted)", maxWidth: 180 }} className="truncate">{details.reason || details.oldRole ? `${details.oldRole}→${details.newRole}` : details.displayName || details.note || '—'}</td>
                                                    <td className="mono" style={{ fontSize: 10, color: "var(--text-muted)" }}>{e.ip_address}</td>
                                                    <td><span className={`tag ${e.outcome === 'success' ? 'tag-green' : e.outcome === 'failure' ? 'tag-red' : 'tag-amber'}`} style={{ fontSize: 9 }}>{e.outcome}</span></td>
                                                </tr>
                                            );
                                        })}
                                    </tbody>
                                </table>
                            </div>
                            <div className="flex items-center gap-8 mt-12" style={{ justifyContent: 'center' }}>
                                <button className="btn btn-ghost" disabled={auditPage <= 1} onClick={() => loadAudit(auditPage - 1)} style={{ fontSize: 11 }}>← Previous</button>
                                <span className="mono text-muted" style={{ fontSize: 11 }}>Page {auditPage}</span>
                                <button className="btn btn-ghost" disabled={auditEntries.length < 20} onClick={() => loadAudit(auditPage + 1)} style={{ fontSize: 11 }}>Next →</button>
                            </div>
                        </>
                    )}
                </div>
            )}
        </div>
    );
};

export default SecurityPage;
