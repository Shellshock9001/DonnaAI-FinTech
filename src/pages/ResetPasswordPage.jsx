import { useState, useEffect } from 'react';

export default function ResetPasswordPage({ onSuccess }) {
    const [token, setToken] = useState('');
    const [newPassword, setNewPassword] = useState('');
    const [confirm, setConfirm] = useState('');
    const [error, setError] = useState('');
    const [success, setSuccess] = useState(false);
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        const params = new URLSearchParams(window.location.search);
        const t = params.get('token');
        if (t) setToken(t);
        else setError('Invalid or missing reset token.');
    }, []);

    async function handleSubmit(e) {
        e.preventDefault();
        setError('');

        if (newPassword !== confirm) {
            setError('Passwords do not match.');
            return;
        }

        setLoading(true);
        try {
            const res = await fetch('/api/auth/reset-password', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ token, newPassword }),
            });
            const data = await res.json();
            if (!res.ok) throw new Error(data.error || 'Reset failed');
            setSuccess(true);
        } catch (err) {
            setError(err.message);
        } finally {
            setLoading(false);
        }
    }

    return (
        <div style={{
            width: '100vw', height: '100vh', display: 'flex',
            alignItems: 'center', justifyContent: 'center',
            background: '#0A0C10',
            backgroundImage: 'radial-gradient(ellipse 80% 50% at 50% -20%, rgba(201,168,76,0.06) 0%, transparent 60%)',
        }}>
            <div style={{
                background: '#161B22', border: '1px solid #21283A',
                borderRadius: 14, padding: 32, width: '100%', maxWidth: 400,
                boxShadow: '0 24px 64px rgba(0,0,0,0.4)',
            }}>
                <div style={{ fontFamily: 'Georgia, serif', fontSize: 22, fontWeight: 700, color: '#C9A84C', marginBottom: 4 }}>
                    Liquidity.ai
                </div>
                <div style={{ fontFamily: 'monospace', fontSize: 9, color: '#4A5568', letterSpacing: 3, marginBottom: 24 }}>
                    FINANCIAL INTELLIGENCE GRAPH
                </div>

                {success ? (
                    <div>
                        <div style={{ color: '#34D399', fontSize: 16, fontWeight: 600, marginBottom: 12 }}>
                            ✅ Password reset successfully!
                        </div>
                        <p style={{ color: '#8892A4', fontSize: 13, marginBottom: 24 }}>
                            Your password has been updated. You can now log in with your new password.
                        </p>
                        <button
                            onClick={onSuccess}
                            style={{
                                width: '100%', background: '#C9A84C', color: '#0A0C10',
                                border: 'none', borderRadius: 6, padding: '10px 0',
                                fontWeight: 700, fontSize: 13, cursor: 'pointer', letterSpacing: 1,
                            }}>
                            GO TO LOGIN
                        </button>
                    </div>
                ) : (
                    <div>
                        <h2 style={{ color: '#E8ECF2', fontSize: 18, fontWeight: 600, marginBottom: 8 }}>
                            Reset Your Password
                        </h2>
                        <p style={{ color: '#8892A4', fontSize: 13, marginBottom: 24 }}>
                            Enter your new password below.
                        </p>

                        {error && (
                            <div style={{
                                background: 'rgba(248,113,113,0.08)', border: '1px solid rgba(248,113,113,0.2)',
                                borderRadius: 6, padding: '10px 14px', color: '#F87171',
                                fontSize: 12, marginBottom: 16,
                            }}>
                                {error}
                            </div>
                        )}

                        <form onSubmit={handleSubmit}>
                            <div style={{ marginBottom: 16 }}>
                                <label style={{ display: 'block', fontSize: 11, fontWeight: 600, color: '#8892A4', letterSpacing: 1, marginBottom: 6 }}>
                                    NEW PASSWORD
                                </label>
                                <input
                                    type="password"
                                    value={newPassword}
                                    onChange={e => setNewPassword(e.target.value)}
                                    required
                                    style={{
                                        width: '100%', background: '#0F1318', border: '1px solid #21283A',
                                        borderRadius: 6, padding: '8px 12px', fontSize: 13,
                                        color: '#E8ECF2', outline: 'none', boxSizing: 'border-box',
                                    }}
                                    placeholder="Min 8 chars, uppercase, number, special"
                                />
                            </div>

                            <div style={{ marginBottom: 24 }}>
                                <label style={{ display: 'block', fontSize: 11, fontWeight: 600, color: '#8892A4', letterSpacing: 1, marginBottom: 6 }}>
                                    CONFIRM PASSWORD
                                </label>
                                <input
                                    type="password"
                                    value={confirm}
                                    onChange={e => setConfirm(e.target.value)}
                                    required
                                    style={{
                                        width: '100%', background: '#0F1318', border: '1px solid #21283A',
                                        borderRadius: 6, padding: '8px 12px', fontSize: 13,
                                        color: '#E8ECF2', outline: 'none', boxSizing: 'border-box',
                                    }}
                                    placeholder="Confirm your new password"
                                />
                            </div>

                            <button
                                type="submit"
                                disabled={loading}
                                style={{
                                    width: '100%', background: loading ? '#8B6F2E' : '#C9A84C',
                                    color: '#0A0C10', border: 'none', borderRadius: 6,
                                    padding: '10px 0', fontWeight: 700, fontSize: 13,
                                    cursor: loading ? 'not-allowed' : 'pointer', letterSpacing: 1,
                                }}>
                                {loading ? 'RESETTING...' : 'RESET PASSWORD'}
                            </button>
                        </form>
                    </div>
                )}
            </div>
        </div>
    );
}