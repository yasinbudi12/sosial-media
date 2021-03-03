pipeline {
    
    agent any
        
    stages {
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                sh 'docker build -t yasinbudi12/coba:$BUILD_NUMBER .'
            }
        }
        stage('Push Image to Docker hub') {
            when {
                branch 'master'
            }
            steps {
                //withCredentials([string(credentialsId: 'docker_pwd', variable: 'dockerHubPwd')]) {
                  //  sh "docker login -u mcpidinfra -p ${dockerHubPwd}"
                //}
                sh 'docker push yasinbudi12/coba:$BUILD_NUMBER'
            }
        }
        stage('Deploy to Server ') {
            agent { node { label 'worker1' } }
            when {
                branch 'master'
            }
            steps {
                //withCredentials([string(credentialsId: 'docker_pwd', variable: 'dockerHubPwd')]) {
                   // sh "docker login -u $DOCKER_USER -p ${dockerHubPwd}"
                //}
                checkout scm
                sh """
                docker pull yasinbudi12/coba:$BUILD_NUMBER'
		docker run -p 10000:80 -d yasinbudi12/coba:$BUILD_NUMBER'
		"""
            }      
        }
        stage('Remove docker image last build Dev') {
            when {
                branch 'master'
            }
            steps {
                sh 'docker rmi yasinbudi12:coba/$DOCKER_IMAGE: '
            }      
        }
        stage('Git') {
            steps {
                step([$class: 'WsCleanup'])
                checkout scm
            }
        }      
    }  
}
