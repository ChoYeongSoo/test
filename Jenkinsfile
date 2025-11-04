pipeline {
    agent any // 빌드를 실행할 Jenkins Worker (VM2)

    stages {
        // 1. 코드 체크아웃 (Job 설정의 SCM을 통해 자동 실행되지만, Stage는 유지합니다.)
        stage('Checkout Code') {
            steps {
                // SCM 설정(Git)이 처리하므로 steps 내용은 비워둡니다.
            }
        }
        
        // 2. Ansible 배포 실행 (SSH 인증 문제와 IP 주소 문제 해결 후)
        stage('Run Ansible Deployment') {
            steps {
                // VM2(Jenkins)에서 VM1(Ansible Controller)로 SSH 접속하여 Playbook을 실행합니다.
                // VM1의 IP: 192.168.10.94
                sh "ssh -o StrictHostKeyChecking=no root@192.168.10.94 'ansible-playbook /etc/ansible/test/monitor_ci_setup.yml'"
            }
        }
        
        // (필요하다면) 모니터링 시스템 재로드/확인 등의 후속 단계 추가 가능
    }
    
    post {
        success {
            echo 'Deployment Pipeline finished successfully! Check service status.'
        }
        failure {
            echo 'Pipeline failed. Check the Console Output and SSH connectivity.'
        }
    }
}
