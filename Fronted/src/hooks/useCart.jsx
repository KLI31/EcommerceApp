import { useState, useContext, useEffect, useCallback } from 'react';
import axios from '../utils/axiosConfig';
import { AuthContext } from '../context/AuthContext';

export const useCart = () => {
    const [cart, setCart] = useState([]);
    const [total, setTotal] = useState(0);
    const { user } = useContext(AuthContext);

    const calculateTotal = useCallback(() => {
        if (Array.isArray(cart.data)) {
            const newTotal = cart.data.reduce((acc, item) => acc + (item.cantidad * item.Precio), 0);
            setTotal(newTotal);
        }
    }, [cart]);

    const loadCart = useCallback(async () => {
        if (user?.id) {
            try {
                const response = await axios.get(`http://localhost:3001/api/cart/${user.id}`);
                setCart(response.data);
                calculateTotal();
            } catch (error) {
                console.error('Error al cargar el carrito:', error);
            }
        }
    }, [user, calculateTotal]);

    useEffect(() => {
        loadCart();
    }, [loadCart]);

    const addToCart = async (productId, cantidad = 1) => {
        if (user?.id) {
            try {
                const response = await axios.post('http://localhost:3001/api/cart/', {
                    userId: user.id,
                    productId,
                    cantidad
                });
                console.log('Producto añadido al carrito:', response.data);
                loadCart();
            } catch (error) {
                console.error('Error al añadir al carrito:', error.response?.data || error.message);
            }
        } else {
            console.error('El ID del usuario no está definido o el usuario no está autenticado.');
        }
    };

    const removeFromCart = async (productId) => {
        if (user?.id) {
            try {
                await axios.delete(`http://localhost:3001/api/cart/${user.id}/${productId}`);
                loadCart();
            } catch (error) {
                console.error('Error al eliminar del carrito:', error);
            }
        }
    };



    const incrementQuantity = async (productId) => {
        if (Array.isArray(cart.data)) {
            const productInCart = cart.data.find((item) => item.id_prenda === productId);
            if (productInCart) {
                const newQuantity = productInCart.cantidad + 1;
                try {
                    await axios.put(`http://localhost:3001/api/cart/${user.id}/${productId}`, {
                        cantidad: newQuantity
                    });
                    loadCart();
                } catch (error) {
                    console.error('Error al incrementar la cantidad en el carrito:', error);
                }
            } else {
                console.error('Producto no encontrado en el carrito');
            }
        } else {
            console.error('El carrito no es un array:', cart.data);
        }
    };


    const decrementQuantity = async (productId) => {
        if (Array.isArray(cart.data)) {
            const productInCart = cart.data.find((item) => item.id_prenda === productId);
            if (productInCart) {
                const newQuantity = productInCart.cantidad - 1;
                try {
                    await axios.put(`http://localhost:3001/api/cart/${user.id}/${productId}`, {
                        cantidad: newQuantity
                    });
                    loadCart();
                } catch (error) {
                    console.error('Error al decrementar la cantidad en el carrito:', error);
                }
            } else {
                console.error('Producto no encontrado en el carrito');
            }
        }
    };

    return { cart, total, addToCart, removeFromCart, loadCart, incrementQuantity, decrementQuantity };
};
