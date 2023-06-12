pipeline {
    agent any

    parameters {
        file(name: 'UPLOAD_FILE', description: 'File to upload')
    }

    stages {
        stage('Upload File') {
            steps {
                script {
                    def uploadedFilePath = env.UPLOAD_FILE
                    sh "echo Uploaded file path: $uploadedFilePath"
                    
                    // Perform further actions with the uploaded file
                }
            }
        }
        
        // Add more stages for your pipeline
        
    }
}
