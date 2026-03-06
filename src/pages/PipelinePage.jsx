import { useState } from 'react';
import Icon from '../components/Icon';
import Toggle from '../components/Toggle';

const PipelinePage = () => {
    const [activeTab, setActiveTab] = useState("sources");
    const tabs = ["sources", "mapping", "stages", "scheduler"];

    const sources = [
        { name: "PitchBook", type: "CSV/API Batch", fresh: "Daily", trust: 95, status: "active", records: "2.1M", lastRun: "2h ago" },
        { name: "SEC EDGAR", type: "Regulatory Filing", fresh: "Real-time", trust: 99, status: "active", records: "840K", lastRun: "12m ago" },
        { name: "Crunchbase", type: "API Dump", fresh: "Weekly", trust: 88, status: "active", records: "1.4M", lastRun: "6h ago" },
        { name: "LinkedIn (PDF)", type: "User Upload", fresh: "On-demand", trust: 70, status: "review", records: "18K", lastRun: "3h ago" },
        { name: "Preqin", type: "CSV Batch", fresh: "Monthly", trust: 90, status: "paused", records: "320K", lastRun: "12d ago" },
        { name: "Firm Websites", type: "Web Crawl", fresh: "Weekly", trust: 60, status: "active", records: "92K", lastRun: "18h ago" },
    ];

    const mappings = [
        { source: "pitchbook.org_name", canonical: "Organization.legal_name", method: "LLM+Exact", conf: 97, status: "approved" },
        { source: "pitchbook.hq_city", canonical: "Organization.HQ", method: "Regex", conf: 99, status: "approved" },
        { source: "crunchbase.funding_total", canonical: "Fund.fund_size", method: "LLM", conf: 84, status: "pending" },
        { source: "edgar.entity_type", canonical: "Organization.investor_type_tags[]", method: "LLM+Taxonomy", conf: 91, status: "approved" },
        { source: "linkedin.current_title", canonical: "Person.roles[]", method: "LLM+NER", conf: 79, status: "review" },
        { source: "pitchbook.aum", canonical: "Organization.AUM_band", method: "LLM+Rule", conf: 88, status: "approved" },
    ];

    return (
        <div>
            <div className="section-header">
                <div>
                    <div className="section-title">Ingestion Pipeline</div>
                    <div className="section-subtitle">8-stage deterministic → LLM → governance workflow</div>
                </div>
                <div className="flex gap-8">
                    <button className="btn btn-secondary"><Icon name="plus" size={12} /> Add Source</button>
                    <button className="btn btn-primary"><Icon name="zap" size={12} /> Run Full Pipeline</button>
                </div>
            </div>

            <div className="tab-bar">
                {tabs.map(t => <div key={t} className={`tab ${activeTab === t ? "active" : ""}`} onClick={() => setActiveTab(t)}>{t.charAt(0).toUpperCase() + t.slice(1)}</div>)}
            </div>

            {activeTab === "sources" && (
                <div>
                    <div className="alert alert-info mb-16">
                        <Icon name="info" size={14} /> <span>Sources are tagged by freshness and trust level. Ingestion priority is assigned automatically based on trust score and schedule. New sources trigger re-scoring across affected canonical records.</span>
                    </div>
                    <div className="card">
                        <div className="table-wrap">
                            <table className="data-table">
                                <thead>
                                    <tr><th>Source Name</th><th>Type</th><th>Freshness</th><th>Trust Score</th><th>Records</th><th>Last Run</th><th>Status</th><th>Actions</th></tr>
                                </thead>
                                <tbody>
                                    {sources.map((s, i) => (
                                        <tr key={i}>
                                            <td style={{ fontWeight: 600, color: "var(--text-primary)" }}>{s.name}</td>
                                            <td><span className="tag tag-gray">{s.type}</span></td>
                                            <td className="mono text-secondary">{s.fresh}</td>
                                            <td>
                                                <div className="flex items-center gap-8">
                                                    <div className="progress-bar" style={{ width: 50 }}>
                                                        <div className="progress-fill" style={{ width: `${s.trust}%`, background: `linear-gradient(90deg, ${s.trust > 90 ? "#0D7B55" : "#8B6F2E"}, ${s.trust > 90 ? "#34D399" : "#C9A84C"})` }} />
                                                    </div>
                                                    <span className="mono" style={{ fontSize: 11 }}>{s.trust}</span>
                                                </div>
                                            </td>
                                            <td className="mono">{s.records}</td>
                                            <td className="mono text-muted">{s.lastRun}</td>
                                            <td><span className={`tag ${s.status === "active" ? "tag-green" : s.status === "review" ? "tag-amber" : "tag-gray"}`}>{s.status}</span></td>
                                            <td>
                                                <div className="flex gap-6">
                                                    <button className="btn btn-ghost" style={{ padding: "2px 8px", fontSize: 11 }}>Run</button>
                                                    <button className="btn btn-ghost" style={{ padding: "2px 8px", fontSize: 11 }}>Config</button>
                                                </div>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            )}

            {activeTab === "mapping" && (
                <div>
                    <div className="alert alert-warn mb-12">
                        <Icon name="alert" size={14} /> <span>3 mappings pending human approval. LLM-suggested mappings are versioned in the schema registry and require reviewer sign-off before production promotion.</span>
                    </div>
                    <div className="card">
                        <div className="card-header">
                            <div className="card-title">Schema Mapping Registry</div>
                            <button className="btn btn-secondary" style={{ fontSize: 11 }}><Icon name="filter" size={11} /> Filter</button>
                        </div>
                        <div className="table-wrap">
                            <table className="data-table">
                                <thead>
                                    <tr><th>Source Field</th><th>→</th><th>Canonical Field</th><th>Method</th><th>Confidence</th><th>Status</th><th>Action</th></tr>
                                </thead>
                                <tbody>
                                    {mappings.map((m, i) => (
                                        <tr key={i}>
                                            <td className="mono" style={{ color: "var(--teal)", fontSize: 11 }}>{m.source}</td>
                                            <td style={{ color: "var(--text-muted)" }}>→</td>
                                            <td className="mono" style={{ color: "var(--accent)", fontSize: 11 }}>{m.canonical}</td>
                                            <td><span className="tag tag-blue">{m.method}</span></td>
                                            <td>
                                                <div className="flex items-center gap-6">
                                                    <div className="progress-bar" style={{ width: 40 }}>
                                                        <div className="progress-fill" style={{ width: `${m.conf}%`, background: `linear-gradient(90deg, ${m.conf > 90 ? "#0D7B55" : m.conf > 80 ? "#8B6F2E" : "#7B1D1D"}, ${m.conf > 90 ? "#34D399" : m.conf > 80 ? "#C9A84C" : "#F87171"})` }} />
                                                    </div>
                                                    <span className="mono" style={{ fontSize: 11 }}>{m.conf}%</span>
                                                </div>
                                            </td>
                                            <td><span className={`tag ${m.status === "approved" ? "tag-green" : m.status === "pending" ? "tag-amber" : "tag-red"}`}>{m.status}</span></td>
                                            <td>
                                                {m.status !== "approved" ? (
                                                    <div className="flex gap-6">
                                                        <button className="btn btn-secondary" style={{ padding: "2px 10px", fontSize: 11, gap: 4 }}><Icon name="check" size={10} color="#34D399" />Approve</button>
                                                        <button className="btn btn-ghost" style={{ padding: "2px 8px", fontSize: 11 }}>Edit</button>
                                                    </div>
                                                ) : <span className="text-muted text-xs mono">v2.1</span>}
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            )}

            {activeTab === "stages" && (
                <div className="grid-2">
                    {[
                        { stage: 1, name: "Raw Landing", icon: "📦", status: "live", desc: "Immutable raw store with content hashes. Every payload stored with source metadata and SHA-256 hash.", metrics: [["Avg file size", "4.2 MB"], ["Dedup rate", "3.1%"], ["Storage (30d)", "842 GB"]] },
                        { stage: 2, name: "Light Validation", icon: "✅", status: "live", desc: "File integrity checks, schema classification, source trust assignment. Zero-byte and malformed files rejected.", metrics: [["Pass rate", "97.8%"], ["Avg latency", "180ms"], ["Reject reasons", "3 types"]] },
                        { stage: 3, name: "Schema Mapping", icon: "🗺️", status: "live", desc: "LLM suggests column→canonical mappings. Human reviewer accepts/rejects. Versioned in mapping registry.", metrics: [["Auto-approve rate", "78%"], ["LLM model", "llama-3.1-8b"], ["Avg review time", "4.2min"]] },
                        { stage: 4, name: "Deterministic Extraction", icon: "⚙️", status: "live", desc: "Regex, CSV parsers, structured API transforms for high-confidence fields. No LLM cost.", metrics: [["Field coverage", "64%"], ["Avg latency", "220ms"], ["Error rate", "0.02%"]] },
                        { stage: 5, name: "Embedding + NER", icon: "🔢", status: "live", desc: "Generate embeddings for names, bios, documents. Run NER to propose entity candidates.", metrics: [["Embed dim", "1536"], ["NER precision", "94.2%"]] },
                        { stage: 6, name: "LLM Enrichment", icon: "🤖", status: "active", desc: "Batched multimodal passes for long bios, PDFs, ambiguous extractions, taxonomy assignment.", metrics: [["Queue depth", "4,220"], ["Batch size", "32"], ["Cost/batch", "$0.042"]] },
                        { stage: 7, name: "ER Adjudication", icon: "🔗", status: "live", desc: "Hybrid adjudication: deterministic anchors → fuzzy scoring → LLM for ambiguous cases.", metrics: [["Auto-merge rate", "81%"], ["HITL rate", "5.2%"], ["False merge est.", "0.8%"]] },
                        { stage: 8, name: "QA & Governance", icon: "🔍", status: "live", desc: "Automated tests: AUM consistency, impossible ticket sizes, vintage/date invariants. Anomalies flagged.", metrics: [["Tests run (daily)", "1,420"], ["Pass rate", "99.1%"], ["Open anomalies", "14"]] },
                    ].map((s) => (
                        <div key={s.stage} className={`card ${s.status === "active" ? "card-accent" : ""}`}>
                            <div className="flex items-center gap-10 mb-12">
                                <div style={{ fontSize: 22 }}>{s.icon}</div>
                                <div>
                                    <div style={{ fontSize: 11, fontFamily: "JetBrains Mono", color: "var(--text-muted)" }}>Stage {s.stage}</div>
                                    <div style={{ fontSize: 14, fontWeight: 700, color: "var(--text-primary)" }}>{s.name}</div>
                                </div>
                                <div style={{ marginLeft: "auto" }}>
                                    <span className={`tag ${s.status === "active" ? "tag-amber" : "tag-green"}`}>{s.status === "active" ? "● Processing" : "● Live"}</span>
                                </div>
                            </div>
                            <div style={{ fontSize: 12, color: "var(--text-muted)", marginBottom: 12, lineHeight: 1.6 }}>{s.desc}</div>
                            <div className="divider" />
                            {s.metrics.map(([k, v], i) => (
                                <div key={i} className="metric-row">
                                    <div className="metric-name">{k}</div>
                                    <div className="metric-val">{v}</div>
                                </div>
                            ))}
                        </div>
                    ))}
                </div>
            )}

            {activeTab === "scheduler" && (
                <div className="grid-2">
                    <div className="card">
                        <div className="card-header"><div className="card-title">Job Scheduler Configuration</div></div>
                        <div className="form-group">
                            <label className="form-label">Hot Tier Max Concurrency</label>
                            <input className="form-input" defaultValue="48" type="number" />
                        </div>
                        <div className="form-group">
                            <label className="form-label">Cold Batch Window</label>
                            <select className="form-select">
                                <option>02:00–06:00 UTC (Off-peak)</option>
                                <option>00:00–04:00 UTC</option>
                                <option>Manual only</option>
                            </select>
                        </div>
                        <div className="form-group">
                            <label className="form-label">LLM Batch Size (records/job)</label>
                            <input className="form-input" defaultValue="32" type="number" />
                        </div>
                        <div className="form-group">
                            <label className="form-label">Backpressure Threshold</label>
                            <input className="form-input" defaultValue="10000" type="number" />
                            <div style={{ fontSize: 11, color: "var(--text-muted)", marginTop: 4 }}>Pause ingestion when Kafka queue depth exceeds this value</div>
                        </div>
                        {[
                            { name: "Re-trigger enrichment on confidence drop", checked: true },
                            { name: "Auto-pause source on >5% error rate", checked: true },
                            { name: "Priority boost for regulatory sources", checked: true },
                            { name: "Email alert on cold batch failure", checked: false },
                        ].map((opt, i) => (
                            <div key={i} className="control-row">
                                <div className="control-info">
                                    <div className="control-name">{opt.name}</div>
                                </div>
                                <Toggle checked={opt.checked} onChange={() => { }} />
                            </div>
                        ))}
                        <button className="btn btn-primary w-full mt-16">Save Scheduler Config</button>
                    </div>
                    <div className="card">
                        <div className="card-header"><div className="card-title">Queue Depth — Last 24h</div></div>
                        <svg width="100%" height="120" viewBox="0 0 400 120">
                            {[0, 30, 60, 90, 120].map(y => <line key={y} x1="0" y1={y} x2="400" y2={y} stroke="#21283A" strokeWidth="0.5" />)}
                            <polyline points="0,80 40,70 80,90 120,110 160,60 200,40 240,80 280,100 320,50 360,30 400,45" fill="none" stroke="#C9A84C" strokeWidth="2" strokeLinejoin="round" />
                            <polyline points="0,80 40,70 80,90 120,110 160,60 200,40 240,80 280,100 320,50 360,30 400,45 400,120 0,120" fill="rgba(201,168,76,0.08)" stroke="none" />
                        </svg>
                        <div className="metric-row mt-8"><div className="metric-name">Current Queue Depth</div><div className="metric-val text-accent">4,220</div></div>
                        <div className="metric-row"><div className="metric-name">Peak (24h)</div><div className="metric-val">11,840</div></div>
                        <div className="metric-row"><div className="metric-name">Avg Processing Rate</div><div className="metric-val">820 rec/min</div></div>
                        <div className="metric-row"><div className="metric-name">Est. Clear Time</div><div className="metric-val text-green">~5.1 hours</div></div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default PipelinePage;
