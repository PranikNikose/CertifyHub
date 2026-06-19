import { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import "../styles/Login.css";

function Login() {

    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");

    const navigate = useNavigate();

    const handleLogin = async () => {

        try {

            const response = await axios.post("/api/login", {
                username,
                password
            });

            if (response.data.success) {

                localStorage.setItem(
                    "userId",
                    response.data.userId
                );

                localStorage.setItem(
                    "username",
                    response.data.username
                );
                
                localStorage.setItem(
                    "fullName",
                    response.data.fullName
                );

                navigate("/dashboard");

            } else {

                alert(response.data.message);
            }

        } catch (error) {

            console.error(error);
            alert("Login Failed");
        }
    };

    return (
        <div className="login-container">

            <h2 className="login-title">
                CertifyHub Login
            </h2>

            <div className="form-group">
                <label>Username</label>

                <input
                    type="text"
                    value={username}
                    onChange={(e) =>
                        setUsername(e.target.value)
                    }
                />
            </div>

            <div className="form-group">
                <label>Password</label>

                <input
                    type="password"
                    value={password}
                    onChange={(e) =>
                        setPassword(e.target.value)
                    }
                />
            </div>

            <button
                className="login-btn"
                onClick={handleLogin}
            >
                Login
            </button>

        </div>
    );
}

export default Login;