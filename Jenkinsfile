pipeline {
	agent any

	options {
		timestamps()

		buildDiscarder(
			logRotator(
				numToKeepStr: '20'
			)
		)
	}

	tools {
		jdk 'JDK21'
		maven 'Maven-3.9.11'
	}

	environment {
		GIT_REPO_URL = 'https://github.com/PranikNikose/CertifyHub.git'
		GIT_BRANCH = 'CertifyHub-Pranik'
		
		DOCKERHUB_USERNAME = 'praniknikose'
		DOCKER_CREDENTIAL_ID = 'dockerhub-creds'

		BACKEND_IMAGE  = 'certifyhub-backend'
		FRONTEND_IMAGE = 'certifyhub-frontend'
		NGINX_IMAGE    = 'certifyhub-nginx'

		BACKEND_DIR = 'certifyhub-backend'
		FRONTEND_DIR = 'certifyhub-frontend'
		NGINX_DIR = 'certifyhub-nginx'
	}

	stages {

		stage('All Environments Check') {
			steps {
				bat 'whoami'
				bat 'java -version'
				bat 'javac -version'
				bat 'mvn -version'
				bat 'node -v'
				bat 'npm -v'
				bat 'docker --version'
				bat 'docker version'
				bat 'docker ps'
			}
		}
		
		stage('Workspace Cleanup') {
			steps {
				cleanWs()
			}
		}

		stage('GitHub Checkout') {
			steps {
				git branch: "${GIT_BRANCH}",
					url: "${GIT_REPO_URL}"
			}
		}

		stage('Build Applications') {
		
			parallel {
				stage('Build Backend App') {
					steps {
						dir("${BACKEND_DIR}") {
							bat 'mvn clean package -DskipTests'
						}
					}
				}

				stage('Build Frontend App') {
					steps {
						dir("${FRONTEND_DIR}") {
							bat 'npm install'
							bat 'npm run build'
						}
					}
				}
			}
			
		}

		stage('Build Docker Images') {
		
			parallel {
				stage('Build Backend Image') {
					steps {
						dir("${BACKEND_DIR}") {
							bat "docker build -t ${BACKEND_IMAGE}:latest ."
						}
					}
				}
				
				stage('Build Frontend Image') {
					steps {
						dir("${FRONTEND_DIR}") {
							bat "docker build -t ${FRONTEND_IMAGE}:latest ."
						}
					}
				}
				
				stage('Build Nginx Image') {
					steps {
						dir("${NGINX_DIR}") {
							bat "docker build -t ${NGINX_IMAGE}:latest ."
						}
					}
				}
			}
			
		}

		stage('List Docker Images') {
			steps {
				bat 'docker images'
			}
		}

		stage('DockerHub Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: "${DOCKER_CREDENTIAL_ID}",
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    bat '''
                    echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                    '''
                }
            }
        }

		stage('Push Docker Images') {
		
			parallel {
				stage('Push Backend Image') {
					steps {
						bat "docker tag ${BACKEND_IMAGE}:latest ${DOCKERHUB_USERNAME}/${BACKEND_IMAGE}:${BUILD_NUMBER}"
						bat "docker tag ${BACKEND_IMAGE}:latest ${DOCKERHUB_USERNAME}/${BACKEND_IMAGE}:latest"

						bat "docker push ${DOCKERHUB_USERNAME}/${BACKEND_IMAGE}:${BUILD_NUMBER}"
						bat "docker push ${DOCKERHUB_USERNAME}/${BACKEND_IMAGE}:latest"
					}
				}

				stage('Push Frontend Image') {
					steps {
						bat "docker tag ${FRONTEND_IMAGE}:latest ${DOCKERHUB_USERNAME}/${FRONTEND_IMAGE}:${BUILD_NUMBER}"
						bat "docker tag ${FRONTEND_IMAGE}:latest ${DOCKERHUB_USERNAME}/${FRONTEND_IMAGE}:latest"

						bat "docker push ${DOCKERHUB_USERNAME}/${FRONTEND_IMAGE}:${BUILD_NUMBER}"
						bat "docker push ${DOCKERHUB_USERNAME}/${FRONTEND_IMAGE}:latest"
					}
				}

				stage('Push Nginx Image') {
					steps {
						bat "docker tag ${NGINX_IMAGE}:latest ${DOCKERHUB_USERNAME}/${NGINX_IMAGE}:${BUILD_NUMBER}"
						bat "docker tag ${NGINX_IMAGE}:latest ${DOCKERHUB_USERNAME}/${NGINX_IMAGE}:latest"

						bat "docker push ${DOCKERHUB_USERNAME}/${NGINX_IMAGE}:${BUILD_NUMBER}"
						bat "docker push ${DOCKERHUB_USERNAME}/${NGINX_IMAGE}:latest"
					}
				}
				
			}
			
		}
		
		
	}
	


	post {
		success {
			echo 'Docker Images Successfully Pushed To DockerHub'
		}
		failure {
			echo 'Pipeline Failed'
		}
		always {
			bat 'docker images'
			bat 'docker logout'
		}
	}

}
