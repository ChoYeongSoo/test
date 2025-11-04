pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // SCM 설정으로 처리됨
            }
        }

        stage('Run Ansible Deployment') {
            steps {
                // VM1 IP: 192.168.10.94, 경로 오타 수정 완료
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
