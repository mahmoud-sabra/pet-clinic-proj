#!/bin/bash
status=`curl -Is http://localhost:8000/spring-petclinic-3.3.0-SNAPSHOT/ | head -n 1 | cut -d ' ' -f 2`

if test `echo $status` == "200"
then
{
        echo "Running"
}
else
{
        echo "Down"
	echo 'Switching traffic to Blue environment...'
        # Rotate colors in the NGINX configuration
        sudo sed -i 's/blue/yellow/'  /etc/nginx/nginx.conf
	sudo sed -i 's/green/blue/'   /etc/nginx/nginx.conf
	sudo sed -i 's/yellow/green/' /etc/nginx/nginx.conf
	# Reload NGINX to apply changes
        sudo systemctl restart nginx
}
fi
