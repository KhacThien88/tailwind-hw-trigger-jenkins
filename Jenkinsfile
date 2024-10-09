pipeline {
    agent any 
    stages {
        stage('SonarQube Analysis') {
            def scannerHome = tool 'SonarScanner';
                withSonarQubeEnv() {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("ktei8htop15122004/hw-tailwind-app:latest").push()
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh 'argocd app sync hw-tailwind-app'
                }
            }
        }
        stage('Slack Notification') {
            steps {
                slackSend(channel: '#your-channel', message: "Build and deployment successful!")
            }
        }
    }
}
