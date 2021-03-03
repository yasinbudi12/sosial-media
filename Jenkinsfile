pipeline {
    parameters {
        string(name: 'DEVELOPMENT_NAMESPACE',      description: 'Development Namespace',                defaultValue: 'namespace')
        string(name: 'DOCKER_IMAGE_NAME',          description: 'Docker Image Name',                    defaultValue: 'namaimage')
    }
    agent any
       triggers {
           pollSCM(env.BRANCH_NAME == 'master' ? '* * * * *' : '* * * * *')
    }
    stages {
        stage('Checkout SCM') {
            steps {
                script{
                    sh 'rm -Rf *'
                }
                checkout scm
                script {
                    echo "get COMMIT_ID"
                    sh 'echo -n $(git rev-parse --short HEAD) > ./commit-id'
                    commitId = readFile('./commit-id')
                }
                stash(name: 'ws', includes:'**,./commit-id') // stash this current 
            }
        }
        stage('Initialize') {
            steps {
                script{
                            if ( env.BRANCH_NAME == 'master' ){
				    projectKubernetes= "${params.PRODUCTION_NAMESPACE}"
                                envStage = "production"
                            }else if ( env.BRANCH_NAME == 'development'){
				projectKubernetes= "${params.DEVELOPMENT_NAMESPACE}"
                                envStage = "development"
                    }
                    echo "${projectKubernetes}"
                } 
            }
        }
        stage('Build Docker') {
            steps {
                script{
                    sh "docker build . -t rizalkemas68/socialmedia:$BUILD_NUMBER"
                    sh "docker push rizalkemas68/socialmedia:$BUILD_NUMBER"
                }
            }
        }
       stage('Deploy') {
            steps {
              script{
                  echo "Deploy"
              }
            }
        }
    }
post {
        always{
          	 sh  "ls"
        }
       }
}
