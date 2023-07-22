pipeline{

    agent any

    stages{

        stage("git checkout"){

            steps{
                git branch: 'main', url: 'https://github.com/clemenrance/TEST-PROJECT.git'
            }
        }
        stage("Unit Test"){

            steps{
                sh 'mvn test'
            }
        }
        stage("Integration Test"){

            steps{
                sh 'mvn verify -DskipUnitTests'
            }
        }
        stage("Maven Build"){

            steps{
                sh 'mvn clean install'
            }
        }
        stage("Static Test Analysis in Sonarqube"){

            steps{

                script{
                    withSonarQubeEnv(credentialsId: 'sonar-auth'){  
                    sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
        stage("Quality gate analysis"){
            
            steps{

                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-auth'
                }
            }
        }
        stage("Deploying to tomcat"){

            steps{
                    sshagent(['tomcat-ssh']){  
                    sh 'scp -o StrictHostKeyChecking=no /root/.jenkins/workspace/kube/webapp/target/webapp.war ubuntu@172.31.8.109:/var/lib/tomcat9/webapps'
                }
            }
         }
         stage("Docker Image Build"){

            steps{
                sh 'docker build -t $JOB_NAME:v1.$BUILD_ID .'
                sh 'docker tag $JOB_NAME:v1.$BUILD_ID clemenrance/$JOB_NAME:v1.$BUILD_ID'
                sh 'docker tag $JOB_NAME:v1.$BUILD_ID clemenrance/$JOB_NAME:latest'
            }
         }
         stage("Pushing Image to dockerub"){

            steps{

                script{
                    withCredentials([string(credentialsId: 'docker-login', variable: 'docker-hub')]){
                        sh 'docker login -u clemenrance -p ${docker-hub}'
                        sh 'docker push clemenrance/$JOB_NAME:v1.$BUILD_ID'
                        sh 'docker push clemenrance/$JOB_NAME:v1.latest'
                    }
                }
            }
         }
    }
}