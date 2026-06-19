import { useEffect, useState } from "react";
import { useParams, useNavigate } from "react-router-dom";
import axios from "axios";
import "../styles/Course.css";

function Course() {

    const { courseId } = useParams();

    const navigate = useNavigate();

    const [course, setCourse] = useState(null);

    const userId = localStorage.getItem("userId");

    useEffect(() => {

        const loadCourse = async () => {

            try {

                const response =
                    await axios.get(`/api/course/${courseId}`);

                setCourse(response.data);

            } catch (error) {

                console.error(error);

                alert("Failed To Load Course");
            }
        };

        loadCourse();

    }, [courseId]);

    const markCourseComplete = async () => {

        try {

            await axios.post(
                "/api/course/complete",
                {
                    userId: Number(userId),
                    courseId: Number(courseId)
                }
            );

            alert("Course Completed Successfully");

            navigate("/dashboard");

        } catch (error) {

            console.error(error);

            alert("Failed To Complete Course");
        }
    };

    if (!course) {

        return <h3>Loading...</h3>;
    }

    return (
        <div className="course-container">

            <h2 className="course-title">
                {course.courseName}
            </h2>

            <div className="course-content">
                {course.courseContent}
            </div>

            <button
                className="complete-btn"
                onClick={markCourseComplete}
            >
                Mark Course Complete
            </button>

        </div>
    );
}

export default Course;