pipeline {
  agent any

  environment {
    GCP_CREDS = credentials('gcp-sa')
  }

  stages {
    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh '''
        echo "$GCP_CREDS" > gcp-key.json
        terraform plan
        '''
      }
    }

    stage('Terraform Apply') {
      steps {
        sh '''
        echo "$GCP_CREDS" > gcp-key.json
        terraform apply -auto-approve
        '''
      }
    }
  }
}
