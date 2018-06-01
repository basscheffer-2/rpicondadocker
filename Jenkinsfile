pipeline {
  agent any
  stages {
    stage('Build base berryconda') {
      steps {
        sh 'docker build -t lulusys/rpiconda:latest .'
        sh 'docker run --rm lulusys/rpiconda:latest conda info'
      }
    }
    stage('Build opencv') {
      steps{
        sh '''
          docker build -t lulusys/rpiconda:opencv -f Dockerfile.opencv .
          activenv=$(docker run --rm lulusys/rpiconda:opencv /bin/bash -c 'echo $CONDA_DEFAULT_ENV')
          if [ "$activenv" != 'opencv' ]; then
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
