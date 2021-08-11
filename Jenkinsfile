pipeline {
    environment {
    PROJECT = "myfirst-devops-project"
    APP_NAME = "webapp"
    CLUSTER = "first-gke-cluster"
    CLUSTER_ZONE = "asia-south2-a"
    IMAGE_TAG = "asia.gcr.io/${PROJECT}/${APP_NAME}:$GIT_COMMIT"
  
  }
    agent any


    stages {
        stage('Build') {

            steps {
                echo 'Building..'
                
            }
        }
        
        stage('Quality Analysis') {
            steps {
               echo 'Run integration tests here...'
            }
        }
        stage('Docker Build and Publish Image') {
            steps {
                sh 'echo $GIT_BRANCH'
                sh 'echo $GIT_COMMIT'
                echo 'docker....'
                sh 'docker build -t ${IMAGE_TAG} .'
		sh 'docker push ${IMAGE_TAG}'
            }
        }
          stage('Rolling Update') {
            steps {
                echo 'gcp rolling update....'
	    sh 'gcloud container clusters get-credentials first-gke-cluster --region asia-south2 --project myfirst-devops-project'
            sh 'kubectl set image -n default deployment.v1beta1.extensions/webapp webapp=${IMAGE_TAG}'
            }
        }
	    
    }
}	
