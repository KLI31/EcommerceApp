import { useCart } from '../../hooks/useCart'; // Asegúrate de que la ruta al hook es correcta

const CartPage = () => {
    const { cart, total, removeFromCart, incrementQuantity, decrementQuantity } = useCart();
    const cartItems = cart.data || [];

    return (
        <div>
            <h1>Carrito de Compras</h1>
            <div>
                {cartItems.length > 0 ? (
                    cartItems.map((item) => (
                        <div key={item.id_prenda}>
                            <h3>{item.Nombre}</h3>
                            <img src={item.img1} alt={item.Nombre} />
                            <p>Cantidad: {item.cantidad}</p>
                            <p>Precio unitario: ${item.Precio}</p>
                            <button onClick={() => incrementQuantity(item.id_prenda)}>+</button>
                            <button onClick={() => decrementQuantity(item.id_prenda)}>-</button>
                            <p>Subtotal: ${(item.cantidad * item.Precio).toFixed(2)}</p>
                            <button onClick={() => removeFromCart(item.id_prenda)}>Eliminar</button>
                        </div>
                    ))
                ) : (
                    <p>Tu carrito está vacío.</p>
                )}
            </div>
            <h2>Total: ${total.toFixed(2)}</h2>
        </div>
    );
};

export default CartPage;