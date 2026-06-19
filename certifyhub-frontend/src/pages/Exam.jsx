import { useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";
import "../styles/Exam.css";

function Exam() {

    const { courseId } = useParams();

    const navigate = useNavigate();

    const [percentage, setPercentage] = useState("");

    const [examStatus, setExamStatus] = useState("PASS");

    const submitExam = async () => {

        try {

            const userId =
                localStorage.getItem("userId");

            await axios.post(
                "/api/exam",
                {
                    userId: Number(userId),
                    courseId: Number(courseId),
                    percentage: Number(percentage),
                    examStatus: examStatus
                }
            );

            alert("Exam Submitted Successfully");

            navigate("/dashboard");

        } catch (error) {

            console.error(error);

            alert("Failed To Submit Exam");
        }
    };

    return (
        <div className="exam-container">

            <h2 className="exam-title">
                Course Examination
            </h2>

            <div className="exam-group">

                <label>
                    Percentage
                </label>

                <input
                    type="number"
                    value={percentage}
                    onChange={(e) =>
                        setPercentage(e.target.value)
                    }
                    placeholder="Enter Percentage"
                />

            </div>

            <div className="exam-group">

                <label>
                    Result Status
                </label>

                <select
                    value={examStatus}
                    onChange={(e) =>
                        setExamStatus(e.target.value)
                    }
                >
                    <option value="PASS">
                        PASS
                    </option>

                    <option value="FAIL">
                        FAIL
                    </option>

                    <option value="ABSENT">
                        ABSENT
                    </option>

                    <option value="RESULT_WITHHELD">
                        RESULT WITHHELD
                    </option>

                </select>

            </div>

            <button
                className="exam-btn"
                onClick={submitExam}
            >
                Submit Exam
            </button>

        </div>
    );
}

export default Exam;