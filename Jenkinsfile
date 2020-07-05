node {
    def app
    environment {
        app-name = 'stay-home'
        env = 'cicd'
        aws_region = 'us-east-1'
        start_cidr = '11.10'
        domain = "kesavadomain.com"
        product_code = "devops"
        env_size = "xsmall" 
        docker_url = "740500311035.dkr.ecr.us-east-1.amazonaws.com"       
    }    
    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
    }

    stage('Build image') {
        dir('app') {
            app = docker.build("kesavadocker/${app-name}")
        }
    }

    stage('Push image') {
        docker.withRegistry(docker_url, 'ecr:us-east-1:aws_admin') {
            //app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

}

