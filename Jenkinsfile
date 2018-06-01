pipeline {
  agent any
  stages {
    stage('Build base berryconda') {
      steps {
        sh 'docker build --pull --rm -t lulusys/rpiconda:latest .'
        sh 'docker run --rm lulusys/rpiconda:latest conda info'
      }
    }
    stage('Build opencv') {
      steps{
        sh '''
          docker build --pull --rm -t lulusys/rpiconda:opencv -f Dockerfile.opencv .
          wpyt=$(docker run --rm lulusys/rpiconda:opencv /bin/bash -c "which python")
          if [ "$wpyt" != "/opt/miniconda3/envs/opencv/bin/python" ]; then
            exit 1
          fi
        '''
      }
    }
    stage('Push') {
      steps{
        withDockerRegistry([url: '', credentialsId: 'dockerhub']) {
          sh 'docker push lulusys/rpiconda:latest'
          sh 'docker push lulusys/rpiconda:opencv'
        }
      }
    }
  }
}
