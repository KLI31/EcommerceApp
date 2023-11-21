import { useContext } from "react"
import { Link } from "react-router-dom"
import { AuthContext } from "../context/AuthContext"
import { OutlineButton } from "./Button"

const Navbar = () => {

    const { user, logout } = useContext(AuthContext)


    return (
        <div className="navbar">
            <div className="logo">
                <h2>FIFASH</h2>
            </div>
            <div className="links">
                <ul>
                    <li>
                        <Link className="my-link">Nuevo</Link>
                    </li>
                    <li>
                        <Link className="my-link">Ropa</Link>
                    </li>
                    <li>
                        <Link className="my-link">Estilos</Link>
                    </li>
                    <li>
                        <Link className="my-link">Contacto</Link>
                    </li>
                </ul>
            </div>
            <div className="navbar-section">
                {user ? (
                    <ul>
                        <div>
                            <h4>{user.Primer_nombre}</h4>
                            <h4>{user.Primer_Apellido}</h4>
                        </div>
                        <li>
                            <Link to="/home" onClick={() => logout()}>Cerrar Sesion</Link>
                        </li>
                    </ul>
                ) : (
                    <ul>
                        <li>
                            <Link to="/login">
                                <OutlineButton nombre="Iniciar Sesion" />
                            </Link>
                        </li>
                    </ul>
                )}
            </div>
        </div >
    )
}

export default Navbar