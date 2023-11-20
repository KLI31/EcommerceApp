import { createContext, useState, useEffect } from "react";

export const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
    const [user, setUser] = useState(null);

    useEffect(() => {
        const storedToken = localStorage.getItem("token");
        if (storedToken) {
            setUser({ token: storedToken });
        }
    }, []);

    const login = (userData, token, navigate) => {
        localStorage.setItem("token", token);
        setUser({ ...userData, token });
        navigate("/home");
    };

    const logout = (navigate) => {
        localStorage.removeItem("token");
        setUser(null);
        navigate("/login");
    };

    return (
        <AuthContext.Provider value={{ user, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};