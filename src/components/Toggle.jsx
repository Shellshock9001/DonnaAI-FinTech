const Toggle = ({ checked, onChange }) => (
    <label className="toggle">
        <input type="checkbox" checked={checked} onChange={e => onChange(e.target.checked)} />
        <span className="toggle-slider" />
    </label>
);

export default Toggle;
