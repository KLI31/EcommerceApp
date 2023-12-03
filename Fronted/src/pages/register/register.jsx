import { Input, PasswordInput } from "../../components/Input"
import { Button } from "../../components/Button"
import "./register.css"
import { useState } from "react"
import axios from "axios"
import { toast, Toaster } from 'react-hot-toast';
import { Link } from "react-router-dom"


const register = () => {
    const [form, setForm] = useState({
        Primer_nombre: "",
        Primer_Apellido: "",
        Correo_Electronico: "",
        Contraseña: "",
    })

    const toastSuccess = () => toast.success('Registro exitoso', {
        position: "top-right",
        duration: 3000,
        style: {
            fontSize: '20px',
            fontFamily: "Poppins"
        }
    });

    const toastError = (errorMessage) => toast.error(errorMessage, {
        position: "top-left",
        duration: 3000,
        style: {
            fontSize: '20px',
            fontFamily: "Poppins"
        }
    });

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post('http://localhost:3001/api/register', form);
            if (response.status === 201) {
                toastSuccess()
            }
        } catch (error) {
            let messageError = "No se pudo realizar el registro, intente nuevamente";
            if (error.response && error.response.data) {
                messageError = error.response.data.message || messageError;
            }
            toastError(messageError)
        }
    };

    const handleChange = (e) => {
        setForm({
            ...form,
            [e.target.name]: e.target.value
        });
    }

    const { Primer_nombre, Primer_Apellido, Correo_Electronico, Contraseña } = form

    return (
        <section className="pantalla-dividida">
            <Toaster />
            <div className="izquierda" />
            <div className="derecha">
                <div className="container">
                    <h1 className="title-login">Registrate</h1>
                    <form onSubmit={handleSubmit}>
                        <Input name="Primer_nombre" label="Nombre" placeholder="Ingrese su nombre" type="text" value={Primer_nombre} size={40} onChange={handleChange} />
                        <Input name="Primer_Apellido" label="Apellido" placeholder="Ingrese su Apellido" type="text" value={Primer_Apellido} size={40} onChange={handleChange} />
                        <Input name="Correo_Electronico" label="Correo" placeholder="Ingrese su correo electronico" type="email" value={Correo_Electronico} size={40} onChange={handleChange} />
                        <PasswordInput name="Contraseña" label="Contraseña" placeholder="Ingrese su contraseña" value={Contraseña} onChange={handleChange} />

                        <div className="button-container">
                            <Button nombre="Registrarme" borderRadius />
                            <p>Tienes cuenta? <Link className="text2" to="/login"><span>Inicia Sesion aqui</span></Link></p>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    )
}

export default register