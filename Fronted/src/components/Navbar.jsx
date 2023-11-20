import { useContext } from "react"
import { Link } from "react-router-dom"
import { AuthContext } from "../context/AuthContext"


const Navbar = () => {

    const { user, logout } = useContext(AuthContext)


    return (
        <nav>
            <div className="logo">
                <h2>Logo</h2>
            </div>
            <ul className="links">
                <li>
                    <Link to="/home">Home</Link>
                </li>
                <li>
                    <Link to="/profile">Profile</Link>
                </li>
                {user ? (
                    <li>
                        <button onClick={logout}>Logout</button>
                    </li>
                ) : (
                    <>
                        <li>
                            <Link to="/login">Login</Link>
                        </li>
                        <li>
                            <Link to="/register">Register</Link>
                        </li>
                    </>
                )}
            </ul>
        </nav>
    )
}

export default Navbar