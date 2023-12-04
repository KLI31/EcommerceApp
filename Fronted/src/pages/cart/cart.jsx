import { useCart } from '../../hooks/useCart';
import './cart.css';

const CartPage = () => {
    const { cart, total, removeFromCart, incrementQuantity, decrementQuantity } = useCart();
    const cartItems = cart.data || [];

    return (
        <div className="cart-container">
            <div className="cart-header">
                <h1>Mi Carrito</h1>
            </div>
            <div className="cart-content">
                {cartItems.length > 0 ? (
                    cartItems.map((item) => (
                        <div className="cart-item" key={item.id_prenda}>
                            <div className="item-image">
                                <img src={item.img1} alt={item.Nombre} />
                            </div>
                            <div className="item-info">
                                <h2>{item.Nombre}</h2>
                                <div className="item-quantity">
                                    <button onClick={() => decrementQuantity(item.id_prenda)}>-</button>
                                    <span>{item.cantidad}</span>
                                    <button onClick={() => incrementQuantity(item.id_prenda)}>+</button>
                                </div>
                                <p className="item-price">${item.Precio}</p>
                            </div>
                            <button className="item-remove" onClick={() => removeFromCart(item.id_prenda)}>X</button>
                        </div>
                    ))
                ) : (
                    <p className="empty-cart">Tu carrito está vacío.</p>
                )}
                <div className="cart-summary">
                    <p className="total-cost">Subtotal: ${total.toFixed(2)}</p>
                    <button className="checkout-btn">Pagar Ahora</button>
                </div>
            </div>
        </div>
    );
};

export default CartPage;
