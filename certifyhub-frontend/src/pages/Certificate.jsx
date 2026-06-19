import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";
import "../styles/Certificate.css";

function Certificate() {

    const { courseId } = useParams();

    const navigate = useNavigate();

    const [certificate, setCertificate] = useState(null);

    useEffect(() => {

        const loadCertificate = async () => {

            try {

                const userId =
                    localStorage.getItem("userId");

                const response =
                    await axios.get(
                        `/api/certificate/${userId}/${courseId}`
                    );

                setCertificate(response.data);

            } catch (error) {

                console.error(error);

                alert("Certificate Not Available");
            }
        };

        loadCertificate();

    }, [courseId]);

    if (!certificate) {

        return <h3>Loading...</h3>;
    }

    return (

        <>

            <div className="certificate-container">

                <h1 className="certificate-title">
                    Certificate of Completion
                </h1>

                <p className="certificate-subtitle">
                    This certificate is proudly awarded to
                </p>

                <div className="certificate-name">
                    {certificate.candidateName}
                </div>

                <p>
                    for successfully completing
                </p>

                <div className="certificate-course">
                    {certificate.courseName}
                </div>

                <div className="certificate-details">

                    <p>
                        Percentage : {certificate.percentage}%
                    </p>

                    <p>
                        Status : {certificate.examStatus}
                    </p>

                    <p>
                        Issue Date : {certificate.issueDate}
                    </p>

                </div>

            </div>

            <div className="certificate-actions">

                <button
                    className="back-btn"
                    onClick={() => navigate("/dashboard")}
                >
                    Back To Dashboard
                </button>

            </div>

        </>

    );
}

export default Certificate;