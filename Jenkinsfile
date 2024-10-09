pipeline {
    agent any 
    stages {
        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'SonarScanner'
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                    withDockerRegistry(credentialsId: 'dev', url: 'https://index.docker.io/v1/') {
                    sh 'docker build -t ktei8htop15122004/hw-tailwind-app'
                    sh 'docker push -t ktei8htop15122004/hw-tailwind-app'
                }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                withDockerRegistry(credentialsId: 'dev', url: 'https://index.docker.io/v1/') {
                    sh 'docker build -t ktei8htop15122004/hw-tailwind-app'
                    sh 'docker push -t ktei8htop15122004/hw-tailwind-app'
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
                slackSend(channel: '#test-app', message: "Build and deployment successful!")
            }
        }
    }
}
