
import { useLocation, Routes, Route } from 'react-router-dom';
import Navbar from './Navbar';
import Home from "../pages/home/home";

const Layout = () => {
    const location = useLocation();

    return (
        <>
            {location.pathname !== '/login' && location.pathname !== '/register' && <Navbar />}
            <div>
                <Routes>
                    <Route path="/" element={<Home />} />
                </Routes>
            </div>
        </>
    );
};

export default Layout;