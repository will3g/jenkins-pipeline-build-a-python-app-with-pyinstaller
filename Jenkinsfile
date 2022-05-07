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
                    image 'qnib/pytest'
                }
            }
            steps {
                sh 'export PYTHONPATH=$WORKSPACE:$PYTHONPATH && py.test --junit-xml tests/results.xml tests/test_app.py'
                stash(name: 'full-directory', includes: '.') 
            }
            post {
                always {
                    junit 'tests/results.xml'
                }
            }
        }
    }
}