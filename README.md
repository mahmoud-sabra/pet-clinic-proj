# Blue-Green Deployment With Pet-clinic Project
## Description
- Install Tomcat and its pre-requisites and configure Tomcat to have access to its deployment manager using Ansible.
- Install Nagios, Jenkins, and Nginx using Ansible.
- Build the application https://github.com/spring-projects/spring-petclinic using shell scripting  and Jenkins to generate a WAR file.
- Build and Configure Blue-Green deployment to Tomcat using the Jenkins pipeline.
- Configure Nagios to monitor Tomcat.
## Summary
The project uses Ansible roles to automate Blue-Green deployment and monitoring of a pet clinic application.

1. **pet-clinic Role:**
   - Creates a pet-clinic user and installs the Java Development Kit (JDK).

2. **tomcat-install Role:**
   - Installs Apache Tomcat and configures it to run on ports 9091 and 9092 for high availability.
   - Grants Tomcat access to the deployment manager.
   
3. **nginx Role:**
   - Installs Nginx and configures it as a reverse proxy.

4. **jenkins Role:**
   - Installs and runs Jenkins.

5. **nagios Role:**
   - Installs and configures Nagios to monitor the pet clinic application.

## **Tools Used:**
- Linux
- Nginx
- Java
- Ansible
- Apache-Tomcat
- Jenkins
- Nagios


## Prerequisites

 **Install Ansible:**
   - Follow the official Ansible documentation to install it using the package manager: [Ansible Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
   - Or You can Follow me
```
     sudo apt update
     sudo apt install software-properties-common
     sudo add-apt-repository --yes --update ppa:ansible/ansible
     sudo apt install ansible
```

## Setup/Installation

1. **Clone the Repository:**

```
git clone https://github.com/mahmoud-sabra/pet-clinic-project.git
```
2. **Navigate to the Project Directory:**

```
cd pet-clinic-project
```
3. **Update Inventory File:**
- Ensure the `inventory` file in the project directory contains the appropriate host(s) where you want to deploy the Pet Clinic application.
- in our case we use localhost
4. **Run the Playbook:**

```
ansible-playbook playbook.yml
```
5. **After Running:**
![image](https://github.com/mahmoud-sabra/pet-clinic-proj/assets/52472369/497d84dd-2eff-4a6e-b82c-c62402598255)
> You can see that there are two instances of tomcat that we will deploy our app into them
> JDK installed and Sanity check we will discuss below

5. **Deploy using Jenkins:**
```
You can then access the Jenkins at http://localhost:8080
add a username && password
```

1. **Create a new item**

![image](https://github.com/mahmoud-sabra/pet-clinic-proj/assets/52472369/b076c707-f89b-4da1-9c7d-f66f1e29f7a6)

2. **Pipeline with pet-clinic name** 
![image](https://github.com/mahmoud-sabra/pet-clinic-proj/assets/52472369/22d2857b-32ac-4fa8-9399-58f6d8c3aaa3)

3. **Copy the content of the Jenkinsfile into it** 
![image](https://github.com/mahmoud-sabra/pet-clinic-proj/assets/52472369/1be7aac0-d9fb-4cdb-9d9c-d66c66dc3562)

**then save and run!**

![image](https://github.com/mahmoud-sabra/pet-clinic-proj/assets/52472369/c3048a9e-f0fd-467c-a234-9fe46178f19c)



6. **Configure Nagios to Monitor Tomcat Process:**
   - Implemented playbook configure Nagios for monitoring the Tomcat process.
     for Nginx, instance1, and instance2.
     ![d2a9b7d9-984f-4958-a7a7-421ba51231ff](https://github.com/mahmoud-sabra/pet-clinic-proj/assets/52472369/4159811e-2519-4735-a6e5-a14d4785c3b6)

   

7. **Roll back and automated sanity check:**
 - Include tests to validate the functionality of the deployed application using cron job.
   ```
   crontab -e
   * * * * * ~/sanity-check.sh >> sanity-check.log
   ```
   if there is an error it will roll back to the latest stable one
   ![image](https://github.com/mahmoud-sabra/pet-clinic-proj/assets/52472369/5c3aa45b-549b-41a9-876f-6e22c82555f9)

     
