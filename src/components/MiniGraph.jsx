const MiniGraph = () => {
    const nodes = [
        { id: 0, x: 160, y: 140, label: "Sequoia Capital", type: "org", color: "#C9A84C" },
        { id: 1, x: 280, y: 80, label: "Doug Leone", type: "person", color: "#60A5FA" },
        { id: 2, x: 300, y: 200, label: "SC Fund XIV", type: "fund", color: "#2DD4BF" },
        { id: 3, x: 80, y: 80, label: "Stripe", type: "deal", color: "#A78BFA" },
        { id: 4, x: 70, y: 200, label: "OpenAI", type: "deal", color: "#A78BFA" },
        { id: 5, x: 420, y: 140, label: "Andreessen", type: "org", color: "#C9A84C" },
        { id: 6, x: 380, y: 260, label: "a16z Fund IX", type: "fund", color: "#2DD4BF" },
    ];
    const edges = [[0, 1], [0, 2], [0, 3], [0, 4], [1, 2], [5, 6], [2, 6], [3, 5]];
    return (
        <svg width="100%" height="100%" viewBox="0 0 500 320" style={{ position: 'absolute', inset: 0 }}>
            <defs>
                <radialGradient id="glow" cx="50%" cy="50%" r="50%">
                    <stop offset="0%" stopColor="#C9A84C" stopOpacity="0.15" />
                    <stop offset="100%" stopColor="#C9A84C" stopOpacity="0" />
                </radialGradient>
            </defs>
            {edges.map(([a, b], i) => (
                <line key={i} x1={nodes[a].x} y1={nodes[a].y} x2={nodes[b].x} y2={nodes[b].y}
                    stroke="#21283A" strokeWidth="1.5" strokeDasharray="4,4" />
            ))}
            {nodes.map(n => (
                <g key={n.id}>
                    <circle cx={n.x} cy={n.y} r="18" fill={`${n.color}15`} stroke={n.color} strokeWidth="1.5" />
                    <circle cx={n.x} cy={n.y} r="6" fill={n.color} />
                    <text x={n.x} y={n.y + 30} textAnchor="middle" fontSize="9" fill="#8892A4" fontFamily="JetBrains Mono">{n.label}</text>
                </g>
            ))}
        </svg>
    );
};

export default MiniGraph;
