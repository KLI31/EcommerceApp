import { FiHeart } from "react-icons/fi"
import { useContext } from "react";
import { IoCartOutline } from "react-icons/io5";
import { AuthContext } from "../../context/AuthContext"
import { WishlistContext } from '../../context/WishlistContext';
import { useCart } from "../../hooks/useCart";


export const Product = (props) => {
    const { id, Nombre, Precio, Descripcion, img1, img2, img3 } = props.data;
    const { user } = useContext(AuthContext)
    const { addToWishList } = useContext(WishlistContext)
    const { addToCart } = useCart()



    const handleAddToWishlist = () => {
        if (user) {
            addToWishList({ Nombre, Precio, Descripcion, img1, img2, img3 });
        } else {
            console.error("Usuario no autenticado");
        }
    };

    const handleAddToCart = () => {
        if (user?.id && props.data?.id_prenda) { // Cambiado de id a id_prenda
            addToCart(props.data.id_prenda, 1); // Asumiendo que la cantidad es 1
        } else {
            console.error("Usuario no autenticado o ID del producto no definido", user);
        }
    };


    return (
        <div className="product">
            <div className="product-content">
                <div className="slide-var">
                    <ul>
                        <li><img src={img1} alt={Nombre} /></li>
                        <li><img src={img2} alt={Nombre} /></li>
                        <li><img src={img3} alt={Nombre} /></li>
                    </ul>
                </div>
                <div className="descripcion">
                    <p>{Descripcion}</p>
                    <p>{id}</p>
                </div>
                <div className="description">
                    <p>
                        <b>{Nombre}</b>
                    </p>
                    <p> ${Precio}</p>
                </div>
            </div>
            {user && (
                <div className="icon-container">
                    <IoCartOutline className="cart-icon" onClick={handleAddToCart} />
                    <FiHeart className="heart-icon" onClick={handleAddToWishlist} />
                </div>
            )}
        </div>
    );
};