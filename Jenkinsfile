pipeline {
  agent any

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
        withAWS(credentials: 'aws-jenkins-creds', region: 'ap-south-1'){
                sh '''
                terraform init -reconfigure
                '''
        }
      }
    }

    stage('Terraform Plan') {
      steps {
        withAWS(credentials: 'aws-jenkins-creds', region: 'ap-south-1') {
        sh '''
          terraform plan -out=tfplan
        '''
        }
      }
    }

    stage('Terraform Apply') {
      steps {
        withAWS(credentials: 'aws-jenkins-creds', region: 'ap-south-1') {
        input message: "Apply Terraform?"
        sh '''
          terraform apply -auto-approve tfplan
        '''
        }
      }
    }
  }
}