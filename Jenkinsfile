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
                sh 'pip install virtualenv --user && virtualenv venv -p python3 && source venv/bin/activate'
                sh 'pip install -r requirements.txt --user'
                sh 'ls && export PYTHONPATH=. && py.test --junit-xml tests/results.xml tests/test_app.py'
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