import React from 'react';

const Home = () => {
    return (
        <div>
            Estoy en el home principal
            <section className="fashion-section">
                <div className="fashion-image-container">
                    {  <image src="https://i.pinimg.com/736x/a0/0d/8a/a00d8a8f55adab14c565750d655d4af7.jpg" alt="Fashion" />}
                    <img src="path_to_your_image.jpg" alt="Fashion" />
                </div>
                
                <div className="fashion-content">
                    <h2>Mejor Moda Desde 2014</h2>
                    <p>Desde 2014, nuestra moda redefine tendencias con calidad y diseño vanguardista. Cada pieza refleja nuestro compromiso con la innovación y el estilo, convirtiéndonos en un referente para los amantes de la moda.</p>
                    <div className="fashion-stats">
                        <div className="stat">
                            <h3>2014</h3>
                            <p>Fifash Fundado</p>
                        </div>
                        <div className="stat">
                            <h3>8900+</h3>
                            <p>Productos Vendidos</p>
                        </div>
                        <div className="stat">
                            <h3>3105+</h3>
                            <p>Buenas Reseñas</p>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    );
};

export default Home;

