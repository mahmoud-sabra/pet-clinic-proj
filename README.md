# Project README.md
## Summary

The project consists of six Ansible roles to automate the deployment and monitoring of a pet clinic application. These roles include:

1. **pet-clinic Role:**
   - This role adds a pet-clinic user and installs the Java Development Kit (JDK) into it.

2. **tomcat-install Role:**
   - Installs Apache Tomcat and configures it to run on port 9090.
   - Grants Tomcat access to its deployment manager.

3. **pomfile-edit Role:**
   - Edits the Spring PetClinic project's POM file to generate the WAR file correctly.

4. **build-app Role:**
   - Installs Maven and generates the WAR file for the Spring PetClinic application.

5. **deploy-run-tomcat Role:**
   - Copies the WAR file to the webapps directory of Tomcat.
   - Runs the Tomcat startup script to deploy the application.

6. **nagios Role:**
   - Installs and configures Nagios to monitor the pet clinic application.
## Prerequisites
### Note
```
All Installation handled by roles so don't worry about it.
```
1. **Install Ansible:**
   - Follow the official Ansible documentation to install it using the package manager: [Ansible Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

2. **Install Maven:**
   - Make Sure Maven  installed to build the Java application, If not don't worry we have role for that. 
   - You can refer to the official Apache Maven installation guide: [Maven Installation Guide](https://maven.apache.org/install.html)
3. **Install JDK**
   - JDK 17 Or higher Required.
4. **Clone the Project Repository:**
   - Clone the Pet Clinic project from the GitHub repository: [Pet Clinic Repository](https://github.com/mahmoud-sabra/pet-clinic)
   - Use the following command to clone the repository:
     ```
     git clone https://github.com/mahmoud-sabra/pet-clinic.git
     ```
   - Clone the Spring PetClinic application from the GitHub repository: [Spring PetClinic](https://github.com/spring-projects/spring-petclinic)
     ```
     git clone https://github.com/spring-projects/spring-petclinic.git
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
- in our case we user localhost
4. **Run the Playbook:**

```
ansible-playbook playbook.yml
```
5. **Navigate the project:**
```
You can then access the Petclinic at http://localhost:9090/spring-petclinic-3.2.0-SNAPSHOT/
add username tomcat
add password s3cret
```
6. **Automated Sanity Checks:**
   - Implement automated sanity checks using Ansible or shell scripting to verify the correctness of the deployment.
   - Include tests to validate the functionality of the deployed application.

5. **Configure Nagios to Monitor Tomcat Process:**
   - Write an Ansible playbook to configure Nagios for monitoring the Tomcat process.
   - Ensure proper monitoring thresholds and alerts are set up.

7. **Build and Deployment with Jenkins Pipeline:**
   - Create a Jenkins pipeline (Jenkinsfile) to automate the build and deployment process.
   - Integrate with version control (GitHub) for continuous integration.
