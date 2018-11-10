# Image for execution UI tests (node.js example)

*Pull the image*

``
docker pull iklymchuk/node-chrome
``

*Run container*

-v we are using for moving our tests to the container

``
    docker run -d \
        -v `pwd`:/test \
        -e DISPLAY=:1.0 \
        --name node-chrome \
        --publish 5900:5900 \
        --env VNC_SERVER_PASSWORD=password \
        --user test \
        --privileged \
        iklymchuk/node-chrome
``

*Connect to the container via VNC*

We can use any VNC viewer and connect to the container use:

``
localhost:5900
``

and type the password - "password"

*Interacting with container*

Our source of tests are located inside test dir so if we'd like to install dependencies:

``
docker exec -t node-chrome bash -c "cd test;npm i"
``

and execute tests:

``
docker exec -t node-chrome bash -c "cd test;npm test"
``