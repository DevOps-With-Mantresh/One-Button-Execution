pipeline {
  agent any

  options {
    disableConcurrentBuilds()
  }

  parameters {
    choice(
      name: 'ACTION',
      choices: ['apply', 'destroy'],
      description: 'Choose Terraform action'
    )
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

    stage('Terraform Init & Validate') {
      steps {
        withAWS(credentials: 'aws-jenkins-creds', region: "${AWS_REGION}") {
          sh '''
            terraform init -reconfigure
            terraform validate
          '''
        }
      }
    }

    stage('Terraform Plan') {
      when {
        expression { params.ACTION == 'apply' }
      }
      steps {
        withAWS(credentials: 'aws-jenkins-creds', region: "${AWS_REGION}") {
          sh 'terraform plan -out=tfplan'
        }
      }
    }

    stage('Terraform Apply') {
      when {
        expression { params.ACTION == 'apply' }
      }
      steps {
        input message: "Apply Terraform?"
        withAWS(credentials: 'aws-jenkins-creds', region: "${AWS_REGION}") {
          sh 'terraform apply tfplan'
        }
      }
    }

    stage('Terraform Destroy') {
      when {
        expression { params.ACTION == 'destroy' }
      }
      steps {
        input message: "Are you sure you want to DESTROY infrastructure?"
        withAWS(credentials: 'aws-jenkins-creds', region: "${AWS_REGION}") {
          sh 'terraform destroy -auto-approve'
        }
      }
    }
  }
}