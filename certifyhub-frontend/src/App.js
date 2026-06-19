import { BrowserRouter, Routes, Route } from "react-router-dom";

import Login from "./pages/Login";
import Dashboard from "./pages/Dashboard";
import Course from "./pages/Course";
import Exam from "./pages/Exam";
import Certificate from "./pages/Certificate";

function App() {

  return (
    <BrowserRouter>

      <Routes>

        <Route
          path="/"
          element={<Login />}
        />

        <Route
          path="/dashboard"
          element={<Dashboard />}
        />

        <Route
          path="/course/:courseId"
          element={<Course />}
        />

        <Route
          path="/exam/:courseId"
          element={<Exam />}
        />

        <Route
          path="/certificate/:courseId"
          element={<Certificate />}
        />

      </Routes>

    </BrowserRouter>
  );
}

export default App;