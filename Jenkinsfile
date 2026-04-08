pipeline {
    agent any

    environment {
        DOCKER_USER = 'vickyneduncheziyan'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Branch: ${env.BRANCH_NAME}"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == 'main') {
                        env.REPO = 'prod'
                    } else {
                        env.REPO = 'dev'
                    }
                    env.IMAGE_TAG = "${env.DOCKER_USER}/${env.REPO}:latest"
                    echo "Building: ${env.IMAGE_TAG}"
                    sh "docker build -t ${env.IMAGE_TAG} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: env.DOCKER_CREDENTIALS_ID,
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh """
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push ${env.IMAGE_TAG}
                        docker logout
                    """
                }
            }
        }

        stage('Deploy Application') {
            steps {
                sh """
                    docker stop devops-app || true
                    docker rm devops-app || true
                    docker run -d \\
                        --name devops-app \\
                        --restart always \\
                        -p 80:80 \\
                        ${env.IMAGE_TAG}
                """
            }
        }
    }

    post {
        success {
            echo "Pipeline SUCCESS — ${env.IMAGE_TAG} deployed."
        }
        failure {
            echo "Pipeline FAILED on branch ${env.BRANCH_NAME}."
        }
    }
}
