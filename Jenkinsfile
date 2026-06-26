pipeline {
	agent any

	options {
		timestamps()

		buildDiscarder(
			logRotator(
				numToKeepStr: '10'
			)
		)
	}

	tools {
		jdk 'JDK21'
		maven 'Maven-3.9.11'
	}

	environment {
		APP_NAME = 'certifyhub'
		
		GIT_REPO_URL = 'https://github.com/PranikNikose/CertifyHub.git'
		GIT_BRANCH = 'CertifyHub-Pranik'
		
		DOCKERHUB_USERNAME = 'praniknikose'
		DOCKER_CREDENTIAL_ID = 'dockerhub-creds'

		BACKEND_IMAGE  = "${APP_NAME}-backend"
		FRONTEND_IMAGE = "${APP_NAME}-frontend"
		NGINX_IMAGE    = "${APP_NAME}-nginx"

		BACKEND_DIR = "${APP_NAME}-backend"
		FRONTEND_DIR = "${APP_NAME}-frontend"
		NGINX_DIR = "${APP_NAME}-nginx"
		
		
		REMOTE_DIR = "/home/ec2-user/${APP_NAME}"
		SSH_CONFIG = 'certifyhub-ec2'
		
		COMPOSE_FILE = 'docker-compose.dev.yml'
		COMPOSE_FILE_PATH = "deployment\\${COMPOSE_FILE}"
		
	}

	stages {
	
			stage('Build Info') {
			steps {
				script {
					currentBuild.displayName = "#${BUILD_NUMBER}-${APP_NAME}"
				}
			}
		}

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
		
		stage('Cleanup Project Images') {
			steps {
				bat """
					FOR /F "tokens=3" %%i IN ('docker images ^| findstr ${APP_NAME}') DO docker rmi -f %%i
					exit /b 0
				"""
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
							bat 'npm ci'
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
		
		stage('Verify Compose File') {
			steps {
				bat 'dir deployment'
				bat "type ${COMPOSE_FILE_PATH}"
			}
		}

		stage('Validate Compose File') {
			steps {
				bat "docker-compose -f ${COMPOSE_FILE_PATH} config"
			}
		}

		stage('Prepare EC2') {
    steps {
        sshPublisher(
            publishers: [
                sshPublisherDesc(
                    configName: SSH_CONFIG,
                    transfers: [
                        sshTransfer(
                            execCommand: """
                                mkdir -p ${REMOTE_DIR}
                            """
                        )
                    ]
                )
            ]
        )
    }
}

		stage('Upload Compose File') {
			steps {
				sshPublisher(
					publishers: [
						sshPublisherDesc(
							configName: SSH_CONFIG,
							transfers: [
								sshTransfer(
									sourceFiles: COMPOSE_FILE_PATH,
									removePrefix: 'deployment',
									remoteDirectory: APP_NAME
								)
							]
						)
					]
				)
			}
		}

		

		stage('Deploy Application') {
			steps {
				sshPublisher(
					publishers: [
						sshPublisherDesc(
							configName: SSH_CONFIG,
							transfers: [
								sshTransfer(
									execCommand: """
										cd ${REMOTE_DIR}

										docker-compose -f ${COMPOSE_FILE} pull
										docker-compose -f ${COMPOSE_FILE} down
										docker-compose -f ${COMPOSE_FILE} up -d
										docker-compose -f ${COMPOSE_FILE} ps
									"""
								)
							]
						)
					]
				)
			}
		}
		
	}
	


	post {
		success {
			echo 'Application Successfully Built, Pushed and Deployed'
		}
		failure {
			echo 'Pipeline Failed'
		}
		always {
			bat 'docker images'
			bat 'docker logout || exit /b 0'
		}
	}

}
