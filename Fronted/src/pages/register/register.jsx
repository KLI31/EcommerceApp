import { Input, PasswordInput } from "../../components/Input"
import Button from "../../components/Button"
import "./register.css"
import { useState } from "react"
import axios from "axios"

const register = () => {
    const [form, setForm] = useState({
        Primer_nombre: "",
        Primer_Apellido: "",
        Correo_Electronico: "",
        Contraseña: "",
    })

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await axios.post('http://localhost:3001/api/register', form);
            console.log(response.data); // Maneja la respuesta, como mostrar un mensaje de éxito
        } catch (error) {
            console.error('Error en el registro:', error);
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
                            <p>Tienes cuenta? <span>Inicia Sesion aqui</span></p>
                        </div>
                    </form>
                </div>


            </div>
        </section>
    )
}

export default register