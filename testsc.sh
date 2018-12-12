#!/bin/bash
#Run bulid commamd to make sure bulid is up to date
docker build -t arikps/piex .
docker-compose build
sleep 1s
#Checks if app passing unitests
if docker run -t arikps/piex npm test | exit 1 ; then
echo Error!! app did not passed unit tests - fix the issue and run the script again && exit
else
docker run -t arikps/piex npm test
sleep 1s
fi
#Initializing docker compse image
docker-compose up -d
sleep 1s
#Run docker ps command to verify the containers
docker ps
sleep 1s
#Check for currect response
CURL_CHECK="localhost:8081"
req_code=$(curl -Is --head "$CURL_CHECK" | grep -F -o "HTTP/1.1 200 OK")
req_test="HTTP/1.1 201 OK"
echo
if [ "$req_code" != "$req_test" ]; then
    echo Error!! app is not working!! fix the issue and run the script again && exit
else [ "$req_code" = "$req_test" ]
    echo -e "$req_code...SUCCESS!\nWill push it now to Docker Hub..."
fi
sleep 1s
printf Pushing to Docker hub
docker push arikps/piex
echo "DONE :)"
