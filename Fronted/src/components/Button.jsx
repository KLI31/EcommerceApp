import "./styles.css";

const COLORS = {
    errorButton: "red",
    SuccessButton: "#4B3C35",
};

const BorderRadus = {
    sm: "2px",
    xl: "7px",
};

const Button = ({ nombre, onClick, errorButton, borderRadius }) => {
    const stylesProps = {
        backgroundColor: errorButton ? COLORS.errorButton : COLORS.SuccessButton,
        borderRadius: borderRadius ? BorderRadus.xl : BorderRadus.sm,
    };

    return (
        <button onClick={onClick} style={stylesProps} className="button">
            {nombre}
        </button>
    );
};


export default Button