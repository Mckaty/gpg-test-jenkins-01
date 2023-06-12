pipeline {
    agent any

    stages {
        stage('Execute Shell Script') {
            steps {
                sh '/home/ubuntu/songyot-gpg-01/test-decrypt-02.sh'
            }
        }

        stage('List S3 Outbox') {
            steps {
                withAWS(region: 'ap-southeast-1') {
                    script {
                        def s3Client = aws.s3()

                        def objects = s3Client.listObjects(bucket: 'your-bucket-name', prefix: 'pgp-decrypted-files-12392023/outbox/')
                        objects.each { s3Object ->
                            println(s3Object.key)
                        }
                    }
                }
            }
        }

        stage('List S3 Inbox') {
            steps {
                withAWS(region: 'ap-southeast-1') {
                    script {
                        def s3Client = aws.s3()

                        def objects = s3Client.listObjects(bucket: 'your-bucket-name', prefix: 'pgp-decrypted-files-12392023/inbox/')
                        objects.each { s3Object ->
                            println(s3Object.key)
                        }
                    }
                }
            }
        }
    }
}
