import Icon from '../components/Icon';
import MiniGraph from '../components/MiniGraph';

const GraphPage = () => (
    <div>
        <div className="section-header">
            <div>
                <div className="section-title">Knowledge Graph Explorer</div>
                <div className="section-subtitle">Co-investment networks · Fund lineage · People moves</div>
            </div>
            <div className="flex gap-8">
                <div className="search-bar">
                    <Icon name="search" size={12} color="#4A5568" />
                    <input placeholder="Search entities — org, fund, person, deal..." />
                </div>
                <button className="btn btn-secondary"><Icon name="filter" size={12} /> Filters</button>
                <button className="btn btn-primary"><Icon name="export" size={12} /> Export Graph</button>
            </div>
        </div>
        <div className="grid-3-1" style={{ height: 320 }}>
            <div className="graph-canvas">
                <MiniGraph />
                <div style={{ position: "absolute", bottom: 12, left: 12, display: "flex", gap: 8 }}>
                    {[{ label: "Organization", color: "#C9A84C" }, { label: "Person", color: "#60A5FA" }, { label: "Fund", color: "#2DD4BF" }, { label: "Deal", color: "#A78BFA" }].map((l, i) => (
                        <div key={i} style={{ display: "flex", alignItems: "center", gap: 5, background: "rgba(10,12,16,0.8)", padding: "4px 8px", borderRadius: 4, border: "1px solid var(--border)" }}>
                            <div style={{ width: 8, height: 8, borderRadius: "50%", background: l.color }} />
                            <span style={{ fontSize: 10, color: "var(--text-secondary)", fontFamily: "JetBrains Mono" }}>{l.label}</span>
                        </div>
                    ))}
                </div>
                <div style={{ position: "absolute", top: 12, right: 12, display: "flex", gap: 6 }}>
                    <button className="icon-btn">＋</button>
                    <button className="icon-btn">−</button>
                    <button className="icon-btn"><Icon name="refresh" size={11} /></button>
                </div>
            </div>
            <div className="card" style={{ height: "100%", overflow: "auto" }}>
                <div className="card-title mb-12">Entity Inspector</div>
                <div style={{ background: "var(--surface)", borderRadius: 6, padding: "10px 12px", marginBottom: 10, border: "1px solid var(--accent-dim)" }}>
                    <div style={{ fontSize: 13, fontWeight: 700, color: "var(--accent)", marginBottom: 4 }}>Sequoia Capital</div>
                    <span className="tag tag-amber">Organization</span>
                </div>
                {[
                    { field: "legal_name", value: "Sequoia Capital Operations LLC", conf: 99 },
                    { field: "AUM_band", value: "$85B+", conf: 88 },
                    { field: "HQ", value: "Menlo Park, CA", conf: 97 },
                    { field: "investor_type_tags", value: "VC, PE, Growth", conf: 95 },
                    { field: "jurisdiction", value: "Delaware, USA", conf: 99 },
                ].map((f, i) => (
                    <div key={i} style={{ padding: "6px 0", borderBottom: "1px solid rgba(33,40,58,0.4)" }}>
                        <div className="flex justify-between">
                            <span className="mono" style={{ fontSize: 10, color: "var(--text-muted)" }}>{f.field}</span>
                            <div className="flex items-center gap-4">
                                <div className="progress-bar" style={{ width: 24 }}><div className="progress-fill accent" style={{ width: `${f.conf}%` }} /></div>
                                <span className="mono" style={{ fontSize: 9, color: "var(--text-muted)" }}>{f.conf}%</span>
                            </div>
                        </div>
                        <div style={{ fontSize: 12, color: "var(--text-primary)", marginTop: 2 }}>{f.value}</div>
                    </div>
                ))}
                <button className="btn btn-ghost w-full mt-8" style={{ fontSize: 11 }}>View Full Provenance →</button>
            </div>
        </div>
        <div className="grid-3 mt-16">
            {[
                { title: "Co-investment Network", desc: "1,240 co-investor pairs identified in portfolio", icon: "🕸️", action: "Explore" },
                { title: "Fund Lineage Graph", desc: "Successor fund chains for 4,820 vehicles", icon: "🌳", action: "Explore" },
                { title: "People Moves", desc: "342 executive transitions tracked this quarter", icon: "🏃", action: "Explore" },
            ].map((w, i) => (
                <div key={i} className="card card-teal" style={{ textAlign: "center", cursor: "pointer" }}>
                    <div style={{ fontSize: 28, marginBottom: 10 }}>{w.icon}</div>
                    <div style={{ fontSize: 14, fontWeight: 700, color: "var(--text-primary)", marginBottom: 6 }}>{w.title}</div>
                    <div style={{ fontSize: 12, color: "var(--text-muted)", marginBottom: 12 }}>{w.desc}</div>
                    <button className="btn btn-secondary w-full">{w.action} Network →</button>
                </div>
            ))}
        </div>
    </div>
);

export default GraphPage;
