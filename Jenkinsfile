pipeline {
  agent any

  stages {

    stage('Import GPG Keys') {
      steps {
        script {
          sh "who am i"
        }
      }
    }
    stage('Import Decrypt') {
      steps {
        script {
          echo "Hello Decrypt"
        }
      }
    }
  }
}
