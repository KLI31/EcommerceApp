import { useContext } from "react"
import { Link } from "react-router-dom"
import { AuthContext } from "../context/AuthContext"
import { OutlineButton } from "./Button"

const Navbar = ({ backgroundColor }) => {

    const { user, logout } = useContext(AuthContext)


    return (
        <div className="navbar" style={{ backgroundColor: backgroundColor }}>
            <div className="logo">
                <h2>FIFASH</h2>
            </div>
            <div className="links">
                <ul>
                    <li>
                        <Link className="my-link">NUEVO</Link>
                    </li>
                    <li>
                        <Link className="my-link">ROPA</Link>
                    </li>
                    <li>
                        <Link className="my-link">ESTILOS</Link>
                    </li>
                    <li>
                        <Link className="my-link">CONTACTO</Link>
                    </li>
                </ul>
            </div>
            <div className="navbar-section">
                {user ? (
                    <ul>
                        <div className="user-info">
                            <h4>Inicio de sesion:</h4>
                            <h4>{user.Primer_nombre}</h4>
                            <h4>{user.Primer_Apellido}</h4>
                        </div>
                        <li>
                            <Link to="/home">
                                <OutlineButton nombre="CERRAR SESIÓN" onClick={logout} />
                            </Link>
                        </li>
                    </ul>
                ) : (
                    <ul>
                        <li>
                            <Link to="/login">
                                <OutlineButton nombre="INICIAR SESIÓN" />
                            </Link>
                        </li>
                    </ul>
                )}
            </div>
        </div >
    )
}

export default Navbar