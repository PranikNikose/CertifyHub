pipeline {
    agent any

	tools {
		jdk 'JDK21'
		maven 'Maven-3.9.11'
	}
		
    stages {

		stage('Environment Check') {
			steps {
				bat 'whoami'
				bat 'java -version'
				bat 'javac -version'
				bat 'mvn -version'
				bat 'docker --version'
				bat 'docker version'
				bat 'docker ps'
			}
		}
	}

}