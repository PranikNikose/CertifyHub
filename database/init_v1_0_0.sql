DROP TABLE IF EXISTS user_course_result;
DROP TABLE IF EXISTS course_master;
DROP TABLE IF EXISTS users;

--------------------------------------------------
-- USERS
--------------------------------------------------

CREATE TABLE users
(
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    full_name VARCHAR(100) NOT NULL
);

--------------------------------------------------
-- COURSE MASTER
--------------------------------------------------

CREATE TABLE course_master
(
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    course_content TEXT,
    active_flag CHAR(1) DEFAULT 'Y'
);

--------------------------------------------------
-- USER COURSE RESULT
--------------------------------------------------

CREATE TABLE user_course_result
(
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    course_completed CHAR(1) DEFAULT 'N',
    percentage INTEGER,
    exam_status VARCHAR(50),
    issue_date DATE,

    CONSTRAINT fk_ucr_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id),

    CONSTRAINT fk_ucr_course
        FOREIGN KEY (course_id)
        REFERENCES course_master(course_id)
);

--------------------------------------------------
-- USERS DATA
--------------------------------------------------

INSERT INTO users
(
    username,
    password,
    full_name
)
VALUES
(
    'dikshaingole5@gmail.com',
    'Diksha@123',
    'Diksha Ingole'
);

INSERT INTO users
(
    username,
    password,
    full_name
)
VALUES
(
    'praniknikose@gmail.com',
    'Pranik@123',
    'Pranik Nikose'
);

--------------------------------------------------
-- COURSES
--------------------------------------------------

INSERT INTO course_master
(
    course_name,
    course_content,
    active_flag
)
VALUES
(
    'DevOps Fundamentals',
    'Introduction to DevOps, CI/CD, Docker, Jenkins and Cloud.',
    'Y'
);

INSERT INTO course_master
(
    course_name,
    course_content,
    active_flag
)
VALUES
(
    'AWS Basics',
    'Learn AWS Core Services such as EC2, S3, IAM and VPC.',
    'Y'
);

INSERT INTO course_master
(
    course_name,
    course_content,
    active_flag
)
VALUES
(
    'Docker Essentials',
    'Understand Docker Images, Containers, Networking and Volumes.',
    'Y'
);

INSERT INTO course_master
(course_name, course_content, active_flag)
VALUES
('Kubernetes Fundamentals', 'Learn Pods, Deployments, Services, ConfigMaps, Secrets and Kubernetes Architecture.', 'Y'),
('Jenkins CI/CD', 'Build CI/CD pipelines using Jenkins, Git, Maven and Docker.', 'Y'),
('Terraform Infrastructure as Code', 'Create and manage cloud infrastructure using Terraform.', 'Y'),
('Linux Administration', 'Learn Linux commands, file systems, users, permissions and shell scripting.', 'Y'),
('Git & GitHub', 'Master version control, branching, merging, pull requests and GitHub workflows.', 'Y'),
('Azure Fundamentals', 'Introduction to Azure services, virtual machines, storage and networking.', 'Y'),
('Python Programming', 'Learn Python basics, OOP concepts, file handling and automation scripting.', 'Y'),
('Java Spring Boot', 'Develop REST APIs, microservices and enterprise applications using Spring Boot.', 'Y'),
('Ansible Automation', 'Automate server provisioning and configuration management using Ansible.', 'Y'),
('Monitoring with Prometheus & Grafana', 'Monitor applications and infrastructure using Prometheus and Grafana dashboards.', 'Y');