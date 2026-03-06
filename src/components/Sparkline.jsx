const Sparkline = ({ data, color = "#C9A84C", height = 32, width = 80 }) => {
    const max = Math.max(...data);
    const min = Math.min(...data);
    const range = max - min || 1;
    const pts = data.map((v, i) => {
        const x = (i / (data.length - 1)) * width;
        const y = height - ((v - min) / range) * height * 0.8 - height * 0.1;
        return `${x},${y}`;
    }).join(" ");
    return (
        <svg width={width} height={height} className="sparkline">
            <polyline points={pts} fill="none" stroke={color} strokeWidth="1.5" strokeLinejoin="round" className="spark-path" />
            <polyline points={`0,${height} ${pts} ${width},${height}`} fill={`${color}15`} stroke="none" />
        </svg>
    );
};

export default Sparkline;
