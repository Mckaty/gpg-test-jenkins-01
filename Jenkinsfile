pipeline {
    agent any

    stages {
        stage('Execute Shell Script') {
            steps {
                sh 'chmod +x test-decrypt-02.sh'
                sh './test-decrypt-02.sh'
            }
        }

        stage('List S3 Outbox') {
            steps {
                sh 'aws s3 ls s3://pgp-decrypted-files-12392023/inbox/ '
            }
        }

        stage('List S3 Inbox') {
            steps {
                sh 'aws s3 ls s3://pgp-decrypted-files-12392023/outbox/ '
            }
    }
}
