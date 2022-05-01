pipeline {
    agent none 
    stages {
        stage('Build') { 
            agent {
                docker {
                    image 'python:3' 
                }
            }
            steps {
                sh 'python -m py_compile src/app.py' 
                stash(name: 'compiled-results', includes: 'src/*.py*') 
            }
        }
        stage('Test') {
            agent {
                docker {
                    image 'ubuntu:18.04'
                }
            }
            steps {
                sh 'apt install -y python-pip && pip install -y virtualenv && virtualenv venv -p python3 && source venv/bin/activate && export PYTHONPATH=src && pytest --junit-xml test-reports/results.xml tests/test_app.py'
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
    }
}