pineline{
    agent any 
    stages{
        stage("SonarQube Analysis"){
            steps{
                scripts{
                        withSonarQubeEnv('SonarQube') {
                        sh 'sonar-scanner'
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