import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import axios from "axios";
import "../styles/Dashboard.css";

function Dashboard() {

    const [courses, setCourses] = useState([]);

    const navigate = useNavigate();


    const fullName = localStorage.getItem("fullName");

    useEffect(() => {

        loadCourses();

    }, []);

    const loadCourses = async () => {

        try {

            const userId =
                localStorage.getItem("userId");

            const response =
                await axios.get(
                    `/api/courses/${userId}`
                );

            setCourses(response.data);

        } catch (error) {

            console.error(error);

            alert("Failed To Load Courses");
        }
    };

    return (
        <div className="dashboard-container">

            <h2 className="dashboard-header">
                CertifyHub Dashboard
            </h2>

            <h3>
                Welcome, {fullName}
            </h3>

            <table className="dashboard-table">

                <thead>

                    <tr>
                        <th>Course Name</th>
                        <th>View Course</th>
                        <th>Take Exam</th>
                        <th>Course Completed</th>
                        <th>Exam Status</th>
                        <th>Certificate</th>
                    </tr>

                </thead>

                <tbody>

                    {courses.map((course) => (

                        <tr key={course.courseId}>

                            <td>
                                {course.courseName}
                            </td>

                            <td>

                                <button
                                    className="action-btn"
                                    onClick={() =>
                                        navigate(
                                            `/course/${course.courseId}`
                                        )
                                    }
                                >
                                    View
                                </button>

                            </td>

                            <td>

                                <button
                                    className="action-btn"
                                    onClick={() =>
                                        navigate(
                                            `/exam/${course.courseId}`
                                        )
                                    }
                                >
                                    Exam
                                </button>

                            </td>

                            <td>
                                {course.courseCompleted}
                            </td>

                            <td>
                                {course.examStatus}
                            </td>

                            <td>

                                {course.certificateAvailable === "Y" ? (

                                    <button
                                        className="action-btn"
                                        onClick={() =>
                                            navigate(
                                                `/certificate/${course.courseId}`
                                            )
                                        }
                                    >
                                        View
                                    </button>

                                ) : (

                                    "N/A"

                                )}

                            </td>

                        </tr>

                    ))}

                </tbody>

            </table>

        </div>
    );
}

export default Dashboard;