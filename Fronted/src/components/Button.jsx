import "./styles.css";


const BorderRadus = {
    sm: "2px",
    xl: "7px",
};

const Button = ({ nombre, onClick, errorButton, borderRadius, type }) => {
    const stylesProps = {
        borderRadius: borderRadius ? BorderRadus.xl : BorderRadus.sm,
    };

    return (
        <button onClick={onClick} style={stylesProps} className={`button ${errorButton ? "errorButton" : "successButton"}`} type={type}>
            {nombre}
        </button>
    );
};


export default Button