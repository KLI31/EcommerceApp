import React from "react";

export const Product = (props) => {
    const { Nombre, Precio, Descripcion, img1, img2, img3 } = props.data; //se le da valor a las variables en funcion de lo que se saca de la base de datos
    return (
        <div className="product"> {/*aqui se muestran las informaciones de los productos en la pagina principal */}
            <div className="slide-var">
                <ul>
                    <li><img src={img1} alt={Nombre}/></li>{/*este es el carrusel para las imagenes */}
                    <li><img src={img2} alt={Nombre}/></li>
                    <li><img src={img3} alt={Nombre}/></li>
                </ul>
            </div>
            <div className="descripcion">
                <p>{Descripcion}</p>
            </div>
            <div className="description"> 
                <p> 
                    <b>{Nombre}</b> 
                </p>
                <p> ${Precio}</p>
            </div>
        </div> 
    );
};