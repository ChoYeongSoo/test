pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                // 이전에 등록한 Credentials ID로 변경합니다.
                // ID: 4686584f-72c9-4616-b9fc-d0272a5059fb
                sshagent(credentials: ['4686584f-72c9-4616-b9fc-d0272a5059fb']) {
                    sh "ssh -o StrictHostKeyChecking=no root@192.168.10.94 'ansible-playbook /etc/ansible/test/monitor_ci_setup.yml'"
                }
            }
        }
    }
}
