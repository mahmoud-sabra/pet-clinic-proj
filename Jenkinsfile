pipeline {
    agent any

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
        stage('CI') {
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
        stage('CD'){
            steps{
                sh """
                cp /home/pet-clinic/.jenkins/workspace/pet-clinic/target/spring-petclinic-3.2.0-SNAPSHOT.war ~/apache-tomcat-10.1.24/webapps/ 
                """
            }
        }
      
    }
}