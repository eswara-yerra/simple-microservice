node {
      def service-name = 'stay-home'
      def env = 'dev'
      def aws_region = 'us-east-1'
      def start_cidr = '11.10'
      def domain = "kesavadomain.com"
      def product_code = "devops"
      def env_size = "xsmall" 
      def aws_account_no = "740500311035"
      def docker_reg_url = "https://${aws_account_no}.dkr.ecr.${aws_region}.amazonaws.com"   
      def image_tag  = "${env}-${service-name}:1.0.${BUILD_NUMBER}"

      stage("Checkout") {
        checkout scm
      }

      stage("Provision Infra") {
        dir('terraform') {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-id', ACCESS_KEY: 'ACCESS_KEY', SECRET_KEY: 'SECRET_KEY']]) {
                sh "./terraform.sh apply ${env} setup ${aws_region}"
                sh "./terraform.sh apply ${env} infra ${aws_region}"
            }
        }
      }

      stage("Docker build") {
        dir('app') {
            sh "docker build -t kesava/app:${BUILD_NUMBER} ."
        }
      }

      stage("Docker push") {
        docker.withRegistry(docker_reg_url, "ecr:us-east-1:aws-ecr") {
          docker.image("repo:${image_tag}").push(image_tag)
        }
      }


      stage("Deploy") {
        dir('terraform') {
            withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-id', ACCESS_KEY: 'ACCESS_KEY', SECRET_KEY: 'SECRET_KEY']]) {
                sh "./terraform.sh apply ${env} apps ${aws_region}"
            }
        }          
      }

} 

