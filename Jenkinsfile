
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Deploy') {
            steps {
                withCredentials([
                    string(credentialsId: 'react-api-url', variable: 'REACT_APP_API_URL'),
                    string(credentialsId: 'okta-domain', variable: 'REACT_APP_OKTA_DOMAIN'),
                    string(credentialsId: 'okta-client-id', variable: 'REACT_APP_OKTA_CLIENT_ID')
                ]) {
                    sh '''
                        set -eu

                        cat > .env <<EOF
REACT_APP_API_URL=$REACT_APP_API_URL
REACT_APP_OKTA_DOMAIN=$REACT_APP_OKTA_DOMAIN
REACT_APP_OKTA_CLIENT_ID=$REACT_APP_OKTA_CLIENT_ID
EOF

                        docker compose up -d --build
                        docker compose ps

                        rm -f .env
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed. Check Jenkins console.'
        }
    }
}
