pipeline {
    // Jenkins 에이전트는 빌드 환경을 제공합니다. (VM2 Jenkins 서버 자체 사용)
    agent any

    // 환경 변수 설정 (선택 사항: Docker 이미지 이름 등을 정의)
    environment {
        // GitHub 저장소 이름과 동일하게 설정 (cho/web-app)
        DOCKER_IMAGE = 'cho/web-app'
        // Docker Hub에 푸시할 경우 사용할 태그
        IMAGE_TAG = "build-${BUILD_NUMBER}" 
        // Ansible SSH 접속에 사용할 VM1의 root 계정
        ANSIBLE_USER = 'root'
        ANSIBLE_HOST = '192.168.10.94' // VM1 IP
        ANSIBLE_INVENTORY = '/etc/ansible/test/hosts'
        ANSIBLE_PLAYBOOK = '/etc/ansible/test/app_deploy.yml' // VM3에 배포할 Playbook
    }

    stages {
        // 1. 소스 코드 체크아웃 (SCM: Source Code Management)
        stage('1. Checkout Code') {
            steps {
                // GitHub에 푸시된 모든 파일(앱 코드, Dockerfile 등)을 가져옵니다.
                checkout scm
            }
        }

        // 2. Docker 이미지 빌드
        stage('2. Build Docker Image') {
            steps {
                // Dockerfile을 사용하여 새 이미지를 로컬 Jenkins 서버(VM2)에 빌드합니다.
                // 빌드 성공 후 이미지 태그는 'cho/web-app:build-N' 형태가 됩니다.
                sh "docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} ."
            }
        }

        // 3. VM1을 경유하여 VM3에 배포
        stage('3. Deploy via Ansible') {
            steps {
                // Jenkins Credential ID 'jenkins-ansible-key'를 사용하여 VM1에 SSH 접속합니다.
                sshagent(credentials: ['jenkins-ansible-key']) {
                    // VM1에서 Ansible을 실행하여 VM3에 Docker Compose 배포 Playbook을 실행합니다.
                    // 이 Playbook이 VM3에서 Docker Compose를 최신 이미지로 재실행합니다.
                    sh "ssh -o StrictHostKeyChecking=no ${ANSIBLE_USER}@${ANSIBLE_HOST} 'ansible-playbook -i ${ANSIBLE_INVENTORY} ${ANSIBLE_PLAYBOOK}'"
                }
            }
        }
    }

    // 빌드 후 처리 (성공/실패 알림 등)
    post {
        success {
            echo "CI/CD 파이프라인 성공! 새로운 버전이 VM3에 배포되었습니다."
        }
        failure {
            echo "CI/CD 파이프라인 실패! 로그를 확인해 주세요."
        }
    }
}
