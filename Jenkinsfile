pipeline {
    agent any

    stages {
        stage('Import GPG Keys') {
            steps {
                withCredentials([
                    file(credentialsId: 'privateKey', variable: 'PRIVATE_KEY_FILE'),
                    file(credentialsId: 'publicKey', variable: 'PUBLIC_KEY_FILE')
                ]) {
                    sh """
                    gpg --import ${PRIVATE_KEY_FILE}
                    gpg --import ${PUBLIC_KEY_FILE}
                    """
                }
            }
        }
        
        // Add more stages for your pipeline
        
    }
}
