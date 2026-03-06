import { useState, useEffect, useCallback } from 'react';
import { useAuth } from '../context/AuthContext';
import Icon from '../components/Icon';

const API = '/api';

const ROLE_LABELS = {
    super_admin: 'Super Admin', admin: 'Admin', data_engineer: 'Data Engineer',
    data_steward: 'Data Steward', analyst: 'Analyst', auditor: 'Auditor',
    viewer: 'Viewer', pending: 'Pending',
};

const RISK_COLORS = { low: '#34D399', medium: '#FBBF24', high: '#F87171' };

const SettingsPage = () => {
    const { user, authFetch, isAdmin, isSuperAdmin } = useAuth();
    const [activeTab, setActiveTab] = useState('team');
    const tabs = ['Team', 'Approvals', 'Sessions', 'API Keys', 'Policies'];

    // Team state
    const [users, setUsers] = useState([]);
    const [searchQ, setSearchQ] = useState('');
    const [filterRole, setFilterRole] = useState('');
    const [filterStatus, setFilterStatus] = useState('');
    const [pending, setPending] = useState([]);
    const [roles, setRoles] = useState([]);
    const [editUser, setEditUser] = useState(null);
    const [editForm, setEditForm] = useState({});

    // Approval state
    const [approvalRole, setApprovalRole] = useState({});
    const [approvalNotes, setApprovalNotes] = useState({});
    const [denyReason, setDenyReason] = useState({});
    const [denyingId, setDenyingId] = useState(null);

    // Sessions state
    const [sessions, setSessions] = useState([]);
    const [sessionsLoading, setSessionsLoading] = useState(false);

    // API Keys state
    const [apiKeys, setApiKeys] = useState([]);
    const [newKeyName, setNewKeyName] = useState('');
    const [newKeyScopes, setNewKeyScopes] = useState(['read']);
    const [createdKey, setCreatedKey] = useState(null);
    const [keyCopied, setKeyCopied] = useState(false);

    // Policies state
    const [policies, setPolicies] = useState({});
    const [policyEdits, setPolicyEdits] = useState({});
    const [policySaving, setPolicySaving] = useState(false);

    // Data loaders
    const loadUsers = useCallback(async () => {
        try {
            const params = new URLSearchParams();
            if (searchQ) params.set('q', searchQ);
            if (filterRole) params.set('role', filterRole);
            if (filterStatus) params.set('status', filterStatus);
            const res = await authFetch(`${API}/users?${params}`);
            if (res.ok) setUsers(await res.json());
        } catch (_) { }
    }, [authFetch, searchQ, filterRole, filterStatus]);

    const loadPending = useCallback(async () => {
        try {
            const res = await authFetch(`${API}/users?status=pending`);
            if (res.ok) setPending(await res.json());
        } catch (_) { }
    }, [authFetch]);

    const loadRoles = useCallback(async () => {
        try {
            const res = await authFetch(`${API}/users/meta/roles`);
            if (res.ok) {
                const data = await res.json();
                setRoles(data.roles?.filter(r => r !== 'pending') || []);
            }
        } catch (_) { }
    }, [authFetch]);

    const loadSessions = useCallback(async () => {
        setSessionsLoading(true);
        try {
            const res = await authFetch(`${API}/sessions`);
            if (res.ok) { const data = await res.json(); setSessions(data.sessions || []); }
        } catch (_) { }
        setSessionsLoading(false);
    }, [authFetch]);

    const loadApiKeys = useCallback(async () => {
        try {
            const res = await authFetch(`${API}/keys`);
            if (res.ok) setApiKeys(await res.json());
        } catch (_) { }
    }, [authFetch]);

    const loadPolicies = useCallback(async () => {
        try {
            const res = await authFetch(`${API}/policies`);
            if (res.ok) {
                const data = await res.json();
                setPolicies(data);
                const edits = {};
                for (const [k, v] of Object.entries(data)) edits[k] = v.value;
                setPolicyEdits(edits);
            }
        } catch (_) { }
    }, [authFetch]);

    useEffect(() => { loadUsers(); loadPending(); loadRoles(); }, [loadUsers, loadPending, loadRoles]);
    useEffect(() => {
        if (activeTab === 'Sessions') loadSessions();
        if (activeTab === 'API Keys') loadApiKeys();
        if (activeTab === 'Policies') loadPolicies();
    }, [activeTab, loadSessions, loadApiKeys, loadPolicies]);

    // Actions
    const approveUser = async (id) => {
        const role = approvalRole[id] || 'viewer';
        const notes = approvalNotes[id] || '';
        const res = await authFetch(`${API}/users/${id}/approve`, { method: 'PATCH', body: JSON.stringify({ role, notes }) });
        if (res.ok) { loadUsers(); loadPending(); }
    };

    const denyUser = async (id) => {
        const reason = denyReason[id] || '';
        if (reason.trim().length < 5) return;
        const res = await authFetch(`${API}/users/${id}/deny`, { method: 'PATCH', body: JSON.stringify({ reason }) });
        if (res.ok) { loadPending(); setDenyingId(null); }
    };

    const suspendUser = async (id) => {
        const res = await authFetch(`${API}/users/${id}/suspend`, { method: 'PATCH', body: JSON.stringify({}) });
        if (res.ok) loadUsers();
    };

    const restoreUser = async (id) => {
        const res = await authFetch(`${API}/users/${id}/restore`, { method: 'PATCH', body: JSON.stringify({}) });
        if (res.ok) loadUsers();
    };

    const deleteUser = async (id) => {
        if (!confirm('Permanently delete this user? This cannot be undone.')) return;
        const res = await authFetch(`${API}/users/${id}`, { method: 'DELETE' });
        if (res.ok) loadUsers();
    };

    const changeRole = async (id, role) => {
        const res = await authFetch(`${API}/users/${id}/role`, { method: 'PATCH', body: JSON.stringify({ role }) });
        if (res.ok) loadUsers();
    };

    const forceReset = async (id) => {
        const res = await authFetch(`${API}/users/${id}/force-reset`, { method: 'PATCH' });
        if (res.ok) loadUsers();
    };

    const updateUserDetails = async () => {
        if (!editUser) return;
        const res = await authFetch(`${API}/users/${editUser.id}/details`, { method: 'PATCH', body: JSON.stringify(editForm) });
        if (res.ok) { setEditUser(null); loadUsers(); }
    };

    const revokeSession = async (id) => {
        const res = await authFetch(`${API}/sessions/${id}`, { method: 'DELETE' });
        if (res.ok) loadSessions();
    };

    const createApiKey = async () => {
        if (!newKeyName.trim()) return;
        const res = await authFetch(`${API}/keys`, { method: 'POST', body: JSON.stringify({ name: newKeyName, scopes: newKeyScopes }) });
        if (res.ok) {
            const data = await res.json();
            setCreatedKey(data);
            setNewKeyName('');
            loadApiKeys();
        }
    };

    const revokeApiKey = async (id) => {
        const res = await authFetch(`${API}/keys/${id}`, { method: 'DELETE' });
        if (res.ok) loadApiKeys();
    };

    const savePolicies = async () => {
        setPolicySaving(true);
        const updates = {};
        for (const [k, v] of Object.entries(policyEdits)) {
            if (policies[k]?.value !== v) updates[k] = v;
        }
        if (Object.keys(updates).length) {
            await authFetch(`${API}/policies`, { method: 'PATCH', body: JSON.stringify(updates) });
            loadPolicies();
        }
        setPolicySaving(false);
    };

    const activeUsers = users.filter(u => u.status === 'active');
    const suspendedUsers = users.filter(u => u.status === 'suspended');

    const riskLevel = (score) => score <= 30 ? 'low' : score <= 60 ? 'medium' : 'high';

    return (
        <div>
            <div className="section-header">
                <div>
                    <div className="section-title">Settings</div>
                    <div className="section-subtitle">User management · Approvals · Security policies</div>
                </div>
                <div className="flex gap-8 items-center">
                    <span className="tag tag-green mono" style={{ fontSize: 9 }}>{activeUsers.length} active users</span>
                    {pending.length > 0 && <span className="tag tag-amber mono" style={{ fontSize: 9 }}>{pending.length} pending</span>}
                </div>
            </div>

            <div className="grid-4 mb-16">
                {[
                    { label: 'Total Users', value: users.length, color: '#60A5FA' },
                    { label: 'Active', value: activeUsers.length, color: '#34D399' },
                    { label: 'Pending Approval', value: pending.length, color: '#FBBF24' },
                    { label: 'Suspended', value: suspendedUsers.length, color: '#F87171' },
                ].map((s, i) => (
                    <div key={i} className="card" style={{ textAlign: 'center' }}>
                        <div style={{ fontFamily: 'Libre Baskerville', fontSize: 28, fontWeight: 700, color: s.color }}>{s.value}</div>
                        <div style={{ fontSize: 10, color: 'var(--text-muted)' }}>{s.label}</div>
                    </div>
                ))}
            </div>

            <div className="tab-bar">
                {tabs.map(t => <div key={t} className={`tab ${activeTab === t ? 'active' : ''}`} onClick={() => setActiveTab(t)}>{t}</div>)}
            </div>

            {/* ── TEAM TAB ── */}
            {activeTab === 'Team' && (
                <div className="card">
                    <div className="card-header">
                        <div className="card-title">All Members</div>
                        <div className="flex gap-8 items-center">
                            <input className="form-input" placeholder="Search users..." value={searchQ}
                                onChange={e => setSearchQ(e.target.value)}
                                style={{ width: 180, fontSize: 11, padding: '4px 8px' }} />
                            <select className="form-input" value={filterRole} onChange={e => setFilterRole(e.target.value)}
                                style={{ width: 120, fontSize: 11, padding: '4px 8px' }}>
                                <option value="">All Roles</option>
                                {roles.map(r => <option key={r} value={r}>{ROLE_LABELS[r]}</option>)}
                            </select>
                            <select className="form-input" value={filterStatus} onChange={e => setFilterStatus(e.target.value)}
                                style={{ width: 110, fontSize: 11, padding: '4px 8px' }}>
                                <option value="">All Status</option>
                                <option value="active">Active</option>
                                <option value="suspended">Suspended</option>
                                <option value="pending">Pending</option>
                                <option value="denied">Denied</option>
                            </select>
                        </div>
                    </div>
                    <div className="table-wrap">
                        <table className="data-table">
                            <thead><tr><th>User</th><th>Email</th><th>Role</th><th>Dept</th><th>Status</th><th>Last Active</th><th>Actions</th></tr></thead>
                            <tbody>
                                {users.map(u => (
                                    <tr key={u.id}>
                                        <td>
                                            <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                                                <div className="user-avatar" style={{ width: 28, height: 28, fontSize: 10 }}>{u.avatar_initials}</div>
                                                <div>
                                                    <div style={{ fontWeight: 600, fontSize: 12 }}>{u.display_name}</div>
                                                    {u.title && <div style={{ fontSize: 10, color: 'var(--text-muted)' }}>{u.title}</div>}
                                                </div>
                                            </div>
                                        </td>
                                        <td className="mono" style={{ fontSize: 11 }}>{u.email}</td>
                                        <td>
                                            {u.id !== user.id && isAdmin ? (
                                                <select className="form-input" value={u.role} onChange={e => changeRole(u.id, e.target.value)}
                                                    style={{ fontSize: 10, padding: '2px 6px', width: 110 }}>
                                                    {roles.map(r => <option key={r} value={r}>{ROLE_LABELS[r]}</option>)}
                                                </select>
                                            ) : (
                                                <span className="tag tag-blue" style={{ fontSize: 9 }}>{ROLE_LABELS[u.role]}</span>
                                            )}
                                        </td>
                                        <td style={{ fontSize: 11, color: 'var(--text-muted)' }}>{u.department || '—'}</td>
                                        <td>
                                            <span className={`tag ${u.status === 'active' ? 'tag-green' : u.status === 'suspended' ? 'tag-red' : u.status === 'denied' ? 'tag-red' : 'tag-amber'}`} style={{ fontSize: 9 }}>
                                                {u.status === 'active' ? '● ' : u.status === 'suspended' ? '⊘ ' : ''}{u.status}
                                            </span>
                                        </td>
                                        <td className="mono" style={{ fontSize: 10, color: 'var(--text-muted)' }}>
                                            {u.last_login ? new Date(u.last_login + 'Z').toLocaleDateString() : '—'}
                                        </td>
                                        <td>
                                            {u.id !== user.id && isAdmin && (
                                                <div className="flex gap-4">
                                                    {u.status === 'active' && <button className="btn btn-ghost" style={{ fontSize: 9, color: '#FBBF24', padding: '2px 6px' }} onClick={() => suspendUser(u.id)}>Suspend</button>}
                                                    {u.status === 'suspended' && <button className="btn btn-ghost" style={{ fontSize: 9, color: '#34D399', padding: '2px 6px' }} onClick={() => restoreUser(u.id)}>Restore</button>}
                                                    <button className="btn btn-ghost" style={{ fontSize: 9, padding: '2px 6px' }} onClick={() => forceReset(u.id)}>⟳ Reset PW</button>
                                                    <button className="btn btn-ghost" style={{ fontSize: 9, padding: '2px 6px' }} onClick={() => { setEditUser(u); setEditForm({ displayName: u.display_name, department: u.department, title: u.title, notes: u.admin_notes }); }}>Edit</button>
                                                    {isSuperAdmin && <button className="btn btn-ghost" style={{ fontSize: 9, color: '#F87171', padding: '2px 6px' }} onClick={() => deleteUser(u.id)}>Delete</button>}
                                                </div>
                                            )}
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            )}

            {/* ── APPROVALS TAB ── */}
            {activeTab === 'Approvals' && (
                <div>
                    {pending.length === 0 ? (
                        <div className="card" style={{ textAlign: 'center', padding: 40, color: 'var(--text-muted)' }}>
                            No pending requests. All clear.
                        </div>
                    ) : (
                        pending.map(u => {
                            const rl = riskLevel(u.risk_score || 0);
                            let factors = [];
                            try { factors = JSON.parse(u.risk_factors || '[]'); } catch (_) { }

                            return (
                                <div key={u.id} className="card mb-14">
                                    <div className="card-header">
                                        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                                            <div className="user-avatar" style={{ width: 36, height: 36, fontSize: 12 }}>{u.avatar_initials}</div>
                                            <div>
                                                <div style={{ fontWeight: 700, fontSize: 14, color: 'var(--text-primary)' }}>{u.display_name}</div>
                                                <div className="mono" style={{ fontSize: 11, color: 'var(--text-muted)' }}>{u.email}</div>
                                            </div>
                                        </div>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                                            <div style={{
                                                width: 40, height: 40, borderRadius: '50%', display: 'flex', alignItems: 'center', justifyContent: 'center',
                                                fontWeight: 700, fontSize: 14, fontFamily: 'JetBrains Mono',
                                                border: `2px solid ${RISK_COLORS[rl]}`, color: RISK_COLORS[rl],
                                            }}>{u.risk_score || 0}</div>
                                            <span className={`tag ${rl === 'low' ? 'tag-green' : rl === 'medium' ? 'tag-amber' : 'tag-red'}`} style={{ fontSize: 9 }}>
                                                {rl === 'low' ? '🟢 Low Risk' : rl === 'medium' ? '🟡 Medium' : '🔴 High Risk'}
                                            </span>
                                        </div>
                                    </div>

                                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 12, marginBottom: 12 }}>
                                        <div className="er-card">
                                            <div style={{ fontSize: 9, color: 'var(--text-muted)', fontFamily: 'JetBrains Mono', marginBottom: 4 }}>DEPARTMENT</div>
                                            <div style={{ fontSize: 12, color: u.department ? 'var(--text-primary)' : '#F87171' }}>{u.department || 'Not provided'}</div>
                                        </div>
                                        <div className="er-card">
                                            <div style={{ fontSize: 9, color: 'var(--text-muted)', fontFamily: 'JetBrains Mono', marginBottom: 4 }}>TITLE</div>
                                            <div style={{ fontSize: 12, color: u.title ? 'var(--text-primary)' : '#F87171' }}>{u.title || 'Not provided'}</div>
                                        </div>
                                        <div className="er-card">
                                            <div style={{ fontSize: 9, color: 'var(--text-muted)', fontFamily: 'JetBrains Mono', marginBottom: 4 }}>REFERRAL</div>
                                            <div style={{ fontSize: 12, color: u.referral_code ? '#34D399' : '#F87171' }}>{u.referral_code || 'None'}</div>
                                        </div>
                                    </div>

                                    <div className="er-card" style={{ marginBottom: 12 }}>
                                        <div style={{ fontSize: 9, color: 'var(--text-muted)', fontFamily: 'JetBrains Mono', marginBottom: 4 }}>REASON FOR ACCESS</div>
                                        <div style={{ fontSize: 12, color: 'var(--text-primary)', lineHeight: 1.5 }}>{u.reason_for_access || 'No reason provided'}</div>
                                    </div>

                                    {factors.length > 0 && (
                                        <div style={{ display: 'flex', flexWrap: 'wrap', gap: 4, marginBottom: 12 }}>
                                            {factors.map((f, i) => (
                                                <span key={i} className={`tag ${f.severity === 'good' ? 'tag-green' : f.severity === 'high' ? 'tag-red' : f.severity === 'medium' ? 'tag-amber' : 'tag-gray'}`}
                                                    style={{ fontSize: 9 }}>
                                                    {f.signal} ({f.points > 0 ? '+' : ''}{f.points})
                                                </span>
                                            ))}
                                        </div>
                                    )}

                                    <div style={{ display: 'flex', gap: 8, alignItems: 'flex-end' }}>
                                        <div style={{ flex: 1 }}>
                                            <label className="form-label" style={{ fontSize: 9 }}>ASSIGN ROLE</label>
                                            <select className="form-input" value={approvalRole[u.id] || 'viewer'}
                                                onChange={e => setApprovalRole(p => ({ ...p, [u.id]: e.target.value }))}
                                                style={{ fontSize: 11, padding: '4px 8px' }}>
                                                {roles.filter(r => r !== 'super_admin').map(r => <option key={r} value={r}>{ROLE_LABELS[r]}</option>)}
                                            </select>
                                        </div>
                                        <div style={{ flex: 2 }}>
                                            <label className="form-label" style={{ fontSize: 9 }}>ADMIN NOTES</label>
                                            <input className="form-input" placeholder="Optional notes..." value={approvalNotes[u.id] || ''}
                                                onChange={e => setApprovalNotes(p => ({ ...p, [u.id]: e.target.value }))}
                                                style={{ fontSize: 11, padding: '4px 8px' }} />
                                        </div>
                                        <button className="btn btn-primary" style={{ fontSize: 11, whiteSpace: 'nowrap' }} onClick={() => approveUser(u.id)}>
                                            ✓ Approve
                                        </button>
                                        {denyingId === u.id ? (
                                            <div style={{ display: 'flex', gap: 4, alignItems: 'flex-end' }}>
                                                <input className="form-input" placeholder="Denial reason (required)..." value={denyReason[u.id] || ''}
                                                    onChange={e => setDenyReason(p => ({ ...p, [u.id]: e.target.value }))}
                                                    style={{ fontSize: 11, padding: '4px 8px', width: 180 }} />
                                                <button className="btn btn-danger" style={{ fontSize: 11 }} onClick={() => denyUser(u.id)} disabled={(denyReason[u.id] || '').trim().length < 5}>
                                                    Confirm Deny
                                                </button>
                                                <button className="btn btn-ghost" style={{ fontSize: 11 }} onClick={() => setDenyingId(null)}>Cancel</button>
                                            </div>
                                        ) : (
                                            <button className="btn btn-danger" style={{ fontSize: 11, whiteSpace: 'nowrap' }} onClick={() => setDenyingId(u.id)}>
                                                ✕ Deny
                                            </button>
                                        )}
                                    </div>
                                </div>
                            );
                        })
                    )}
                </div>
            )}

            {/* ── SESSIONS TAB ── */}
            {activeTab === 'Sessions' && (
                <div className="card">
                    <div className="card-header">
                        <div className="card-title">Active Sessions</div>
                        <button className="btn btn-secondary" style={{ fontSize: 11 }} onClick={loadSessions}>
                            <Icon name="refresh" size={11} /> Refresh
                        </button>
                    </div>
                    {sessionsLoading ? (
                        <div style={{ textAlign: 'center', padding: 40, color: 'var(--text-muted)' }}>Loading...</div>
                    ) : (
                        <div className="table-wrap">
                            <table className="data-table">
                                <thead><tr><th>User</th><th>Device</th><th>IP</th><th>Location</th><th>Last Active</th><th>Actions</th></tr></thead>
                                <tbody>
                                    {sessions.map((s, i) => (
                                        <tr key={i}>
                                            <td>
                                                <div style={{ fontWeight: 600, fontSize: 12 }}>{s.displayName || 'Unknown'}</div>
                                                <div className="mono" style={{ fontSize: 10, color: 'var(--text-muted)' }}>{s.email}</div>
                                            </td>
                                            <td style={{ fontSize: 11 }}>{s.deviceLabel}</td>
                                            <td className="mono" style={{ fontSize: 10 }}>
                                                {s.ipAddress}
                                                {!s.isInternal && <span className="tag tag-red" style={{ marginLeft: 4, fontSize: 8 }}>⚠ External</span>}
                                            </td>
                                            <td><span className={`tag ${s.isInternal ? 'tag-green' : 'tag-amber'}`} style={{ fontSize: 9 }}>{s.isInternal ? 'Internal' : 'External'}</span></td>
                                            <td className="mono" style={{ fontSize: 10, color: 'var(--text-muted)' }}>{new Date(s.lastActive + 'Z').toLocaleString()}</td>
                                            <td>
                                                <button className="btn btn-ghost" style={{ fontSize: 10, color: '#F87171', padding: '2px 8px' }} onClick={() => revokeSession(s.id)}>
                                                    Revoke
                                                </button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                </div>
            )}

            {/* ── API KEYS TAB ── */}
            {activeTab === 'API Keys' && (
                <div>
                    <div className="card mb-14">
                        <div className="card-header"><div className="card-title">Create API Key</div></div>
                        <div style={{ display: 'flex', gap: 8, alignItems: 'flex-end' }}>
                            <div style={{ flex: 1 }}>
                                <label className="form-label" style={{ fontSize: 9 }}>KEY NAME</label>
                                <input className="form-input" placeholder="e.g. Pipeline Bot" value={newKeyName}
                                    onChange={e => setNewKeyName(e.target.value)} style={{ fontSize: 11, padding: '4px 8px' }} />
                            </div>
                            <div>
                                <label className="form-label" style={{ fontSize: 9 }}>SCOPES</label>
                                <div className="flex gap-4">
                                    {['read', 'write', 'graph', 'pipeline', 'audit'].map(s => (
                                        <label key={s} className={`tag ${newKeyScopes.includes(s) ? 'tag-blue' : 'tag-gray'}`}
                                            style={{ fontSize: 9, cursor: 'pointer' }}>
                                            <input type="checkbox" checked={newKeyScopes.includes(s)}
                                                onChange={e => setNewKeyScopes(e.target.checked ? [...newKeyScopes, s] : newKeyScopes.filter(x => x !== s))}
                                                style={{ display: 'none' }} />
                                            {s}
                                        </label>
                                    ))}
                                </div>
                            </div>
                            <button className="btn btn-primary" style={{ fontSize: 11 }} onClick={createApiKey}>Generate Key</button>
                        </div>

                        {createdKey && (
                            <div className="alert alert-warn mt-12">
                                <div style={{ fontSize: 11, fontWeight: 700, marginBottom: 6 }}>⚠ Copy this key now — it won't be shown again</div>
                                <div style={{ display: 'flex', gap: 8, alignItems: 'center' }}>
                                    <code className="mono" style={{ fontSize: 11, flex: 1, wordBreak: 'break-all', background: 'rgba(0,0,0,0.3)', padding: '6px 8px', borderRadius: 4 }}>
                                        {createdKey.key}
                                    </code>
                                    <button className="btn btn-secondary" style={{ fontSize: 10 }} onClick={() => {
                                        navigator.clipboard.writeText(createdKey.key);
                                        setKeyCopied(true);
                                        setTimeout(() => setKeyCopied(false), 2000);
                                    }}>
                                        {keyCopied ? '✓ Copied' : 'Copy'}
                                    </button>
                                </div>
                            </div>
                        )}
                    </div>

                    <div className="card">
                        <div className="card-header"><div className="card-title">Your API Keys</div></div>
                        {apiKeys.length === 0 ? (
                            <div style={{ textAlign: 'center', padding: 30, color: 'var(--text-muted)', fontSize: 12 }}>No API keys created yet.</div>
                        ) : (
                            <div className="table-wrap">
                                <table className="data-table">
                                    <thead><tr><th>Name</th><th>Prefix</th><th>Scopes</th><th>Created</th><th>Expires</th><th>Status</th><th>Actions</th></tr></thead>
                                    <tbody>
                                        {apiKeys.map(k => (
                                            <tr key={k.id}>
                                                <td style={{ fontWeight: 600, fontSize: 12 }}>{k.name}</td>
                                                <td className="mono" style={{ fontSize: 10 }}>{k.key_prefix}</td>
                                                <td>{k.scopes.map(s => <span key={s} className="tag tag-blue" style={{ fontSize: 8, marginRight: 2 }}>{s}</span>)}</td>
                                                <td className="mono" style={{ fontSize: 10, color: 'var(--text-muted)' }}>{new Date(k.created_at + 'Z').toLocaleDateString()}</td>
                                                <td className="mono" style={{ fontSize: 10, color: 'var(--text-muted)' }}>{k.expires_at ? new Date(k.expires_at).toLocaleDateString() : '—'}</td>
                                                <td><span className={`tag ${k.revoked ? 'tag-red' : 'tag-green'}`} style={{ fontSize: 9 }}>{k.revoked ? 'Revoked' : '● Active'}</span></td>
                                                <td>
                                                    {!k.revoked && <button className="btn btn-ghost" style={{ fontSize: 10, color: '#F87171', padding: '2px 8px' }} onClick={() => revokeApiKey(k.id)}>Revoke</button>}
                                                </td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
                            </div>
                        )}
                    </div>
                </div>
            )}

            {/* ── POLICIES TAB ── */}
            {activeTab === 'Policies' && (
                <div className="grid-2">
                    {[
                        {
                            title: 'Password Policy', icon: 'security', fields: [
                                { key: 'password.min_length', label: 'Minimum Length', type: 'number' },
                                { key: 'password.require_uppercase', label: 'Require Uppercase', type: 'bool' },
                                { key: 'password.require_lowercase', label: 'Require Lowercase', type: 'bool' },
                                { key: 'password.require_number', label: 'Require Number', type: 'bool' },
                                { key: 'password.require_special', label: 'Require Special Char', type: 'bool' },
                                { key: 'password.expiry_days', label: 'Expiry (days)', type: 'number' },
                                { key: 'password.history_count', label: 'History Count', type: 'number' },
                            ]
                        },
                        {
                            title: 'Session & Lockout', icon: 'key', fields: [
                                { key: 'session.timeout_hours', label: 'Session Timeout (hours)', type: 'number' },
                                { key: 'session.max_concurrent', label: 'Max Concurrent Sessions', type: 'number' },
                                { key: 'session.refresh_days', label: 'Refresh Token (days)', type: 'number' },
                                { key: 'lockout.max_attempts', label: 'Max Login Attempts', type: 'number' },
                                { key: 'lockout.duration_minutes', label: 'Lockout Duration (min)', type: 'number' },
                                { key: 'lockout.progressive', label: 'Progressive Lockout', type: 'bool' },
                            ]
                        },
                    ].map((section, si) => (
                        <div key={si} className="card">
                            <div className="card-header">
                                <div className="card-title"><Icon name={section.icon} size={14} /> {section.title}</div>
                            </div>
                            {section.fields.map(f => (
                                <div key={f.key} className="metric-row" style={{ padding: '8px 0' }}>
                                    <div className="metric-name">{f.label}</div>
                                    {f.type === 'bool' ? (
                                        <select className="form-input" value={policyEdits[f.key] || 'true'}
                                            onChange={e => setPolicyEdits(p => ({ ...p, [f.key]: e.target.value }))}
                                            style={{ width: 80, fontSize: 10, padding: '2px 6px' }}
                                            disabled={!isSuperAdmin}>
                                            <option value="true">Yes</option>
                                            <option value="false">No</option>
                                        </select>
                                    ) : (
                                        <input className="form-input" type="number" value={policyEdits[f.key] || ''}
                                            onChange={e => setPolicyEdits(p => ({ ...p, [f.key]: e.target.value }))}
                                            style={{ width: 70, fontSize: 11, padding: '2px 6px', textAlign: 'center' }}
                                            disabled={!isSuperAdmin} />
                                    )}
                                </div>
                            ))}
                        </div>
                    ))}
                    {isSuperAdmin && (
                        <div style={{ gridColumn: 'span 2', textAlign: 'right' }}>
                            <button className="btn btn-primary" onClick={savePolicies} disabled={policySaving}>
                                {policySaving ? 'Saving...' : 'Save Policies'}
                            </button>
                        </div>
                    )}
                </div>
            )}

            {/* Edit User Modal */}
            {editUser && (
                <div className="profile-overlay" onClick={() => setEditUser(null)}>
                    <div className="profile-panel" style={{ maxWidth: 400 }} onClick={e => e.stopPropagation()}>
                        <div className="profile-header">
                            <div style={{ fontWeight: 700, color: 'var(--text-primary)' }}>Edit {editUser.display_name}</div>
                            <div onClick={() => setEditUser(null)} style={{ cursor: 'pointer', color: 'var(--text-muted)' }}>✕</div>
                        </div>
                        <div className="profile-body">
                            <label className="form-label">Display Name</label>
                            <input className="form-input mb-12" value={editForm.displayName || ''} onChange={e => setEditForm(f => ({ ...f, displayName: e.target.value }))} />
                            <label className="form-label">Department</label>
                            <input className="form-input mb-12" value={editForm.department || ''} onChange={e => setEditForm(f => ({ ...f, department: e.target.value }))} />
                            <label className="form-label">Title</label>
                            <input className="form-input mb-12" value={editForm.title || ''} onChange={e => setEditForm(f => ({ ...f, title: e.target.value }))} />
                            <label className="form-label">Admin Notes</label>
                            <textarea className="form-input" rows={3} value={editForm.notes || ''} onChange={e => setEditForm(f => ({ ...f, notes: e.target.value }))}
                                style={{ resize: 'none', fontFamily: 'inherit' }} />
                            <button className="btn btn-primary" style={{ width: '100%', marginTop: 16 }} onClick={updateUserDetails}>Save Changes</button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default SettingsPage;
