pipeline {
    agent any 
    environment {
    DOCKERHUB_CREDENTIALS = credentials('cs1867')
    }
    stages { 
        stage('SCM Checkout') {
            steps{
            git 'https://github.com/perfsonar/perfsonar-tools-docker.git'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t cs1867/perfsonar-tools:$BUILD_NUMBER  .'
            }
        }
        stage('login to dockerhub') {
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }
        stage('push image') {
            steps{
                sh 'docker push cs1867/perfsonar-tools:$BUILD_NUMBER '
            }
        }
}
post {
        always {
            sh 'docker logout'
        }
    }
}
