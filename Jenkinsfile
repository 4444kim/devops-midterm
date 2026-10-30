pipeline {
    agent any

    environment {
        STUDENT_NAME = 'Kim Vladislav'
        IMAGE_NAME   = 'kim-vladislav-student-api'
        IMAGE_TAG    = 'v1.0-kim-vladislav'
    }

    tools {
        // JDK registered in Manage Jenkins -> Tools
        jdk 'jdk21'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Student: ${STUDENT_NAME}"
                checkout scm
                sh 'git log -1 --oneline'
            }
        }

        stage('Build') {
            steps {
                sh 'chmod +x gradlew'
                sh './gradlew clean compileJava --no-daemon'
            }
        }

        stage('Test') {
            steps {
                sh './gradlew test --no-daemon'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'build/test-results/test/*.xml'
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:build-${BUILD_NUMBER} ."
            }
        }

        stage('Verify') {
            steps {
                sh "docker image inspect ${IMAGE_NAME}:${IMAGE_TAG} --format 'Image {{.Id}} created {{.Created}} size {{.Size}} bytes'"
                sh "docker images ${IMAGE_NAME}"
                echo "Image ${IMAGE_NAME}:${IMAGE_TAG} built by ${STUDENT_NAME}"
            }
        }
    }

    post {
        success {
            echo "Pipeline for ${STUDENT_NAME} finished successfully"
        }
        failure {
            echo "Pipeline for ${STUDENT_NAME} FAILED - check the stage logs above"
        }
    }
}
