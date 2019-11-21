pipeline {
    environment {
    PROJECT = "qpathways-dev"
    APP_NAME = "otc"
    CLUSTER = "k8-qore-qpathways"
    CLUSTER_ZONE = "us-central1-a"
    IMAGE_TAG = "gcr.io/${PROJECT}/${APP_NAME}:$GIT_COMMIT"
    mailRecipients = "bhakti.bhoj@triarqhealth.com, pbedse@triarqhealth.com, rohini.kulthe@triarqhealth.com, bharat.bhamare@triarqhealth.com, prasad.jejurkar@triarqhealth.com, akshay.aachat@triarqhealth.com, swapnil.ahire@triarqhealth.com "
  }
    agent any
    
    options {
        office365ConnectorWebhooks([[
                    name: 'Jenkins', 
                    startNotification: false,
                    notifySuccess: true,
                    notifyAborted: false,
                    notifyNotBuilt: false,
                    notifyUnstable: true,
                    notifyFailure: true,
                    notifyBackToNormal: true,
                    notifyRepeatedFailure: true,
                    timeout: '30000',
                        url: 'https://outlook.office.com/webhook/c48120dd-e29d-4370-ae0d-44a396a4a9cf@ed5aa67c-a279-4761-9249-c2dbe036b286/JenkinsCI/c7553a61fa3849d1b5cc9d19cf126306/dd0bb37d-0eb4-48bc-9742-d11794f27015'
            ]]
        ) 
    }
    stages {
        stage('Sonar-scan') {
            steps {
                echo 'Scanning code..'
		
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
                sh 'docker login -u _json_key --password-stdin https://gcr.io < /opt/qpathways-dev-1a816bc22fdb.json'
			          sh 'docker push ${IMAGE_TAG}'
            }
        }
          stage('Rolling Update') {
            steps {
                echo 'gcp rolling update....'
		        sh 'gcloud container clusters get-credentials k8-qore-qpathways --zone us-central1-a --project qpathways-dev'
            sh 'kubectl set image -n default deployment.v1beta1.extensions/otc otcservices=${IMAGE_TAG}'
            }
        }
	    
    }
	
	
}


