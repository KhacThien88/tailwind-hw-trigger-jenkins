pipeline {
    agent any
    stages {
        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'SonarScanner'
                    withSonarQubeEnv('SonarQube') {
                        sh "${scannerHome}/bin/sonar-scanner \
                            -Dsonar.projectKey=hw-tailwind-app \
                            -Dsonar.sources=. \  
                            -Dsonar.exclusions=**/node_modules/**,**/lib/**,**/ssl/**,**/*.so,**/*.pm \
                            -Dsonar.projectBaseDir=${WORKSPACE}"  
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("ktei8htop15122004/hw-tailwind-app:latest").push()
                }
            }
        }
    }
}
