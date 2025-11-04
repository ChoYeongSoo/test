pipeline {
    agent any

    stages {
        stage('Declarative: Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Deploy') {
            steps {
                // Jenkins Credentials ID 'jenkins-ansible-key'를 사용하여 SSH 인증 수행
                sshagent(credentials: ['jenkins-ansible-key']) {
                    // 키 인증에 성공한 후, ssh 명령을 실행하여 Ansible Playbook 실행
                    sh "ssh -o StrictHostKeyChecking=no root@192.168.10.94 'ansible-playbook /etc/ansible/test/monitor_ci_setup.yml'"
                }
            }
        }
    }
}
