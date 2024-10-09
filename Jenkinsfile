pipeline {
    agent any 
    environment {
        SONAR_SCANNER_HOME = tool 'SonarScanner'
    }

    stages {
        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'SonarScanner'
                        withSonarQubeEnv('SonarQube Server') {
                            sh "${SONAR_SCANNER_HOME}/bin/sonar-scanner -Dsonar.projectKey=pipeline-project -Dsonar.sources=src -Dsonar.host.url=http://localhost:9000 -Dsonar.projectVersion=1.0 -Dsonar.language=html"
                        }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                withDockerRegistry(credentialsId: 'dev', url: 'https://index.docker.io/v1/') {
                    sh 'docker build -t ktei8htop15122004/hw-tailwind-app .'
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
