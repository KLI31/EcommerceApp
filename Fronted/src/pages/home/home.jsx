import "./home.css"
import image from "../../assets/Fashion.png";
import Footer from "../../components/Footer";
import { Swiper, SwiperSlide } from 'swiper/react'
import { FreeMode, Pagination } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/free-mode';
import 'swiper/css/pagination';
import { Button } from "../../components/Button"

const Home = () => {
    window.scrollTo(0, 0);

    return (
        <main>
            {/*HERO*/}
            <div>
                <section className="hero-section">
                    <div className="hero-container">
                        <div className="hero-content">
                            <h1>Encuentra El Mejor Estilo De Moda</h1>
                            <p>Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit. Sed Ullamcorper Congue Eros, Eget Tincidunt Ipsum Eleifend Ut.</p>
                            <Button nombre="comprar" />
                        </div>
                        <div className="image-content">
                            <img src={image} alt="imagen_prueba" />
                        </div>
                    </div>
                </section>
            </div>

            {/*ABOUT US*/}
            <div>
                <section className="fashion-section">
                    <div className="fashion-image-container">
                        <img src={image} alt="Fashion" />
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

            {/*REVIEWS*/}
            <div>
                <section className="review-section">
                    <div className="review-header">
                        <h2>Qué dice la gente de nosotros</h2>
                        <p>¡Nuestros productos llegan a las mejores personas! Esto es lo que dicen de nosotros.</p>
                    </div>

                    <Swiper
                        slidesPerView={2}
                        spaceBetween={30}
                        freeMode={true}
                        pagination={{
                            clickable: true,
                        }}
                        modules={[FreeMode, Pagination]}
                        className="review-slider"
                    >
                        <SwiperSlide className="review-card">
                            <h3>¡Cómodo y cumplió con todas mis expectativas!</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lacus, auctor pretium ac ultrices. Dui lacus dignissim tincidunt urna, at enim tempo. Pellentesque amet Lorem ipsum dolor sit amet. </p>
                            <div className="image-container">
                                <img src={image} alt="Fashion" />
                            </div>
                            <p><strong>Anisa Zahra</strong></p>
                            <p>Founder Milenial</p>
                        </SwiperSlide>

                        <SwiperSlide className="review-card">
                            <h3>¡Cómodo y cumplió con todas mis expectativas!</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lacus, auctor pretium ac ultrices. Dui lacus dignissim tincidunt urna, at enim tempo. Pellentesque amet Lorem ipsum dolor sit amet. </p>
                            <div className="image-container">
                                <img src={image} alt="Fashion" />
                            </div>
                            <p><strong>Anisa Zahra</strong></p>
                            <p>Founder Milenial</p>
                        </SwiperSlide>

                        <SwiperSlide className="review-card">
                            <h3>¡Cómodo y cumplió con todas mis expectativas!</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lacus, auctor pretium ac ultrices. Dui lacus dignissim tincidunt urna, at enim tempo. Pellentesque amet Lorem ipsum dolor sit amet. </p>
                            <div className="image-container">
                                <img src={image} alt="Fashion" />
                            </div>
                            <p><strong>Anisa Zahra</strong></p>
                            <p>Founder Milenial</p>
                        </SwiperSlide>

                        <SwiperSlide className="review-card">
                            <h3>¡Cómodo y cumplió con todas mis expectativas!</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lacus, auctor pretium ac ultrices. Dui lacus dignissim tincidunt urna, at enim tempo. Pellentesque amet Lorem ipsum dolor sit amet. </p>
                            <div className="image-container">
                                <img src={image} alt="Fashion" />
                            </div>
                            <p><strong>Anisa Zahra</strong></p>
                            <p>Founder Milenial</p>
                        </SwiperSlide>

                        <SwiperSlide className="review-card">
                            <h3>¡Cómodo y cumplió con todas mis expectativas!</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lacus, auctor pretium ac ultrices. Dui lacus dignissim tincidunt urna, at enim tempo. Pellentesque amet Lorem ipsum dolor sit amet. </p>
                            <div className="image-container">
                                <img src={image} alt="Fashion" />
                            </div>
                            <p><strong>Anisa Zahra</strong></p>
                            <p>Founder Milenial</p>
                        </SwiperSlide>

                        <SwiperSlide className="review-card">
                            <h3>¡Cómodo y cumplió con todas mis expectativas!</h3>
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut lacus, auctor pretium ac ultrices. Dui lacus dignissim tincidunt urna, at enim tempo. Pellentesque amet Lorem ipsum dolor sit amet. </p>
                            <div className="image-container">
                                <img src={image} alt="Fashion" />
                            </div>
                            <p><strong>Anisa Zahra</strong></p>
                            <p>Founder Milenial</p>
                        </SwiperSlide>
                    </Swiper>
                </section>

            </div>
            <footer>
                <Footer />
            </footer>
        </main>
    );
}

export default Home;