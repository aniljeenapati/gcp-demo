pipeline {
  agent any

  environment {
    GOOGLE_CREDENTIALS = credentials('gcp-sa')
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
        terraform plan -var="project_id=my-gcp-project" \
                       -var="region=us-central1" \
                       -var="zone=us-central1-a" \
                       -var="service_account_key=$GOOGLE_CREDENTIALS" \
                       -var="app_repo_url=https://github.com/aniljeenapati/demo-repo.git"
        '''
      }
    }

    stage('Terraform Apply') {
      steps {
        sh '''
        terraform apply -auto-approve -var="project_id=my-gcp-project" \
                                        -var="region=us-central1" \
                                        -var="zone=us-central1-a" \
                                        -var="service_account_key=$GOOGLE_CREDENTIALS" \
                                        -var="app_repo_url=https://github.com/aniljeenapati/demo-repo.git"
        '''
      }
    }
  }
}
