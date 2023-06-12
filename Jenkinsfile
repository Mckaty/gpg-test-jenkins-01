pipeline {
    agent any

    stages {
        stage('Decrypt Files') {
            steps {
                script {
                    def s3Bucket = 'pgp-decrypted-files-12392023'
                    def inboxPrefix = 'inbox/'
                    def outboxPrefix = 'outbox/'
                    def s3Client = AmazonS3.create()

                    def objectListing = s3Client.listObjects(bucketName: s3Bucket, prefix: inboxPrefix, delimiter: '/')

                    objectListing.objectSummaries.each { fileSummary ->
                        if (fileSummary.key.endsWith('.gpg')) {
                            def fileName = fileSummary.key.substringAfterLast('/')
                            def decryptedFilePath = outboxPrefix + fileName.substring(0, fileName.lastIndexOf('.'))

                            def gpgFile = new File(fileName)
                            s3Client.getObject(bucketName: s3Bucket, key: fileSummary.key, destination: gpgFile)

                            // Decrypt the gpg file using your decryption logic here

                            s3Client.putObject(bucketName: s3Bucket, key: decryptedFilePath, file: gpgFile)
                            gpgFile.delete()
                        }
                    }
                }
            }
        }

        stage('Delete Original Files') {
            steps {
                script {
                    def s3Bucket = 'pgp-decrypted-files-12392023'
                    def inboxPrefix = 'inbox/'
                    def s3Client = AmazonS3.create()

                    def objectListing = s3Client.listObjects(bucketName: s3Bucket, prefix: inboxPrefix, delimiter: '/')

                    objectListing.objectSummaries.each { fileSummary ->
                        if (fileSummary.key.endsWith('.gpg')) {
                            s3Client.deleteObject(bucketName: s3Bucket, key: fileSummary.key)
                        }
                    }
                }
            }
        }
    }
}
