pipeline {
    agent any
    environment {
        NGINX_CONF_PATH = "/etc/nginx/sites-available/default"
        NGINX_CONF = "/etc/nginx/nginx.conf"
        NGINX_RELOAD_CMD = "sudo nginx -s reload"
    }
    stages {
        stage('git branch') {
            steps {
                sh """
                pwd 
                if [[ -e spring-petclinic ]]              
                then
                    rm -r spring-petclinic
                fi
                """
                git branch: "main", url: "https://github.com/spring-projects/spring-petclinic.git"
            }
        }
        stage('Build') {
            steps {
                sh """
                #!/bin/bash

                # edit PetClinicApplication
                sed -i '/import org.springframework.web.servlet.i18n.SessionLocaleResolver;/a import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;' /home/pet-clinic/.jenkins/workspace/pet-clinic/src/main/java/org/springframework/samples/petclinic/PetClinicApplication.java
                sed -i 's/public class PetClinicApplication {/public class PetClinicApplication extends SpringBootServletInitializer {/' /home/pet-clinic/.jenkins/workspace/pet-clinic/src/main/java/org/springframework/samples/petclinic/PetClinicApplication.java

                # edit pom.xml
                sed -i '/<\\/parent>/a <packaging>war<\\/packaging>' /home/pet-clinic/.jenkins/workspace/pet-clinic/pom.xml
                sed -i '0,/<\\/dependencies>/s#</dependencies>#<dependency>\\n    <groupId>org.springframework.boot</groupId>\\n    <artifactId>spring-boot-starter-tomcat</artifactId>\\n    <scope>provided</scope>\\n</dependency></dependencies>#' /home/pet-clinic/.jenkins/workspace/pet-clinic/pom.xml

                ./mvnw spring-javaformat:apply
                ./mvnw clean package
                """
            }
        }
        stage('Deploy To Blue')
        {
            steps {
                script{
                
                    sh """
                    cp /home/pet-clinic/.jenkins/workspace/pet-clinic/target/spring-petclinic-3.3.0-SNAPSHOT.war ~/apache-tomcat-10.1.24/webapps/ 
                    cp /home/pet-clinic/.jenkins/workspace/pet-clinic/target/spring-petclinic-3.3.0-SNAPSHOT.war ~/instance1/webapps/   
                    /home/pet-clinic/startup1.sh 
                    """
                }    
            }
        }
        stage('Test Green Deployment') {
            steps {
                script {
                    sh '''
                    PORT_FILE="/tmp/current_port"

                    # Ensure the port file exists and has the correct initial port
                    if [ ! -f "$PORT_FILE" ]; then
                        echo "9092" > "$PORT_FILE"
                    fi

                    # Read the current port
                    green=$(cat $PORT_FILE)

                    # Check the server status on the current port
                    status=$(curl -Is http://localhost:$green/spring-petclinic-3.3.0-SNAPSHOT/ | head -n 1 | awk '{print $2}')

                    # Switch traffic if the server is running
                    if [ "$status" = "200" ]; then
                        echo "Running"
                        echo 'Switching traffic to Green environment...'
                        # Rotate colors in the NGINX configuration
                        sudo sed -i 's/blue/yellow/' $NGINX_CONF
                        sudo sed -i 's/green/blue/' $NGINX_CONF
                        sudo sed -i 's/yellow/green/' $NGINX_CONF

                        # Reload NGINX to apply changes
                        $NGINX_RELOAD_CMD

                        # Toggle the port for the next check
                        if [ "$green" = "9092" ]; then
                          sudo  echo "9091" > $PORT_FILE
                        else
                          sudo echo "9092" > $PORT_FILE
                        fi
                    else
                        echo "Down"
                    fi
                    '''
                }
            }    
        }
        stage('Deployment to Green'){
            steps{
                sh """
                cp /home/pet-clinic/.jenkins/workspace/pet-clinic/target/spring-petclinic-3.3.0-SNAPSHOT.war ~/instance2/webapps/
                /home/pet-clinic/startup2.sh 

                """
            }
        }
        
    }
}