pipeline {
    agent any
    
    // 환경 변수 설정 (Build Number는 Jenkins가 자동으로 제공)
    environment {
        // VM3 (App Server) 배포 경로 및 IP 설정 (Ansible 실행 위치: VM1)
        ANSIBLE_INVENTORY = '/etc/ansible/test/hosts'
        ANSIBLE_PLAYBOOK_APP = '/etc/ansible/test/app_deploy.yml'
        ANSIBLE_PLAYBOOK_MONITOR = '/etc/ansible/test/monitor_ci_setup.yml'
        VM1_IP = '192.168.10.94' // VM1 IP 주소 (Ansible 제어 노드)
    }

    stages {
        stage('1. Checkout Code') {
            steps {
                // SCM에서 최신 코드 가져오기
                checkout scm
            }
        }

        stage('2. Build Docker Image') {
            steps {
                // Docker 이미지 빌드 및 태그 지정
                // --no-cache 옵션을 추가하여 mysqli 설치 실패 문제를 해결합니다. (강제 재빌드)
                sh "docker build --no-cache -t cho/web-app:build-${BUILD_NUMBER} ."
            }
        }

        stage('3. Deploy App via Ansible') {
            steps {
                // Jenkins Credentials ID 'jenkins-ansible-key'를 사용하여 SSH 인증 수행
                sshagent(credentials: ['jenkins-ansible-key']) {
                    // VM1에서 app_deploy.yml Playbook 실행
                    sh "ssh -o StrictHostKeyChecking=no root@${VM1_IP} 'ansible-playbook -i ${ANSIBLE_INVENTORY} ${ANSIBLE_PLAYBOOK_APP}'"
                }
            }
        }
        
        // **[NEW]** 모니터링 시스템 배포 스테이지 추가
        stage('4. Deploy Monitoring') {
            steps {
                // 모니터링 시스템 (Prometheus/Grafana/Node Exporter) 배포 Playbook 실행
                sshagent(credentials: ['jenkins-ansible-key']) {
                    sh "ssh -o StrictHostKeyChecking=no root@${VM1_IP} 'ansible-playbook -i ${ANSIBLE_INVENTORY} ${ANSIBLE_PLAYBOOK_MONITOR}'"
                }
            }
        }
    }

    post {
        success {
            echo "✅ CI/CD 파이프라인 성공! 새로운 버전이 VM3에 배포되었고 모니터링 시스템이 설정되었습니다."
        }
        failure {
            echo "❌ CI/CD 파이프라인 실패. 로그를 확인하세요."
        }
    }
}
