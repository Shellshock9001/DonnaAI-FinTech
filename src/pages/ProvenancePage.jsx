import Icon from '../components/Icon';

const ProvenancePage = () => (
    <div>
        <div className="section-header">
            <div>
                <div className="section-title">Provenance & Audit</div>
                <div className="section-subtitle">Field lineage · Dispute workflows · Evidence modals</div>
            </div>
            <div className="flex gap-8 items-center">
                <span className="tag tag-green">100% Coverage SLO ✓</span>
                <button className="btn btn-secondary"><Icon name="audit" size={12} /> Monthly Report</button>
            </div>
        </div>

        <div className="grid-2 mb-16">
            <div className="card card-accent">
                <div className="card-header"><div className="card-title">Field Provenance Explorer</div></div>
                <div style={{ background: "var(--surface)", border: "1px solid var(--border)", borderRadius: 6, padding: "10px 12px", marginBottom: 14 }}>
                    <div style={{ fontSize: 11, fontFamily: "JetBrains Mono", color: "var(--text-muted)", marginBottom: 4 }}>SELECTED FIELD</div>
                    <div style={{ fontSize: 14, fontWeight: 700, color: "var(--accent)" }}>Organization.AUM_band</div>
                    <div style={{ fontSize: 12, color: "var(--text-primary)", marginTop: 4 }}>$85B+ · Blackstone Inc.</div>
                </div>
                {[
                    { source: "PitchBook (API)", type: "CSV/API Batch", conf: 92, method: "LLM+Rule", date: "2026-03-04", contribution: "Primary", notes: "AUM: $85.6B → band: $85B+" },
                    { source: "SEC EDGAR 13F", type: "Regulatory", conf: 99, method: "Regex", date: "2026-02-28", contribution: "Supporting", notes: "AUM disclosed: $87.2B Q4 2025" },
                    { source: "Preqin", type: "CSV Batch", conf: 78, method: "LLM", date: "2026-01-15", contribution: "Supporting", notes: "Est. AUM $82B (older)" },
                ].map((s, i) => (
                    <div key={i} style={{ border: "1px solid var(--border)", borderRadius: 6, padding: "10px 12px", marginBottom: 8 }}>
                        <div className="flex items-center gap-8 mb-4">
                            <span style={{ fontWeight: 600, fontSize: 12, color: "var(--text-primary)" }}>{s.source}</span>
                            <span className="tag tag-gray" style={{ fontSize: 9 }}>{s.type}</span>
                            <span className={`tag ${s.contribution === "Primary" ? "tag-amber" : "tag-gray"}`} style={{ fontSize: 9 }}>{s.contribution}</span>
                            <span className="mono text-muted" style={{ fontSize: 10, marginLeft: "auto" }}>{s.date}</span>
                        </div>
                        <div className="flex items-center gap-8 mb-4">
                            <span className="tag tag-blue" style={{ fontSize: 9 }}>{s.method}</span>
                            <div className="progress-bar" style={{ width: 60 }}>
                                <div className="progress-fill accent" style={{ width: `${s.conf}%` }} />
                            </div>
                            <span className="mono" style={{ fontSize: 10 }}>{s.conf}%</span>
                        </div>
                        <div style={{ fontSize: 11, color: "var(--text-muted)" }}>{s.notes}</div>
                    </div>
                ))}
                <button className="btn btn-ghost w-full mt-8" style={{ fontSize: 11 }}>View Full Change History →</button>
            </div>

            <div>
                <div className="card mb-14">
                    <div className="card-header">
                        <div className="card-title">Dispute Lifecycle</div>
                        <span className="tag tag-amber">3 open disputes</span>
                    </div>
                    {[
                        { id: "DSP-221", field: "Blackstone.AUM_band", status: "open", raised: "analyst_01", age: "2d", desc: "PitchBook says $85B; Bloomberg terminal shows $92B for same period." },
                        { id: "DSP-220", field: "Accel.HQ", status: "in_review", raised: "customer_02", age: "4d", desc: "HQ listed as Palo Alto; firm self-reports Menlo Park." },
                        { id: "DSP-218", field: "Tiger Fund XII.fund_size", status: "resolved", raised: "system", age: "12d", desc: "SEC filing and vendor data reconciled at $5.8B." },
                    ].map((d, i) => (
                        <div key={i} className={`er-card ${d.status === "open" ? "flagged" : d.status === "in_review" ? "review" : "resolved"} mb-8`}>
                            <div className="flex items-center gap-8 mb-4">
                                <span className="mono" style={{ fontSize: 10, color: "var(--text-muted)" }}>{d.id}</span>
                                <span className={`tag ${d.status === "open" ? "tag-red" : d.status === "in_review" ? "tag-amber" : "tag-green"}`} style={{ fontSize: 9 }}>{d.status}</span>
                                <span style={{ fontSize: 10, color: "var(--text-muted)", marginLeft: "auto" }}>{d.age} · {d.raised}</span>
                            </div>
                            <div style={{ fontSize: 12, fontWeight: 600, color: "var(--accent)", marginBottom: 4, fontFamily: "JetBrains Mono" }}>{d.field}</div>
                            <div style={{ fontSize: 11, color: "var(--text-muted)", marginBottom: 8 }}>{d.desc}</div>
                            {d.status !== "resolved" && (
                                <div className="flex gap-6">
                                    <button className="btn btn-secondary" style={{ fontSize: 10, padding: "2px 10px" }}>Investigate</button>
                                    <button className="btn btn-ghost" style={{ fontSize: 10, padding: "2px 8px" }}>Re-ingest</button>
                                </div>
                            )}
                        </div>
                    ))}
                </div>
                <div className="card">
                    <div className="card-header"><div className="card-title">Dispute Workflow Steps</div></div>
                    {["Flag", "Ticket", "Re-ingest/Re-score", "Human Adjudication", "Record Update", "Audit Log Entry"].map((step, i) => (
                        <div key={i} style={{ display: "flex", alignItems: "center", gap: 10, padding: "7px 0", borderBottom: "1px solid rgba(33,40,58,0.4)" }}>
                            <div style={{ width: 22, height: 22, borderRadius: "50%", background: "rgba(201,168,76,0.1)", border: "1px solid rgba(201,168,76,0.3)", display: "flex", alignItems: "center", justifyContent: "center", fontSize: 10, color: "var(--accent)", fontFamily: "JetBrains Mono", flexShrink: 0 }}>{i + 1}</div>
                            <div style={{ fontSize: 12, color: "var(--text-secondary)" }}>{step}</div>
                            <div style={{ marginLeft: "auto", fontSize: 10, color: "var(--text-muted)", fontFamily: "JetBrains Mono" }}>timestamped</div>
                        </div>
                    ))}
                </div>
            </div>
        </div>
    </div>
);

export default ProvenancePage;
