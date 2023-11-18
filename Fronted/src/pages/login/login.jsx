import "./login.css"
import Button from "../../components/Button"
import { PasswordInput, Input } from "../../components/Input"

const login = () => {
    return (
        <section className="pantalla-dividida">
            <div className="izquierda" />
            <div className="derecha">
                <div className="container">
                    <h1 className="title-login">Iniciar Sesion</h1>
                    <Input label="Correo" placeholder="Ingrese su correo electronico" type="email" value="lrambao5432@gmail.com" size={40} />
                    <PasswordInput label="Contraseña" placeholder="Ingrese su contraseña" value="tU MADRE SI VES ESTA C" />
                </div>

                <div className="button-container">
                    <Button nombre="Iniciar Sesion" borderRadius />
                    <p>No tienes cuenta <span>Registrate aqui</span></p>
                </div>
            </div>
        </section>
    )
}

export default login