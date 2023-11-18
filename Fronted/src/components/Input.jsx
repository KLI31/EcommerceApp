import { LuEye } from "react-icons/lu";
import { useState } from "react";
import { AiOutlineEyeInvisible } from "react-icons/ai";


const Input = ({ name, placeholder, label, onChange, type, value, size, disabled }) => {
    return (
        <div className="input-container">
            <label>{label}</label>
            <input name={name} placeholder={placeholder} onChange={onChange} type={type} size={size} value={value} disabled={disabled} />
        </div>
    )
}

const PasswordInput = ({ name, placeholder, value, label, disabled, rightIcon, onChange }) => {
    const [showPassword, setShowPassword] = useState(true)
    const [icon, setIcon] = useState(<LuEye />)

    const togglePassword = () => {
        setShowPassword(!showPassword)
        setIcon(showPassword ? <LuEye /> : <AiOutlineEyeInvisible />)
    }

    return (
        <div className="input-container">
            <label>{label}</label>
            <input type={showPassword ? "password" : "text"} disabled={disabled} placeholder={placeholder} value={value} onChange={onChange} name={name} />
            {!rightIcon && (
                <div className="icon" onClick={togglePassword}>
                    {icon}
                </div>
            )}
        </div>
    )
}



export { Input, PasswordInput }