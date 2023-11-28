import { createContext, useState, useEffect } from "react";

export const AuthContext = createContext();
const URI = 'http://localhost:3001/products/';

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

const addToCart = async (itemId) => { //funcion para poder agregar al carrito enviando como parametro el id del producto y poder reservarlo en el servidor
    await axios.get('http://localhost:3001/products/book/'+ itemId + '?f=book')//se genera una peticion get para poder traer el el producto el cual se va reservar el producto
    .then(({ data }) => {
        data==='Booked' ? setCartItems((prev) => ({...prev, [itemId]: prev[itemId] + 1 })) : void(0);//si el dato extraido es Booked le sumamos 1 a la posicion que represente al producto dentro del arreglo para poder saber la cantidad de cada producto
        data==='Stockout' ? alert('Empty product') : void(0); //en caso de que el estado retornado sea Stockout se crea una alerta que dice que el producto esta vacio y no hace nada
    })
    .catch(error => {
        console.log(error.message);//si hay un error lo muestra por consola
    }) 
};

const getDefaultCart = () => {//se crea un arreglo que se usara para darle una cantidad a cada producto esto, cada posicion del arreglo contendra un cero como cantidad
    let cart = {}
    for(let i = 1; i < 12 ; i++) {
        cart[i] = 0
    }
    return cart;
};