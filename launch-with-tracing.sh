#!/bin/bash

langchain-server & 

export LANGCHAIN_ENDPOINT=http://langchain-langchain-backend-1:8000
export LANGCHAIN_HANDLER=langchain

# Wait for the langchain backend container to come online
while ! docker ps | grep langchain-langchain-backend; do
    sleep 1s
done

# Little grace period
sleep 2s

# Connect this container to the langchain network
docker network connect langchain_default langchain-trace-and-test

jupyter notebook --allow-root

# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?