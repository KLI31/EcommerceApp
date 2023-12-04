import "./login.css";
import { useContext, useState } from "react";
import { Button } from "../../components/Button";
import { PasswordInput, Input } from "../../components/Input";
import { useNavigate } from "react-router-dom";
import { Link } from "react-router-dom";
import { AuthContext } from '../../context/AuthContext';
import axios from 'axios';
import SERVICE_PATH from "../../utils/networking";


const login = () => {
    const [form, setForm] = useState({
        Correo_Electronico: "",
        Contraseña: "",
    });

    const { login } = useContext(AuthContext);
    const navigate = useNavigate();



    const handleSubmit = async (e) => {
        e.preventDefault()

        try {
            // Aquí, reemplaza 'tuAPI' con la URL de tu backend
            const response = await axios.post(SERVICE_PATH.login, { Correo_Electronico: Correo_Electronico, Contraseña: Contraseña });
            if (response.status === 200) {
                login(response.data.userData, response.data.token, navigate);

            } else {
                console.error('Error en el inicio de sesión');
            }
        } catch (error) {
            console.error('Error en el inicio de sesión:', error);
        }
    }




    const handleChange = (e) => {
        setForm({
            ...form,
            [e.target.name]: e.target.value,
        });
    };

    const { Correo_Electronico, Contraseña } = form;

    return (
        <section className="pantalla-dividida">
            <div className="izquierda" />
            <div className="derecha">
                <div className="container">
                    <h1 className="title-login">Iniciar Sesión</h1>
                    <form onSubmit={handleSubmit}>
                        <Input
                            label="Correo"
                            name="Correo_Electronico"
                            placeholder="Ingrese su correo electronico"
                            type="email"
                            value={Correo_Electronico}
                            onChange={handleChange}
                            size={40}
                        />
                        <PasswordInput
                            name="Contraseña"
                            label="Contraseña"
                            placeholder="Ingrese su contraseña"
                            value={Contraseña}
                            onChange={handleChange}
                        />
                        <div className="button-container">
                            <Button nombre="Iniciar Sesion" borderRadius type="submit" />
                            <p>
                                ¿No tienes cuenta?
                                <Link className="text2" to="/register">
                                    <span>Regístrate aqui</span>
                                </Link>
                            </p>
                        </div>
                    </form>
                </div>

            </div>
        </section>
    );
};

export default login;
