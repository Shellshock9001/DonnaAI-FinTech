import { useState } from 'react';
import Icon from '../components/Icon';

const ViewsPage = () => {
    const [activePersona, setActivePersona] = useState("family-office");
    const personas = [
        { id: "family-office", label: "Family Office", icon: "🏛️" },
        { id: "vc", label: "VC", icon: "🚀" },
        { id: "pe", label: "Private Equity", icon: "🏢" },
        { id: "ai-investors", label: "AI Investors", icon: "🤖" },
    ];

    const viewConfig = {
        "family-office": {
            title: "Family Office View",
            metrics: ["AUM by strategy", "Co-investor network", "Geographic exposure", "Vintage year distribution"],
            features: ["Relationship mapping", "Wealth preservation focus", "Multi-generational lineage", "Custom reporting cadence"],
            defaultFields: ["Organization.legal_name", "Fund.fund_size", "Fund.strategy_tags[]", "Person.roles[]", "Deal.geography"],
        },
        vc: {
            title: "Venture Capital View",
            metrics: ["Stage distribution", "Sector heat map", "Emerging manager radar", "Portfolio company tracking"],
            features: ["Early-stage focus", "Founder relationship graph", "Valuation trend tracking", "LP/GP lineage"],
            defaultFields: ["Organization.investor_type_tags[]", "Deal.stage", "Deal.sector_tags[]", "Deal.ticket_size_range", "Person.career_history[]"],
        },
        pe: {
            title: "Private Equity View",
            metrics: ["Hold period analysis", "Add-on strategy tracking", "Exit multiples", "Leverage metrics"],
            features: ["Buyout/LBO tracking", "Management team mapping", "Geographic arbitrage", "Sector deep-dives"],
            defaultFields: ["Fund.strategy_tags[]", "Deal.deal_type", "Organization.AUM_band", "Deal.actual_ticket", "Fund.vintage_year"],
        },
        "ai-investors": {
            title: "AI/Tech Investor View",
            metrics: ["AI company coverage", "Compute infra investors", "Foundation model rounds", "GPU allocation tracking"],
            features: ["AI taxonomy (custom)", "Compute supply chain", "Model company lineage", "Cross-modal deal tracking"],
            defaultFields: ["Organization.legal_name", "Deal.sector_tags[]", "Deal.stage", "Deal.ticket_size_range", "Deal.co_investors[]"],
        },
    };

    const cfg = viewConfig[activePersona];

    return (
        <div>
            <div className="section-header">
                <div>
                    <div className="section-title">Views & Personas</div>
                    <div className="section-subtitle">Declarative view definitions · Versioned · No data duplication</div>
                </div>
                <button className="btn btn-primary">+ New View</button>
            </div>

            <div className="flex gap-8 mb-16">
                {personas.map(p => (
                    <div key={p.id}
                        onClick={() => setActivePersona(p.id)}
                        style={{
                            display: "flex", alignItems: "center", gap: 8,
                            padding: "10px 18px",
                            borderRadius: 8, cursor: "pointer",
                            border: `1px solid ${activePersona === p.id ? "rgba(201,168,76,0.4)" : "var(--border)"}`,
                            background: activePersona === p.id ? "var(--accent-glow)" : "var(--surface-high)",
                            color: activePersona === p.id ? "var(--accent)" : "var(--text-secondary)",
                            fontSize: 13, fontWeight: 600,
                            transition: "all 0.15s",
                        }}>
                        <span>{p.icon}</span>{p.label}
                    </div>
                ))}
            </div>

            <div className="grid-2">
                <div className="card card-accent">
                    <div className="card-header">
                        <div className="card-title">{cfg.title} — Configuration</div>
                        <span className="tag tag-green">v3.1</span>
                    </div>
                    <div className="form-group">
                        <label className="form-label">Default Canonical Fields</label>
                        {cfg.defaultFields.map((f, i) => (
                            <div key={i} style={{ display: "flex", alignItems: "center", justifyContent: "space-between", padding: "5px 0", borderBottom: "1px solid rgba(33,40,58,0.4)" }}>
                                <span className="mono" style={{ fontSize: 11, color: "var(--teal)" }}>{f}</span>
                                <button className="btn btn-ghost" style={{ padding: "1px 8px", fontSize: 10 }}>Remove</button>
                            </div>
                        ))}
                        <button className="btn btn-ghost w-full mt-8" style={{ fontSize: 11 }}>+ Add Field</button>
                    </div>
                    <div className="divider" />
                    <div className="form-group">
                        <label className="form-label">Access Policy</label>
                        <select className="form-select">
                            <option>Internal + Pilot Customers</option>
                            <option>Internal Only</option>
                            <option>All Authenticated Users</option>
                        </select>
                    </div>
                    <div className="form-group">
                        <label className="form-label">Provenance Visibility</label>
                        <select className="form-select">
                            <option>Full (sources + confidence)</option>
                            <option>Summary (confidence only)</option>
                            <option>Hidden</option>
                        </select>
                    </div>
                    <button className="btn btn-primary w-full mt-8">Save & Publish View</button>
                </div>

                <div>
                    <div className="card mb-14">
                        <div className="card-header"><div className="card-title">Included Metrics</div></div>
                        {cfg.metrics.map((m, i) => (
                            <div key={i} style={{ display: "flex", alignItems: "center", gap: 8, padding: "6px 0", borderBottom: "1px solid rgba(33,40,58,0.4)" }}>
                                <span style={{ color: "var(--green)" }}>✓</span>
                                <span style={{ fontSize: 12, color: "var(--text-secondary)" }}>{m}</span>
                            </div>
                        ))}
                    </div>
                    <div className="card">
                        <div className="card-header"><div className="card-title">Persona Features</div></div>
                        {cfg.features.map((f, i) => (
                            <div key={i} style={{ display: "flex", alignItems: "center", gap: 8, padding: "6px 0", borderBottom: "1px solid rgba(33,40,58,0.4)" }}>
                                <span style={{ color: "var(--teal)" }}>◆</span>
                                <span style={{ fontSize: 12, color: "var(--text-secondary)" }}>{f}</span>
                            </div>
                        ))}
                        <div className="divider" />
                        <div className="card-title mb-8">Memo Export</div>
                        <button className="btn btn-secondary w-full" style={{ fontSize: 12, gap: 6 }}><Icon name="export" size={12} />Generate Intelligence Brief</button>
                        <div style={{ fontSize: 10, color: "var(--text-muted)", textAlign: "center", marginTop: 6 }}>Includes provenance footnotes and confidence bands</div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ViewsPage;
