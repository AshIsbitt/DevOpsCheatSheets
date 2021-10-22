Docker is used as a Container application. You can use it to create a single environment that will run the exact same, no matter what machine you are on. 
This lets you get around the issue of each machine having it's own configs and being set up differently by their users.

Containers - Isolated environments with their own processes, services, network interfaces, and mounts.
    Docker containers each share the same underlying kernel. This means that if the base OS is any version of Linux, Docker containers can hold any other version of linux they want.

Compared to VMs, Docker containers use less layers, meaning they are faster, and they are lightweight, taking up less storage space.

Using both containers and VMs together can be a benefit. You can use them together with no issues.

Most common applications have docker containerized versions up on the Docker store already.  

`docker run <tool>` will run a dockerised version of that tool, such as Ansible, mongodb, redis, nodejs. Running `docker run` with the same tool a second time will add a second instance of the tool, and you just need to load balance between the two to make full use of it.
    - `tool:version` will allow you to specify the version of the tool you want to use. default is `latest`
        -  Other tags are listed on the Docker Hub page for each image.
    - `-i` will allow you to accept user input if your script requires it (interactive mode)
    - `-t` will allow you to attach to the container's terminal, often used together with -i

Images - these are templates of tools or OSe and are used to create one or more containers. (Similar to the relationship between an object and a class - one image can create one or more containers)

### Commands
`sudo docker version` will show the version of docker you have installed

Download images from hub.docker.com (We're using whalesay as a demo)

`sudo docker run docker/whalesay cowsay hello world` will make a whale appear and say hello world

`docker ps` - show running containers with useful information
    - Add `-a` flag to see all non-running containers as well.
`docker stop <containerID/containerName>` - This stops the identified container
`docker rm <container>` - delete the container from the system. This is successful if the container name is returned
`docker images` - show all images on the host
`docker rmi <imageName>` - remove an image
`docker pull <image>` to download an image from the server
    - If you do `docker run` without the image downloaded, it'll also run `docker pull` first
`docker inspect <container>` will return all the details about a container in JSON format - this gives much more infromation than `docker ps` does
`docker logs <container>` will give you all the logs from when a container ran, even if it's run in detatched mode. 
`docker run -e ENV_VAR=value <container>` will let you set environment variables for a package
    - `docker inspec <container>` will let you see the set environment vars under the "config" section

Containers aren't meant to run an entire OS, even though there are OS images to download. runnign `docker run ubuntu` will generally close after a second
`docker run ubuntu sleep 100` - you can run a command in the container through the docker run
`docker exec <containerName> <command>` will also work, eg if you want to `cat` a file while the ubuntu image is up.

If you have a process that requires output, such as a webapp `docker run kodekloud/simple-webapp`, this will halt the terminal
    - you can run this process detatched by adding the `-d` flag to `docker run`
    - to then re-attach to the detatched process, do `docker attach <processID>`

#### Port mapping
`docker run -p port1:port2 <container>` - Port 1 is the port on localhost that you're going through. Port 2 is the internal port that you want to connect to. 

For example `sudo docker run -p 80:5000 simple-webapp` will allow you to go to the IP `192.168.1.5:80` to be able to reach port 5000 of the internal IP.

One benefit here is to run different applications on different ports, or different instances of the same on different ports, and they'll still be accessible concurrently.

#### Volume mapping
THis allows you to save data even when a container isn't running. Otherwise, when a container stops, it's data will be lost.
`docker run -v host/file/dir:/var/lib/mysql <mysql>`

### Creating your own image
- figure out the process to set the software up manually
    - each command and dependancy
    - copying files to the right place
    - Make sure the OS is there too

Step 1> Create a `Dockerfile` with all the pieces from the list of instructions
Step 2> `docker build Dockerfile -t <imageName>` - At this point, you're creating the name of the image
Step 3> `docker push <imageName>` - This pushes the new image to DockerHub

Dockerfiles take instructions and arguments
eg:

```
FROM Ubuntu

RUN apt-get update
RUN apt-get install python

RUN pip install flask
RUN pip install flask-mysql

COPY . /opt/source-code

ENTRTYPOINT FLASK_APP=/opt/source-code/app.py flask run
```

All Dockerfiles has to start with a FROM command, and needs to be based off another image (base OS images are common here)

`docker build Dockerfile -t <name>` is the command to build that dockerfile into an image.
Each layer is cached, so if it fails halfway through a build, you don't need to re-package the parts you've already done

Adding `CMD to the bottom of a dockerfile tells it commands to run.
    For example `CMD sleep 5` at the end of a dockerfile that only runs ubuntu would run the `sleep 5` command in the ubuntu terminal.l    You can also specify commands in a JSON format (think like a python list) `CMD ["sleep", "5"]`
You would use `ENTRYPOINT` to specify a command and then append a parameter in the `docker run` command.
    - You can set a default on the entrypoint by having a command line below it.
