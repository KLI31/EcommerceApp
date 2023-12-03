
import { useLocation, Routes, Route } from 'react-router-dom';
import Navbar from './Navbar';
import Home from "../pages/home/home";
import Wishlist from "../pages/wishlist/wishlist"
const Layout = () => {
    const location = useLocation();

    return (
        <>
            {location.pathname !== '/login' && location.pathname !== '/register' && <Navbar backgroundColor="#EEDDCC" />}
            <div>
                <Routes>
                    <Route path="/" element={<Home />} />
                    <Route path="/wishlist" element={<Wishlist />} />
                </Routes>
            </div>
        </>
    );
};

export default Layout;