const ConfidenceRing = ({ value, color = "#C9A84C" }) => {
    const r = 20, circ = 2 * Math.PI * r;
    const offset = circ - (value / 100) * circ;
    return (
        <div className="confidence-ring">
            <svg width="52" height="52">
                <circle cx="26" cy="26" r={r} fill="none" stroke="#21283A" strokeWidth="3" />
                <circle cx="26" cy="26" r={r} fill="none" stroke={color} strokeWidth="3"
                    strokeDasharray={circ} strokeDashoffset={offset}
                    strokeLinecap="round" style={{ transition: "stroke-dashoffset 0.5s ease", transform: "rotate(-90deg)", transformOrigin: "26px 26px" }} />
            </svg>
            <div className="confidence-val">{value}%</div>
        </div>
    );
};

export default ConfidenceRing;
