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
                    image 'grihabor/pytest:python3.7-alpine'
                }
            }
            steps {
                withEnv(["HOME=${env.WORKSPACE}"]) {
                    sh 'pip install --user -r requirements.txt'
                    sh 'ls && export PYTHONPATH=. && py.test --junit-xml tests/results.xml tests/test_app.py'
                }
            }
            post {
                always {
                    junit 'tests/results.xml'
                }
            }
        }
    }
}