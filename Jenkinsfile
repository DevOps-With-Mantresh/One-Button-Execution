pipeline {
  agent any

  options {
    disableConcurrentBuilds()
  }

  environment {
    AWS_REGION = "ap-south-1"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform') {
      steps {
        withAWS(credentials: 'aws-jenkins-creds', region: "${AWS_REGION}") {
          sh '''
            terraform init -reconfigure
            terraform validate
            terraform plan -out=tfplan
          '''
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: "Apply Terraform?"

        withAWS(credentials: 'aws-jenkins-creds', region: "${AWS_REGION}") {
          sh '''
            terraform apply tfplan
          '''
        }
      }
    }
  }
}