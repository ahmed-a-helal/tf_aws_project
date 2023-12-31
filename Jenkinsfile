pipeline {
    agent {label 'Jenkins_agent'}
    stages {
        stage('Terraform install') {
            steps {
                sh 'apt-get update && apt-get install wget gpg lsb-release -y'
                sh 'wget -O- https://apt.releases.hashicorp.com/gpg |  gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg'
                sh 'gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint'
                sh 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list'
                sh 'apt-get update && apt-get install terraform -y'
            }
        }
        
        stage("aws infrastructure up/down"){
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: "ahmedattia",
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                    git branch: 'lab2', url: 'https://github.com/ahmed-a-helal/tf_aws_project.git'
                    sh ' terraform init '
                    sh ' terraform workspace select ${Environment} '
                    sh 'terraform ${Action} --var-file  ${Environment}.tfvars -auto-approve'
                }
                
            }
        }
        stage ("Archive keys"){
            steps{
                script{
                    if (env.Action == 'apply') {
                        archiveArtifacts artifacts: '*.pem', fingerprint: true, followSymlinks: false, onlyIfSuccessful: true
                    }   
                }
            }
        }
    }
}
