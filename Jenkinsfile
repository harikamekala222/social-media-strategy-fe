
pipeline {
    agent any

    environment {
        REACT_APP_API_URL = 'https://api.so-me.net/api/'
        REACT_APP_OKTA_DOMAIN = 'http://13.233.212.136'
        REACT_APP_OKTA_CLIENT_ID = 'YOUR_OKTA_CLIENT_ID'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    set -eu

                    cat > .env <<EOF
REACT_APP_API_URL=${REACT_APP_API_URL}
REACT_APP_OKTA_DOMAIN=${REACT_APP_OKTA_DOMAIN}
REACT_APP_OKTA_CLIENT_ID=${REACT_APP_OKTA_CLIENT_ID}
EOF

                    docker compose up -d --build
                    docker compose ps
                '''
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed. Check console output.'
        }
    }
}
