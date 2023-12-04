import { useContext } from 'react';
import { WishlistContext } from '../../context/WishlistContext';
import './wishlist.css';

const WishlistPage = () => {
    const { wishlist, removeFromWishlist } = useContext(WishlistContext);

    return (
        <div className="wishlist-page">
            <h1 className="wishlist-title">Wishlist</h1>
            <div className="wishlist-items">
                {wishlist.map((item, index) => (
                    <div className="wishlist-item" key={index}>
                        <img src={item.img1} alt={item.Nombre} width="50px" height="300" />
                        <div className="item-details">
                            <h2>{item.Nombre}</h2>
                            <p>{item.Precio}</p>
                        </div>
                        <button onClick={() => removeFromWishlist(item.id_wishlist)}>
                            X
                        </button>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default WishlistPage;
