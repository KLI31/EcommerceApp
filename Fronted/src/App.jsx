import './App.css'
import Login from './pages/login/login'
import Register from './pages/register/register'
import Layout from './components/Layout'
import { AuthProvider } from './context/AuthContext'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import { WishlistProvider } from './context/WishlistContext'
import Wishlist from './pages/wishlist/wishlist'
import Cart from './pages/cart/cart'


function App() {


  return (
    <Router>
      <AuthProvider>
        <WishlistProvider>
          <Routes>
            <Route path="/" element={<Layout />} />
            <Route path="/register" element={<Register />} />
            <Route path="/login" element={<Login />} />
            <Route path="/wishlist" element={<Wishlist />} />
            <Route path="/cart" element={<Cart />} />
          </Routes>
        </WishlistProvider>
      </AuthProvider>
    </Router>
  )
}

export default App
