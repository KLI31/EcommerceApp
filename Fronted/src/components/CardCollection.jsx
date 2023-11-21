import "./styles.css";
import React from 'react';


const CardCollection = ({ Texto, imageUrl, onClick }) => {
    return (
        <div className="CardCollection" onClick={onClick}>
            <div className="card-image-container">
                <img src={imageUrl} alt="Collection" className="card-image" />
            </div>
            <div className="card-content">
                <p className="card-text">{Texto}</p>
            </div>
        </div>
    );
};

export default CardCollection;
