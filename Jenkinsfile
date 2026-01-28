@Library('Shared') _
pipeline {
    agent any
    
    environment {
        SONAR_HOME = tool "Sonar"
    }

    parameters {
        string(name: "IMAGE_VERSION", defaultValue: 'latest', description: 'IMAGE tag')
    }

    stages {

        stage("Code Clone") {
            steps {
                script{
                   codeClone("https://github.com/leuvanikita/Springboot-BankApp.git", 'demo')
                }
            }
        }

        stage("Sonar Quality") {
            steps {
                script{
                    sonarQubeAnalysis("Sonar", "bankapp", "bankapp")
                }
            }
        }

        stage("OWASP Dependency Check") {
            steps {
                script{
                    owaspDepencency()
                }
            }
        }

        stage("Sonar Quality Gate Scan") {
            steps {
                script{
                    sonarCodeQuality()
                }
            }
        }

        stage("Trivy File System Scan") {
            steps {
                script{
                    trivyScan()
                }
            }
        }

        stage("Code Build") {
            steps {
                script{
                    dockerBuild("bankapp", "${params.IMAGE_VERSION}")
                }
            }
        }

        stage("DockerHub Push") {
            steps {
                script{
                    dockerPush("bankapp", "${params.IMAGE_VERSION}")
                }
            }
        }
    }// stages

    post{
        success{
            script{
                emailText("Successful", "success")
            }
        }
        
        failure{
            script{
                emailText("Failure", "failed")
            }
        }
    }// post
}// pipeline
