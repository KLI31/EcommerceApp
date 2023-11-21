import "./styles.css";

const Footer = () => {
    return (
        <footer className="footer">
            <div className="footer-top">
                <span>Síguenos En Instagram: @Fifash_Trends</span>
            </div>
            <div className="footer-nav">
                <a href="/hombres">HOMBRES</a>
                <a href="/mujeres">MUJERES</a>
                <a href="/sesion">SESIÓN</a>
                <a href="/contactanos">CONTÁCTANOS</a>
                <a href="/faq">FAQ</a>
            </div>
            <div className="footer-bottom">
                <span>© 2023 FIFAH. Todos Los Derechos Reservados</span>
            </div>
        </footer>
    );
};

export default Footer;
