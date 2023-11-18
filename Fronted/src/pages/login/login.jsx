import "./login.css"
import Button from "../../components/Button"

const login = () => {
    return (
        <section className="pantalla-dividida">
            <div className="izquierda"></div>
            <div className="derecha">
                <div className="container">
                    <h1 className="title-login">Iniciar Sesion</h1>
                    <div className="forms-container">
                        <label htmlFor="">Correo Electronico</label>
                        <input type="text" name="" id="" placeholder="Ingrese su correo" size={50} />
                    </div>
                    <div className="forms-container">
                        <label htmlFor="">Contraseña</label>
                        <input type="text" name="" id="" placeholder="Ingrese su contraseña" />
                    </div>
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