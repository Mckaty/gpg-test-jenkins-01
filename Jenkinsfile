pipeline {
    agent any

    stages {
        stage('Choose File') {
            steps {
                script {
                    def fileInput = input(
                        message: 'Choose a file',
                        parameters: [
                            file(name: 'FILE_TO_USE', description: 'File to process')
                        ]
                    )
                    
                    def selectedFilePath = fileInput['FILE_TO_USE']
                    sh "echo Selected file path: $selectedFilePath"
                    
                    // Perform further actions with the selected file
                }
            }
        }
        
        // Add more stages for your pipeline
        
    }
}
