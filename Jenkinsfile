pipeline {
    agent any 
    stages {
        // stage('SonarQube Analysis') {
        //     steps {
        //         script {
        //             def scannerHome = tool 'SonarScanner'
        //             withSonarQubeEnv('SonarQube') {
        //                 sh "${scannerHome}/bin/sonar-scanner"
        //             }
        //         }
        //     }
        // }
        stage('Install Docker') {
            steps {
                script {
                    // Kiểm tra xem Docker đã cài đặt chưa
                    sh '''
                    if ! [ -x "$(command -v docker)" ]; then
                      echo "Docker is not installed. Installing Docker..."
                      sudo apt-get update
                      sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
                      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
                      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                      sudo apt-get update
                      sudo apt-get install -y docker-ce docker-ce-cli containerd.io
                      sudo systemctl start docker
                      sudo systemctl enable docker
                    else
                      echo "Docker is already installed"
                    fi
                    '''
                }
            }
        }
        stage('Check Docker') {
            steps {
                sh 'docker --version'
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
