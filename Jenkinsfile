// Jenkinsfile (Declarative Pipeline)
pipeline {
    agent any 

    stages {
        // 1. Git 코드 체크아웃 (Job 설정에서 SCM으로 처리됨)
        stage('Checkout Code') {
            steps {
                // 이 단계는 Job 설정에서 처리하므로 steps 내용은 비워둡니다.
            }
        }
        
        // 2. Ansible 배포 실행
        stage('Run Ansible Deployment') {
            steps {
                // VM2(Jenkins)에서 VM1(Ansible Controller)로 SSH 접속하여 Playbook 실행
                sh "ssh -o StrictHostKeyChecking=no root@192.168.10.94 'ansible-playbook /etc/ansible/test/monitor_ci_setup.yml'"
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline finished successfully!'
        }
        failure {
            echo 'Pipeline failed. Check Console Output.'
        }
    }
}
