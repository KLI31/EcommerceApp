import { createContext, useState, useContext } from 'react';
import axios from "axios";
import { AuthContext } from './AuthContext';
import SERVICE_PATH from '../utils/networking';
export const WishlistContext = createContext();


export const WishlistProvider = ({ children }) => {
    const [wishlist, setWishlist] = useState([]);
    const { user } = useContext(AuthContext)



    const addToWishList = async (product) => {
        try {
            const response = await axios.post(SERVICE_PATH.addWishList, {
                id_user: user.id,
                id_prenda: product.id
            });

            if (response.status === 201) {
                const newItem = {
                    ...product,
                    id_wishlist: response.data.id_wishlist
                };
                setWishlist([...wishlist, newItem]);
            }
        } catch (error) {
            console.error("Error al añadir a la wishlist: ", error);
        }
    };


    const removeFromWishlist = async (wishlistId) => {
        if (user) {
            try {
                const response = await axios.delete(SERVICE_PATH.removeWishList + wishlistId);
                if (response.status === 200) {
                    setWishlist(wishlist.filter((item) => item.id_wishlist !== wishlistId));
                }
            } catch (error) {
                console.error("Error al eliminar el artículo de la wishlist", error);
            }
        } else {
            console.error("Usuario no autenticado");
        }
    };


    return (
        <WishlistContext.Provider value={{ wishlist, addToWishList, removeFromWishlist }}>
            {children}
        </WishlistContext.Provider>
    )
}