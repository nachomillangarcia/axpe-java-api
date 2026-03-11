pipeline {
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                metadata:
                labels:
                    some-label: some-label-value
                spec:
                    serviceAccount: jenkins
                    containers:
                    - name: maven
                      image: maven:3.9.9-eclipse-temurin-17
                      command:
                      - cat
                      tty: true
                    - name: busybox
                      image: busybox
                      command:
                      - cat
                      tty: true
                '''
            retries 3
        }
    }

    stages {
        stage('Inspect Containers') {
            steps {
                container('maven') {
                    sh "mvn --version"
                    sh "java -version"
                    sh "env"
                    sh "ls -al"
                }

                container('busybox') {
                    sh 'env'
                    sh 'ls -al'
                }
            }
        }

        stage('Unit Tests'){
            steps{
                container('maven'){
                    sh 'mvn test -Dmaven.repo.local=$WORKSPACE/.m2/repository'
                    sh 'rm -r $WORKSPACE/.m2/repository'
                }
            }
        }
    }

}