pipeline {
  agent any

  stages {
    stage('Import GPG Keys') {
      steps {
        script {
          def gpgPublicKey
          def gpgPrivateKey

          try {
            // Attempt to retrieve GPG public key from Jenkins credentials
            withCredentials([file(credentialsId: 'gpg-public-key', variable: 'GPG_PUBLIC_KEY_FILE')]) {
              gpgPublicKey = readFile "${GPG_PUBLIC_KEY_FILE}"
            }
          } catch (Exception e) {
            // If GPG public key is not available in Jenkins credentials, browse and import from local file
            def publicKeyFilePath = input(
              message: 'Please select the GPG public key file:',
              parameters: [file(name: 'publicKeyFile', description: 'GPG Public Key')]
            ).publicKeyFile

            gpgPublicKey = readFile publicKeyFilePath
          }

          try {
            // Attempt to retrieve GPG private key from Jenkins credentials
            withCredentials([file(credentialsId: 'gpg-private-key', variable: 'GPG_PRIVATE_KEY_FILE')]) {
              gpgPrivateKey = readFile "${GPG_PRIVATE_KEY_FILE}"
            }
          } catch (Exception e) {
            // If GPG private key is not available in Jenkins credentials, browse and import from local file
            def privateKeyFilePath = input(
              message: 'Please select the GPG private key file:',
              parameters: [file(name: 'privateKeyFile', description: 'GPG Private Key')]
            ).privateKeyFile

            gpgPrivateKey = readFile privateKeyFilePath
          }

          // Import the GPG public key
          sh "echo '${gpgPublicKey}' | gpg --import"

          // Import the GPG private key
          sh "echo '${gpgPrivateKey}' | gpg --allow-secret-key-import --import"
        }
      }
    }

    stage('Decrypt and Move Files') {
      steps {
        withAWS(region: 'your-region', credentials: 'aws-credentials') {
          def s3Bucket = 'test-gpg-01'
          def s3Prefix = 'inbox/'
          def s3Client = aws.s3()

          // List files in the S3 bucket
          def s3Objects = s3Client.listObjectsV2(Bucket: s3Bucket, Prefix: s3Prefix).getObjectSummaries()

          for (def s3Object : s3Objects) {
            def s3Key = s3Object.getKey()

            // Check if the file has a .gpg extension
            if (s3Key.endsWith('.gpg')) {
              // Download the encrypted file from S3
              def encryptedFile = "${s3Key}"
              s3Client.getObject(Bucket: s3Bucket, Key: encryptedFile).getObjectContent().withInputStream { inputStream ->
                sh "gpg --decrypt --output decrypted-file.txt --decrypt-files ${inputStream}"
              }

              // Move the decrypted file to the outbox
              def decryptedFile = "decrypted-file.txt"
              s3Client.putObject(Bucket: s3Bucket, Key: "outbox/${decryptedFile}", File: decryptedFile)

              // Delete the original file from the inbox
              s3Client.deleteObject(Bucket: s3Bucket, Key: s3Key)
            }
          }
        }
      }
    }
  }
}
