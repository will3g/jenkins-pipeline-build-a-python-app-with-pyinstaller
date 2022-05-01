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
                    image 'python:3'
                }
            }
            steps {
                sh 'python3 -m venv env && python3 ./env/bin/activate && pip3 install --user flask pytest && export PYTHONPATH=src && pytest --junit-xml test-reports/results.xml tests/test_app.py'
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
    }
}