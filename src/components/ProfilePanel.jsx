import { useState, useEffect, useCallback } from 'react';
import { useAuth } from '../context/AuthContext';
import Icon from './Icon';

const API = '/api';

export default function ProfilePanel({ isOpen, onClose }) {
    const { user, authFetch, logout } = useAuth();
    const [tab, setTab] = useState('account');
    const [sessions, setSessions] = useState([]);
    const [loadingSessions, setLoadingSessions] = useState(false);

    // Password change state
    const [currentPw, setCurrentPw] = useState('');
    const [newPw, setNewPw] = useState('');
    const [confirmPw, setConfirmPw] = useState('');
    const [pwMsg, setPwMsg] = useState(null);
    const [pwError, setPwError] = useState(null);
    const [changingPw, setChangingPw] = useState(false);

    const loadSessions = useCallback(async () => {
        setLoadingSessions(true);
        try {
            const res = await authFetch(`${API}/sessions`);
            if (res.ok) {
                const data = await res.json();
                setSessions(data.sessions || []);
            }
        } catch (_) { }
        setLoadingSessions(false);
    }, [authFetch]);

    useEffect(() => {
        if (isOpen && tab === 'sessions') loadSessions();
    }, [isOpen, tab, loadSessions]);

    const handlePasswordChange = async (e) => {
        e.preventDefault();
        setPwMsg(null); setPwError(null);
        if (newPw !== confirmPw) { setPwError('Passwords do not match'); return; }
        setChangingPw(true);
        try {
            const res = await authFetch(`${API}/auth/password`, {
                method: 'PUT',
                body: JSON.stringify({ currentPassword: currentPw, newPassword: newPw }),
            });
            const data = await res.json();
            if (res.ok) {
                setPwMsg('Password changed successfully');
                setCurrentPw(''); setNewPw(''); setConfirmPw('');
            } else {
                setPwError(data.error || 'Failed');
                if (data.details) setPwError(data.details.join(', '));
            }
        } catch (_) { setPwError('Network error'); }
        setChangingPw(false);
    };

    const revokeSession = async (sid) => {
        const res = await authFetch(`${API}/sessions/${sid}`, { method: 'DELETE' });
        if (res.ok) loadSessions();
    };

    const revokeAll = async () => {
        const res = await authFetch(`${API}/sessions/user/${user.id}`, { method: 'DELETE' });
        if (res.ok) logout();
    };

    // Password strength
    const strength = (() => {
        if (!newPw) return { score: 0, label: '', color: '#4A5568' };
        let s = 0;
        if (newPw.length >= 8) s++;
        if (newPw.length >= 12) s++;
        if (/[A-Z]/.test(newPw)) s++;
        if (/[a-z]/.test(newPw)) s++;
        if (/[0-9]/.test(newPw)) s++;
        if (/[^A-Za-z0-9]/.test(newPw)) s++;
        if (s <= 2) return { score: s, label: 'Weak', color: '#F87171' };
        if (s <= 4) return { score: s, label: 'Fair', color: '#FBBF24' };
        return { score: s, label: 'Strong', color: '#34D399' };
    })();

    if (!isOpen) return null;

    return (
        <>
            <div className="profile-overlay" onClick={onClose} />
            <div className="profile-panel">
                <div className="profile-header">
                    <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                        <div className="user-avatar" style={{ width: 44, height: 44, fontSize: 15 }}>
                            {user.avatarInitials || user.displayName?.slice(0, 2).toUpperCase()}
                        </div>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: 16, color: 'var(--text-primary)' }}>{user.displayName}</div>
                            <div style={{ fontSize: 11, color: 'var(--accent)', fontFamily: 'JetBrains Mono' }}>
                                {user.role.replace(/_/g, ' ').replace(/\b\w/g, c => c.toUpperCase())}
                            </div>
                        </div>
                    </div>
                    <div onClick={onClose} style={{ cursor: 'pointer', padding: 6, borderRadius: 6, color: 'var(--text-muted)' }}>✕</div>
                </div>

                <div className="tab-bar" style={{ padding: '0 16px' }}>
                    {['account', 'password', 'sessions'].map(t => (
                        <div key={t} className={`tab ${tab === t ? 'active' : ''}`} onClick={() => setTab(t)}>
                            {t.charAt(0).toUpperCase() + t.slice(1)}
                        </div>
                    ))}
                </div>

                <div className="profile-body">
                    {tab === 'account' && (
                        <div>
                            {[
                                { label: 'Email', value: user.email },
                                { label: 'Role', value: user.role.replace(/_/g, ' ').replace(/\b\w/g, c => c.toUpperCase()) },
                                { label: 'Department', value: user.department || '—' },
                                { label: 'Title', value: user.title || '—' },
                                { label: 'Member Since', value: user.createdAt ? new Date(user.createdAt + 'Z').toLocaleDateString() : '—' },
                                { label: 'Approved By', value: user.approvedBy || 'SYSTEM' },
                                { label: 'Last Login', value: user.lastLogin ? new Date(user.lastLogin + 'Z').toLocaleString() : '—' },
                            ].map((item, i) => (
                                <div key={i} className="metric-row" style={{ padding: '10px 0' }}>
                                    <div className="metric-name">{item.label}</div>
                                    <div style={{ fontSize: 12, color: 'var(--text-primary)', fontFamily: 'JetBrains Mono' }}>{item.value}</div>
                                </div>
                            ))}
                            <button className="btn btn-danger" style={{ marginTop: 20, width: '100%' }} onClick={logout}>
                                Sign Out
                            </button>
                        </div>
                    )}

                    {tab === 'password' && (
                        <form onSubmit={handlePasswordChange}>
                            <div className="alert alert-info mb-12" style={{ fontSize: 10 }}>
                                <Icon name="security" size={11} /> Min 8 chars · uppercase · lowercase · number · special character
                            </div>

                            <label className="form-label">Current Password</label>
                            <input type="password" className="form-input" value={currentPw} onChange={e => setCurrentPw(e.target.value)} required />

                            <label className="form-label" style={{ marginTop: 12 }}>New Password</label>
                            <input type="password" className="form-input" value={newPw} onChange={e => setNewPw(e.target.value)} required />

                            {newPw && (
                                <div style={{ marginTop: 6 }}>
                                    <div style={{ display: 'flex', gap: 3, marginBottom: 4 }}>
                                        {[...Array(6)].map((_, i) => (
                                            <div key={i} style={{
                                                flex: 1, height: 3, borderRadius: 2,
                                                background: i < strength.score ? strength.color : 'var(--border)',
                                            }} />
                                        ))}
                                    </div>
                                    <div style={{ fontSize: 10, color: strength.color, fontFamily: 'JetBrains Mono' }}>{strength.label}</div>
                                </div>
                            )}

                            <label className="form-label" style={{ marginTop: 12 }}>Confirm New Password</label>
                            <input type="password" className="form-input" value={confirmPw} onChange={e => setConfirmPw(e.target.value)} required />

                            {pwError && <div className="alert alert-error mt-12" style={{ fontSize: 11 }}>{pwError}</div>}
                            {pwMsg && <div className="alert alert-success mt-12" style={{ fontSize: 11 }}>{pwMsg}</div>}

                            <button className="btn btn-primary" style={{ marginTop: 16, width: '100%' }} disabled={changingPw}>
                                {changingPw ? 'Changing...' : 'Change Password'}
                            </button>
                        </form>
                    )}

                    {tab === 'sessions' && (
                        <div>
                            {loadingSessions ? (
                                <div style={{ textAlign: 'center', padding: 30, color: 'var(--text-muted)' }}>Loading sessions...</div>
                            ) : sessions.length === 0 ? (
                                <div style={{ textAlign: 'center', padding: 30, color: 'var(--text-muted)' }}>No active sessions</div>
                            ) : (
                                <>
                                    {sessions.map((s, i) => (
                                        <div key={i} className="er-card" style={{ marginBottom: 8 }}>
                                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                                                <div>
                                                    <div style={{ fontWeight: 600, fontSize: 12, color: 'var(--text-primary)' }}>
                                                        {s.deviceLabel}
                                                        {!s.isInternal && <span className="tag tag-red" style={{ marginLeft: 6, fontSize: 8 }}>⚠ External</span>}
                                                    </div>
                                                    <div className="mono" style={{ fontSize: 10, color: 'var(--text-muted)', marginTop: 2 }}>
                                                        IP: {s.ipAddress} · Last active: {new Date(s.lastActive + 'Z').toLocaleString()}
                                                    </div>
                                                </div>
                                                <button className="btn btn-ghost" style={{ fontSize: 10, color: '#F87171', padding: '2px 8px' }}
                                                    onClick={() => revokeSession(s.id)}>
                                                    Revoke
                                                </button>
                                            </div>
                                        </div>
                                    ))}
                                    <button className="btn btn-danger" style={{ marginTop: 12, width: '100%', fontSize: 11 }} onClick={revokeAll}>
                                        Sign Out All Sessions
                                    </button>
                                </>
                            )}
                        </div>
                    )}
                </div>
            </div>
        </>
    );
}
