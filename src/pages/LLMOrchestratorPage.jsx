import { useState } from 'react';
import Icon from '../components/Icon';
import Toggle from '../components/Toggle';

const LLMOrchestratorPage = () => {
    const [activeTab, setActiveTab] = useState("routing");
    const tabs = ["routing", "cost", "caching", "models"];

    const models = [
        { name: "claude-sonnet-4", provider: "Anthropic", tier: "Large", tasks: ["ER Adjudication", "Narrative Memos", "Dispute Resolution"], cost: "$3/$15 per MTok", latency: "1.8s avg", active: true, color: "#C9A84C" },
        { name: "gemini-2.0-flash", provider: "Google", tier: "Multimodal", tasks: ["PDF Parsing", "Chart OCR", "Doc Analysis"], cost: "$0.10/$0.40 per MTok", latency: "2.2s avg", active: true, color: "#2DD4BF" },
        { name: "claude-haiku-4", provider: "Anthropic", tier: "Medium", tasks: ["NER", "Taxonomy Tagging", "Short Classification"], cost: "$0.25/$1.25 per MTok", latency: "0.4s avg", active: true, color: "#60A5FA" },
        { name: "llama-3.1-8b-q4", provider: "Self-hosted", tier: "Small", tasks: ["Schema Mapping", "Field Normalization"], cost: "$0.004/MTok", latency: "0.18s avg", active: true, color: "#34D399" },
        { name: "text-embed-3-large", provider: "OpenAI", tier: "Embedding", tasks: ["Entity Embeddings", "Semantic Search", "Dedup"], cost: "$0.13/MTok", latency: "0.09s avg", active: true, color: "#A78BFA" },
    ];

    return (
        <div>
            <div className="section-header">
                <div>
                    <div className="section-title">LLM Orchestrator</div>
                    <div className="section-subtitle">Multi-model routing · Batching · Caching · Cost governance</div>
                </div>
                <div className="flex gap-8 items-center">
                    <span className="tag tag-green">● Orchestrator Live</span>
                    <button className="btn btn-secondary">Budget Policy</button>
                </div>
            </div>

            <div className="tab-bar">
                {tabs.map(t => <div key={t} className={`tab ${activeTab === t ? "active" : ""}`} onClick={() => setActiveTab(t)}>{t.charAt(0).toUpperCase() + t.slice(1)}</div>)}
            </div>

            {activeTab === "routing" && (
                <div className="grid-2">
                    <div className="card">
                        <div className="card-header"><div className="card-title">Task → Model Routing Matrix</div></div>
                        <div className="table-wrap">
                            <table className="data-table">
                                <thead><tr><th>Task Type</th><th>Priority</th><th>Model</th><th>Fallback</th><th>SLA</th></tr></thead>
                                <tbody>
                                    {[
                                        { task: "Schema Mapping", pri: "Low", model: "llama-3.1-8b-q4", fallback: "claude-haiku-4", sla: "5min" },
                                        { task: "NER / Classification", pri: "Med", model: "claude-haiku-4", fallback: "llama-3.1-8b-q4", sla: "30s" },
                                        { task: "Taxonomy Assignment", pri: "Med", model: "claude-haiku-4", fallback: "claude-haiku-4", sla: "30s" },
                                        { task: "ER Adjudication", pri: "High", model: "claude-sonnet-4", fallback: "claude-haiku-4", sla: "2min" },
                                        { task: "PDF / Multimodal Parse", pri: "Med", model: "gemini-2.0-flash", fallback: "claude-sonnet-4", sla: "5min" },
                                        { task: "Narrative Memo Gen", pri: "Low", model: "claude-sonnet-4", fallback: "cached", sla: "10min" },
                                        { task: "Entity Embeddings", pri: "High", model: "text-embed-3-large", fallback: "text-embed-3-small", sla: "5s" },
                                        { task: "Dispute Adjudication", pri: "High", model: "claude-sonnet-4", fallback: "human", sla: "30min" },
                                    ].map((r, i) => (
                                        <tr key={i}>
                                            <td style={{ color: "var(--text-primary)", fontWeight: 500 }}>{r.task}</td>
                                            <td><span className={`tag ${r.pri === "High" ? "tag-red" : r.pri === "Med" ? "tag-amber" : "tag-gray"}`}>{r.pri}</span></td>
                                            <td className="mono" style={{ color: "var(--teal)", fontSize: 11 }}>{r.model}</td>
                                            <td className="mono" style={{ color: "var(--text-muted)", fontSize: 11 }}>{r.fallback}</td>
                                            <td className="mono">{r.sla}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div>
                        <div className="card mb-14">
                            <div className="card-header"><div className="card-title">Degradation Policy</div></div>
                            {[
                                { condition: "Budget hard limit hit", action: "Switch all tasks to cached outputs or smallest model", severity: "critical" },
                                { condition: "Provider API latency >5s", action: "Route to fallback model tier", severity: "warn" },
                                { condition: "Queue depth > 10K", action: "Pause non-priority ingestion jobs", severity: "warn" },
                                { condition: "Provider outage detected", action: "Failover to self-hosted pool + alert on-call", severity: "critical" },
                            ].map((d, i) => (
                                <div key={i} className="control-row">
                                    <div className="control-info">
                                        <div className="control-name" style={{ fontSize: 12 }}>{d.condition}</div>
                                        <div className="control-desc">→ {d.action}</div>
                                    </div>
                                    <span className={`tag ${d.severity === "critical" ? "tag-red" : "tag-amber"}`}>{d.severity}</span>
                                </div>
                            ))}
                        </div>
                        <div className="card">
                            <div className="card-header"><div className="card-title">Real-time Throughput</div></div>
                            <div className="grid-2">
                                {[
                                    { label: "Jobs/min", value: "124", color: "#C9A84C" },
                                    { label: "Avg Latency", value: "1.2s", color: "#2DD4BF" },
                                    { label: "Cache Hit Rate", value: "67%", color: "#34D399" },
                                    { label: "Error Rate", value: "0.08%", color: "#F87171" },
                                ].map((m, i) => (
                                    <div key={i} style={{ textAlign: "center", padding: "10px 0" }}>
                                        <div style={{ fontFamily: "Libre Baskerville", fontSize: 22, fontWeight: 700, color: m.color }}>{m.value}</div>
                                        <div style={{ fontSize: 10, color: "var(--text-muted)", fontFamily: "JetBrains Mono" }}>{m.label}</div>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>
                </div>
            )}

            {activeTab === "models" && (
                <div>
                    {models.map((m, i) => (
                        <div key={i} className="model-card">
                            <div className="model-indicator" style={{ background: m.color, boxShadow: `0 0 8px ${m.color}` }} />
                            <div style={{ flex: 1 }}>
                                <div className="flex items-center gap-8 mb-4">
                                    <span style={{ fontSize: 14, fontWeight: 700, color: "var(--text-primary)", fontFamily: "JetBrains Mono" }}>{m.name}</span>
                                    <span className="tag tag-gray">{m.provider}</span>
                                    <span className="tag tag-blue">{m.tier}</span>
                                    {m.active && <span className="tag tag-green">● Active</span>}
                                </div>
                                <div className="flex gap-6 flex-wrap mb-4">
                                    {m.tasks.map((t, j) => <span key={j} className="tag tag-teal" style={{ fontSize: 9 }}>{t}</span>)}
                                </div>
                                <div className="flex gap-16">
                                    <span style={{ fontSize: 11, color: "var(--text-muted)" }}><span className="mono" style={{ color: "var(--accent)" }}>{m.cost}</span></span>
                                    <span style={{ fontSize: 11, color: "var(--text-muted)" }}>Latency: <span className="mono" style={{ color: "var(--text-secondary)" }}>{m.latency}</span></span>
                                </div>
                            </div>
                            <div className="flex gap-6">
                                <button className="btn btn-ghost" style={{ fontSize: 11 }}>Configure</button>
                                <Toggle checked={m.active} onChange={() => { }} />
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {activeTab === "cost" && (
                <div className="grid-2">
                    <div className="card">
                        <div className="card-header"><div className="card-title">Budget Controls</div></div>
                        <div className="form-group">
                            <label className="form-label">Monthly Budget Limit</label>
                            <input className="form-input" defaultValue="6000" type="number" />
                        </div>
                        <div className="form-group">
                            <label className="form-label">Soft Alert Threshold (%)</label>
                            <input className="form-input" defaultValue="80" type="number" />
                        </div>
                        <div className="form-group">
                            <label className="form-label">Per-customer Daily Quota ($)</label>
                            <input className="form-input" defaultValue="50" type="number" />
                        </div>
                        <div className="divider" />
                        <div className="card-title mb-12">Cost Optimization Policies</div>
                        {[
                            { name: "Cache identical prompts (input hash keyed)", checked: true },
                            { name: "Batch similar tasks for throughput discount", checked: true },
                            { name: "Prefer self-hosted for baseline classification", checked: true },
                            { name: "Downgrade model on non-priority cold jobs", checked: true },
                            { name: "Invalidate cache on source version change", checked: true },
                        ].map((opt, i) => (
                            <div key={i} className="control-row">
                                <div className="control-name" style={{ fontSize: 12 }}>{opt.name}</div>
                                <Toggle checked={opt.checked} onChange={() => { }} />
                            </div>
                        ))}
                    </div>
                    <div className="card">
                        <div className="card-header"><div className="card-title">Cost per Enriched Record (30d trend)</div></div>
                        <svg width="100%" height="130" viewBox="0 0 360 130">
                            {[0, 32, 64, 96, 128].map(y => <line key={y} x1="40" y1={y} x2="360" y2={y} stroke="#21283A" strokeWidth="0.5" />)}
                            <text x="30" y="5" fontSize="8" fill="#4A5568" textAnchor="end" fontFamily="JetBrains Mono">$0.005</text>
                            <text x="30" y="128" fontSize="8" fill="#4A5568" textAnchor="end" fontFamily="JetBrains Mono">$0.001</text>
                            <polyline points="40,100 70,95 100,90 130,88 160,82 190,78 220,70 250,65 280,60 310,55 340,50 360,48"
                                fill="none" stroke="#C9A84C" strokeWidth="2" strokeLinejoin="round" />
                            <polyline points="40,100 70,95 100,90 130,88 160,82 190,78 220,70 250,65 280,60 310,55 340,50 360,48 360,130 40,130"
                                fill="rgba(201,168,76,0.06)" stroke="none" />
                        </svg>
                        <div className="metric-row mt-8"><div className="metric-name">Current avg cost/record</div><div className="metric-val text-accent">$0.0024</div></div>
                        <div className="metric-row"><div className="metric-name">Target (30d)</div><div className="metric-val">$0.0020</div></div>
                        <div className="metric-row"><div className="metric-name">Cache savings this month</div><div className="metric-val text-green">$1,840</div></div>
                        <div className="metric-row"><div className="metric-name">Batch savings this month</div><div className="metric-val text-green">$620</div></div>
                    </div>
                </div>
            )}

            {activeTab === "caching" && (
                <div className="card">
                    <div className="card-header">
                        <div className="card-title">Cache Layer Configuration</div>
                        <span className="tag tag-green">Hit Rate: 67.4%</span>
                    </div>
                    <div className="alert alert-info mb-16">
                        <Icon name="info" size={14} /> Outputs are cached keyed by canonical input hash. Cache is invalidated when source data version changes. Batching + caching are the primary levers for LLM cost reduction.
                    </div>
                    <div className="grid-2">
                        <div>
                            <div className="form-group">
                                <label className="form-label">Cache Backend</label>
                                <select className="form-select"><option>Redis Cluster</option><option>DynamoDB</option></select>
                            </div>
                            <div className="form-group">
                                <label className="form-label">Default TTL (hours)</label>
                                <input className="form-input" defaultValue="168" type="number" />
                            </div>
                            <div className="form-group">
                                <label className="form-label">Invalidation Trigger</label>
                                <select className="form-select">
                                    <option>Source version change</option>
                                    <option>Manual only</option>
                                    <option>TTL only</option>
                                </select>
                            </div>
                        </div>
                        <div>
                            <div className="metric-row"><div className="metric-name">Total Cached Outputs</div><div className="metric-val">2.14M</div></div>
                            <div className="metric-row"><div className="metric-name">Cache Size</div><div className="metric-val">18.4 GB</div></div>
                            <div className="metric-row"><div className="metric-name">Evictions (24h)</div><div className="metric-val">4,220</div></div>
                            <div className="metric-row"><div className="metric-name">Avg TTL remaining</div><div className="metric-val">94h</div></div>
                            <div className="metric-row"><div className="metric-name">Cache hit savings (30d)</div><div className="metric-val text-green">$1,840</div></div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
};

export default LLMOrchestratorPage;
