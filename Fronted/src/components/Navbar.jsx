import { useContext } from "react";
import { Link } from "react-router-dom";
import { AuthContext } from "../context/AuthContext";
import { OutlineButton } from "./Button";
import { FaRegHeart } from "react-icons/fa";
import { IoCart } from "react-icons/io5";
import { LuShoppingCart } from "react-icons/lu";

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
                        <Link to="/cart"><LuShoppingCart color="#34251F" /></Link>
                        <Link to="/wishlist"><FaRegHeart color="#34251F" /></Link>
                        <div className="user-info">
                            <p>¡Hola, {user.Primer_nombre}!</p>
                            <Link to="/" onClick={logout}><OutlineButton nombre="CERRAR SESIÓN" /></Link>
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