pipeline {
  agent any

  environment {
    AWS_REGION = "ap-south-1"
  }

  options {
    disableConcurrentBuilds()
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        sh '''
          terraform init -reconfigure
        '''
      }
    }

    stage('Terraform Validate') {
      steps {
        sh '''
          terraform validate
        '''
      }
    }

    stage('Terraform Plan') {
      steps {
        sh '''
          terraform plan -out=tfplan
        '''
      }
    }

    stage('Terraform Apply') {
      steps {
        input message: "Apply Terraform?"
        sh '''
          terraform apply -auto-approve tfplan
        '''
      }
    }
  }
}