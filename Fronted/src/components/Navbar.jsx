import { useContext } from "react";
import { Link } from "react-router-dom";
import { AuthContext } from "../context/AuthContext";
import { OutlineButton } from "./Button";
import { FiHeart } from "react-icons/fi";
import { IoCart } from "react-icons/io5";

const Navbar = ({ backgroundColor }) => {
    const { user, logout } = useContext(AuthContext);

    return (
        <nav className="navbar" style={{ backgroundColor: backgroundColor }}>
            <div className="logo">
                <h2>FIFASH</h2>
            </div>
            <div className="links">
                <ul>
                    <li><Link to="/nuevo" className="my-link">NUEVO</Link></li>
                    <li><Link to="/ropa" className="my-link">ROPA</Link></li>
                    <li><Link to="/estilos" className="my-link">ESTILOS</Link></li>
                    <li><Link to="/contacto" className="my-link">CONTACTO</Link></li>
                </ul>
            </div>
            <div className="navbar-section">
                {user ? (
                    <>
                        <Link to="/cart"><IoCart /></Link>
                        <Link to="/wishlist"><FiHeart /></Link>
                        <div className="user-info">
                            <p>Inicio de sesión: {user.Primer_nombre} {user.Primer_Apellido}</p>
                            <Link to="/home" onClick={logout}><OutlineButton nombre="CERRAR SESIÓN" /></Link>
                        </div>
                    </>
                ) : (
                    <Link to="/login"><OutlineButton nombre="INICIAR SESIÓN" /></Link>
                )}
            </div>
        </nav>
    );
};

export default Navbar;