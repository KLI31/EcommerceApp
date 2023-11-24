import "./styles.css";


const Footer = () => {
    return (
        <footer className="footer">
            <div className="footer-top">
                <span>Síguenos en Instagram: @fifash_trends</span>
            </div>
            <div className="footer-nav">
                <a href="/hombres">HOMBRES</a>
                <a href="/mujeres">MUJERES</a>
                <a href="/sesion">SESIÓN</a>
                <a href="/contactanos">CONTÁCTANOS</a>
                <a href="/faq">FAQ</a>
            </div>
            <div className="footer-bottom">
                <span>© 2023 FIFASH. Todos Los Derechos Reservados</span>
            </div>
        </footer>
    );
};

export default Footer;
