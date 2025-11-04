// Jenkinsfile (Declarative Pipeline)
pipeline {
    agent any // 빌드를 실행할 Jenkins Worker (VM2)

    stages {
        // 첫 번째 단계: 코드 체크아웃
        stage('Checkout Code') {
            steps {
                // Git 저장소에서 코드를 가져옵니다.
                // 이미 Job 설정에서 SCM을 지정했으므로, 이 단계는 보통 자동으로 실행되지만, 명시적으로 sh 'git pull'을 사용할 수도 있습니다.
                // 이 예시에서는 Job 설정(SCM)을 신뢰합니다.
            }
        }
        
        // 두 번째 단계: Ansible 배포 실행
        stage('Run Ansible Deployment') {
            steps {
                // VM2(Jenkins)에서 VM1(Ansible Controller)로 SSH 접속하여 Ansible Playbook을 실행합니다.
                // VM1의 IP 주소는 192.168.10.94입니다.
                sh "ssh -o StrictHostKeyChecking=no root@192.168.10.94 'ansible-playbook /etc/ansible/test/monitor_ci_setup.yml'"
            }
        }
        
        // (필요하다면) 세 번째 단계: 서비스 상태 확인
        // stage('Check Service Status') { ... }
    }
    
    post {
        // 빌드 성공/실패 후 알림 등의 작업 수행
        success {
            echo 'Pipeline finished successfully!'
        }
        failure {
            echo 'Pipeline failed. Check Console Output for details.'
        }
    }
}
