import './App.css'
import Login from './pages/login/login'
import Register from './pages/register/register'
import Layout from './components/Layout'
import { AuthProvider } from './context/AuthContext'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
function App() {


  return (
    <AuthProvider>
      <Router>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/home" element={<Layout />} />
        </Routes>
      </Router>
    </AuthProvider>
  )
}

export default App
