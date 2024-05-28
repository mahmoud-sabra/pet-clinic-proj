#!/bin/bash

status=`curl -Is http://localhost:9090/spring-petclinic-3.2.0-SNAPSHOT/ | head -n 1 | cut -d ' ' -f 2`

if test `echo $status` == "200"
then
{
        echo "Running"
}
else
{
        echo "Down"
}
fi
