import { useState } from 'react';
import Icon from '../components/Icon';
import ConfidenceRing from '../components/ConfidenceRing';
import Toggle from '../components/Toggle';
import Sparkline from '../components/Sparkline';

const EntityResolutionPage = () => {
    const [activeTab, setActiveTab] = useState("queue");
    const tabs = ["queue", "config", "metrics", "anchors"];

    const queue = [
        { id: "ER-4821", entities: ["Accel Partners LP", "Accel LLP", "Accel Management Co."], type: "ORG_CLUSTER", score: 74, evidence: ["domain: accel.com (all)", "LEI partial match", "3 shared investments"], priority: "High", age: "2h", impact: "$42B AUM" },
        { id: "ER-4820", entities: ["John Lim", "John K. Lim", "J. Lim (Tiger)"], type: "PERSON_DEDUP", score: 61, evidence: ["name similarity 0.87", "same employer", "different email domains"], priority: "Med", age: "5h", impact: "Partner-level" },
        { id: "ER-4819", entities: ["Lightspeed Venture X", "Lightspeed X LP"], type: "FUND_MERGE", score: 83, evidence: ["SEC filing match", "vintage 2021", "same GP"], priority: "Low", age: "12h", impact: "$7.1B Fund" },
        { id: "ER-4818", entities: ["Databricks Series F (2023)", "Databricks Round F"], type: "DEAL_CONFLICT", score: 56, evidence: ["ticker:DBKS", "amount conflict: $500M vs $520M", "date: same quarter"], priority: "High", age: "1h", impact: "$520M deal" },
    ];

    return (
        <div>
            <div className="section-header">
                <div>
                    <div className="section-title">Entity Resolution</div>
                    <div className="section-subtitle">Hybrid adjudication · Deterministic anchors → Fuzzy scoring → LLM</div>
                </div>
                <div className="flex gap-8 items-center">
                    <span className="tag tag-red">31 in queue</span>
                    <span className="tag tag-amber">5 high priority</span>
                    <button className="btn btn-primary">Run ER Pass</button>
                </div>
            </div>

            <div className="tab-bar">
                {tabs.map(t => <div key={t} className={`tab ${activeTab === t ? "active" : ""}`} onClick={() => setActiveTab(t)}>{t.charAt(0).toUpperCase() + t.slice(1)}</div>)}
            </div>

            {activeTab === "queue" && (
                <div>
                    <div className="chip-filter">
                        {["All", "High Priority", "ORG_CLUSTER", "PERSON_DEDUP", "FUND_MERGE", "DEAL_CONFLICT"].map(c => (
                            <div key={c} className={`chip ${c === "All" ? "active" : ""}`}>{c}</div>
                        ))}
                    </div>
                    {queue.map((item, i) => (
                        <div key={i} className={`er-card ${item.priority === "High" ? "flagged" : "review"}`} style={{ marginBottom: 12 }}>
                            <div className="flex items-start gap-16">
                                <ConfidenceRing value={item.score} color={item.score > 80 ? "#34D399" : item.score > 65 ? "#C9A84C" : "#F87171"} />
                                <div style={{ flex: 1, minWidth: 0 }}>
                                    <div className="flex items-center gap-8 mb-8">
                                        <span className="mono text-muted" style={{ fontSize: 10 }}>{item.id}</span>
                                        <span className={`tag ${item.type.includes("ORG") ? "tag-amber" : item.type.includes("PERSON") ? "tag-blue" : item.type.includes("FUND") ? "tag-teal" : "tag-red"}`}>{item.type}</span>
                                        <span className={`tag ${item.priority === "High" ? "tag-red" : item.priority === "Med" ? "tag-amber" : "tag-gray"}`}>{item.priority}</span>
                                        <span className="mono text-muted" style={{ fontSize: 10, marginLeft: "auto" }}>{item.age} · {item.impact}</span>
                                    </div>
                                    <div className="flex gap-8 mb-8 flex-wrap">
                                        {item.entities.map((e, j) => (
                                            <div key={j} style={{ background: "var(--surface-higher)", border: "1px solid var(--border)", borderRadius: 4, padding: "3px 8px", fontSize: 12, color: "var(--text-primary)" }}>
                                                {j > 0 && <span style={{ color: "var(--text-muted)", marginRight: 4 }}>≈</span>}{e}
                                            </div>
                                        ))}
                                    </div>
                                    <div style={{ marginBottom: 10 }}>
                                        <div style={{ fontSize: 10, color: "var(--text-muted)", fontFamily: "JetBrains Mono", marginBottom: 4 }}>LLM EVIDENCE SNIPPETS</div>
                                        {item.evidence.map((ev, j) => (
                                            <div key={j} style={{ fontSize: 11, color: "var(--text-secondary)", padding: "2px 0", display: "flex", alignItems: "center", gap: 6 }}>
                                                <span style={{ color: "var(--teal)" }}>›</span> {ev}
                                            </div>
                                        ))}
                                    </div>
                                    <div className="flex gap-8">
                                        <button className="btn btn-primary" style={{ fontSize: 11, padding: "4px 14px", gap: 4 }}><Icon name="merge" size={11} />Approve Merge</button>
                                        <button className="btn btn-danger" style={{ fontSize: 11, padding: "4px 14px", gap: 4 }}><Icon name="x" size={11} />Reject / Split</button>
                                        <button className="btn btn-secondary" style={{ fontSize: 11, padding: "4px 14px" }}>View Full Artifact</button>
                                        <button className="btn btn-ghost" style={{ fontSize: 11, padding: "4px 14px" }}>Escalate</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {activeTab === "config" && (
                <div className="grid-2">
                    <div className="card">
                        <div className="card-header"><div className="card-title">Fuzzy Scoring Weights</div></div>
                        <div style={{ fontSize: 11, color: "var(--text-muted)", marginBottom: 14 }}>Composite score = weighted sum. Must sum to 1.0.</div>
                        {[
                            { factor: "Name Similarity (embedding cosine)", weight: 0.35 },
                            { factor: "Domain / URL Overlap", weight: 0.20 },
                            { factor: "Address Proximity (geocoded)", weight: 0.10 },
                            { factor: "Shared Co-investments", weight: 0.20 },
                            { factor: "Role / Title Overlap", weight: 0.15 },
                        ].map((f, i) => (
                            <div key={i} style={{ marginBottom: 12 }}>
                                <div className="flex justify-between mb-4">
                                    <span style={{ fontSize: 12, color: "var(--text-secondary)" }}>{f.factor}</span>
                                    <span className="mono" style={{ fontSize: 12, color: "var(--accent)" }}>{f.weight.toFixed(2)}</span>
                                </div>
                                <div className="progress-bar">
                                    <div className="progress-fill accent" style={{ width: `${f.weight * 100}%` }} />
                                </div>
                            </div>
                        ))}
                        <div className="divider" />
                        <div className="form-group">
                            <label className="form-label">Auto-merge Threshold</label>
                            <input className="form-input" defaultValue="92" type="number" />
                            <div style={{ fontSize: 11, color: "var(--text-muted)", marginTop: 4 }}>Records above this score are merged automatically (no human review)</div>
                        </div>
                        <div className="form-group">
                            <label className="form-label">HITL Trigger Threshold</label>
                            <input className="form-input" defaultValue="60" type="number" />
                            <div style={{ fontSize: 11, color: "var(--text-muted)", marginTop: 4 }}>Records in [60–92] go to human review queue</div>
                        </div>
                        <button className="btn btn-primary w-full">Save ER Config</button>
                    </div>
                    <div className="card">
                        <div className="card-header"><div className="card-title">HITL Workflow Settings</div></div>
                        {[
                            { name: "Require 2 approvals for AUM > $10B merges", checked: true },
                            { name: "Require 2 approvals for strategic-tier entities", checked: true },
                            { name: "Auto-escalate stale items after 48h", checked: true },
                            { name: "Notify team lead on high-impact rejects", checked: true },
                            { name: "Allow single-reviewer for low-impact items", checked: false },
                            { name: "Continuous audit sampling (5% of auto-merges)", checked: true },
                        ].map((opt, i) => (
                            <div key={i} className="control-row">
                                <div className="control-info">
                                    <div className="control-name">{opt.name}</div>
                                </div>
                                <Toggle checked={opt.checked} onChange={() => { }} />
                            </div>
                        ))}
                    </div>
                </div>
            )}

            {activeTab === "metrics" && (
                <div className="grid-3">
                    {[
                        { title: "ER Precision (Sampled)", value: "98.7%", sub: "Top 5k tracked orgs", sparkData: [94, 95, 95, 96, 96, 97, 97, 98, 98, 98, 99, 99], color: "#34D399" },
                        { title: "Auto-merge Rate", value: "81.4%", sub: "Last 30 days", sparkData: [75, 76, 78, 79, 79, 80, 81, 80, 82, 82, 81, 81], color: "#C9A84C" },
                        { title: "False Merge Est.", value: "0.8%", sub: "From sampled audits", sparkData: [2.1, 1.8, 1.6, 1.4, 1.3, 1.2, 1.1, 1.0, 0.9, 0.9, 0.8, 0.8], color: "#F87171" },
                    ].map((m, i) => (
                        <div key={i} className="card">
                            <div className="stat-label mb-8">{m.title}</div>
                            <div className="stat-value" style={{ color: m.color }}>{m.value}</div>
                            <div style={{ fontSize: 11, color: "var(--text-muted)", marginBottom: 10 }}>{m.sub}</div>
                            <Sparkline data={m.sparkData} color={m.color} height={40} width={200} />
                        </div>
                    ))}
                    <div className="card" style={{ gridColumn: "span 3" }}>
                        <div className="card-header"><div className="card-title">Monthly ER Audit Sampling Results</div></div>
                        <div className="table-wrap">
                            <table className="data-table">
                                <thead><tr><th>Month</th><th>Sampled</th><th>Correct</th><th>Precision</th><th>False Merges</th><th>Silent Errors</th><th>Action Taken</th></tr></thead>
                                <tbody>
                                    {[
                                        { month: "Feb 2026", sampled: 500, correct: 492, prec: "98.4%", fm: 4, se: 4, action: "Tuned domain weight" },
                                        { month: "Jan 2026", sampled: 500, correct: 489, prec: "97.8%", fm: 7, se: 4, action: "Raised HITL threshold" },
                                        { month: "Dec 2025", sampled: 500, correct: 494, prec: "98.8%", fm: 3, se: 3, action: "None" },
                                        { month: "Nov 2025", sampled: 500, correct: 487, prec: "97.4%", fm: 9, se: 4, action: "Retrained name embeddings" },
                                    ].map((r, i) => (
                                        <tr key={i}>
                                            <td>{r.month}</td>
                                            <td className="mono">{r.sampled}</td>
                                            <td className="mono text-green">{r.correct}</td>
                                            <td><span className={`tag ${parseFloat(r.prec) > 98 ? "tag-green" : "tag-amber"}`}>{r.prec}</span></td>
                                            <td className="mono text-red">{r.fm}</td>
                                            <td className="mono text-red">{r.se}</td>
                                            <td className="text-secondary" style={{ fontSize: 11 }}>{r.action}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            )}

            {activeTab === "anchors" && (
                <div className="card">
                    <div className="card-header">
                        <div className="card-title">Deterministic Anchor Registry</div>
                        <span className="tag tag-green">Auto-merge on anchor match</span>
                    </div>
                    <div className="alert alert-success mb-16">
                        <Icon name="check" size={14} /> When two or more anchor fields match exactly, entities are merged automatically without scoring or human review. Anchors are the highest-trust signals.
                    </div>
                    <div className="table-wrap">
                        <table className="data-table">
                            <thead><tr><th>Anchor Type</th><th>Entity Types</th><th>Match Strength</th><th>Enabled</th><th>Matches (30d)</th></tr></thead>
                            <tbody>
                                {[
                                    { anchor: "LEI (Legal Entity Identifier)", types: "Organization", strength: "Exact", enabled: true, matches: 4820 },
                                    { anchor: "SEC CIK Number", types: "Organization, Fund", strength: "Exact", enabled: true, matches: 2140 },
                                    { anchor: "Domain (apex, verified)", types: "Organization", strength: "Exact", enabled: true, matches: 8900 },
                                    { anchor: "EIN / Tax ID", types: "Organization", strength: "Exact", enabled: true, matches: 1240 },
                                    { anchor: "LinkedIn Profile URL", types: "Person", strength: "Exact", enabled: true, matches: 6310 },
                                    { anchor: "SEC Filing Signature Hash", types: "Fund, Deal", strength: "Exact", enabled: true, matches: 840 },
                                    { anchor: "ISIN", types: "Deal", strength: "Exact", enabled: false, matches: 0 },
                                ].map((a, i) => (
                                    <tr key={i}>
                                        <td style={{ fontWeight: 600, color: "var(--text-primary)" }}>{a.anchor}</td>
                                        <td><span className="tag tag-gray">{a.types}</span></td>
                                        <td><span className="tag tag-green">{a.strength}</span></td>
                                        <td><Toggle checked={a.enabled} onChange={() => { }} /></td>
                                        <td className="mono">{a.matches.toLocaleString()}</td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            )}
        </div>
    );
};

export default EntityResolutionPage;
