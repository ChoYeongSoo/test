pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
            }
        }
        stage('Run Ansible Deployment') {
            steps {
                sh "ssh -o StrictHostKeyChecking=no root@192.168.10.94 'ansible-playbook /etc/ansible/test/monitor_ci_setup.yml'"
            }
        }
    }
    post {
        success {
            echo 'Deployment success.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
