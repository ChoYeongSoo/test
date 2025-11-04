pipeline {
    agent any
    stages {
        stage('Deploy') {
            steps {
                sh "ssh -o StrictHostKeyChecking=no root@192.168.10.94 'ansible-playbook /etc/ansible/test/monitor_ci_setup.yml'"
            }
        }
    }
}
