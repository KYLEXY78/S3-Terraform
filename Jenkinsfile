pipeline {
    agent any

    environment {
        // Fetching AWS credentials from Jenkins
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id') // ID for Access Key ID
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key') // ID for Secret Access Key
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the Git repository
                git url: 'https://github.com/KYLEXY78/Kuzan-s-Repository.git', branch: 'master'
            }
        }

        stage('Terraform Init') {
            steps {
                // Initialize Terraform
                sh 'terraform init'
            }
        }

        stage('Terraform Plan') {
            steps {
                // Run Terraform plan
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                // Apply the Terraform configuration
                sh 'terraform apply -auto-approve'
            }
        }
    }

    post {
        always {
            // Clean up, e.g., remove temporary files, if needed
            echo 'Cleaning up...'
        }
        success {
            // Notify on success
            echo 'Deployment successful!'
        }
        failure {
            // Notify on failure
            echo 'Deployment failure!'
        }
    }
}
