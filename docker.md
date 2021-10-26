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

### Networking in Docker
Three networks are created when Docker is installed: Bridge, Null, Host.
Standard `docker run` is on the bridge network, but adding the `--network=` flag you can specify which of the other two you use

- Using the Bridge means that it's all stored in it's own little box, meaning that the ports in the docker container are different to the ports outside - it's own little sub network
- Using the host network means that it's accessible without being containerised, meaning the ports are accessible on your local network
    - You can't then run multiple containers on the same port.
- Using the none network means that the container is isolated and can't use any port access at all.

`docker network create --driver <network_type> --subnet <IP> custom-isolated-network` is used to create a unique sub-network
`docker network ls` will show all networks

Under `docker inspect`, you can see the bridge and network data

Docker has it's own built-in DNS server
    - This is at `127.0.0.11`

### Docker Storage and file systems
THe file system is created at `/var/lib/docker` on your local machine, including downloaded containers, images, and volumes

If multiple dockerfiles use the same commands, they will reuse assets. FOr example, if you have `FROM Ubuntu` in multiple dockerfiles, once Ubuntu downloads once, other dockerfiles will reuse that same installation to save disk space

`docker volume create <folder_name>` - This is used to create a 'volume' for persistant storage
    - Mount the folder to the container by adding `<folder_name>:container/directory/location` to your docker run command
    - This is better/more verbose to be done like this: `docker run --mount type=bind, source=host/directory, target=/container/directory/location <container>`

### Docker Compose
A Docker Compose file is used to combine a number of different processes together
This is written into a single file using the YAML markup language, then run with a `docker-compose up`
A benefit over doing a series of `docker run` commands means that they're going to all be linked together as opposed to just being standalone containers
    - Although this can also be done by adding `--link name:<container_name>` to your `docker run` commands (This is a deprecated function though)

#### Writing an example Docker Compose
1 - Figure out how to get the images working with `docker run`:

```
docker run -d --name=redis redis
docker run -d --name=db postgres:9.4
docker run -d --name=vote -p 5000:80 --link redis:redis voting-app
docker run -d --name=result -p 5001:80 --link db:db result-app
docker run -d --name=worker --link db:db --link redis:redis worker
```

2- This can now become a single dockercompose.yml file
    - Create dictionaries with each of the container names in (--name=)
    - Set the image as a K/V pair underneath (the final section of each docker run)
    - Add port adjustment as a list under the image (5001:80)
    - Add links as a list (--link)

```
redis:
    image: redis
db:
    image: postgres:9.4
vote:
    image:voting-app
    ports:
        - 5000:80
    links:
        - redis
result:
    image:result-app
    links:
        - db
worker:
    image:worker
    ports:
        - 5001:80
    links:
        - db
        - redis
```

Then do `docker-compose up` to launch the whole stack.

If you have a local dockerfile instead of a hosted docker image already, you can replace the image line with a `build` command with a path to a dockerfile instead.
The above dockercompose file is written in version 1. To use version to, you have to specify `version:2` in the first line, and then add `services:` at the top and indent each line once more.
    - The benefit of this is that version 2 will automatically create a bridged network between the different images and links them all, so you can get rid of the `links` lines

Version 3 also supports `docker swarm` and has some other features added and removed.

#### Adding networks to dockercompose V2
```
version: 2
services
    redis:
        image: redis
        networks:
            - back-end
    db:
        image: postgres:9.4
        networks:
            - back-end
    vote:
        image:voting-app
        ports:
            - 5000:80
        networks:
            - front-end
            - back-end
    result:
        image:result-app
        networks:
            - front-end
            - back-end
    worker:
        image:worker
        ports:
            - 5001:80
        networks:
            - back-end
networks:
    front-end:
    back-end:
```

### Docker registry
`image: nginx`
What you're really saying here is `docker.io/nginx/nginx`
    - `docker.io` is the DNS repository of the docker hub registry 
    - The first `nginx` is like the user/account name
    - The second `nginx` is the image/repository name

Other registries include google's `gcr.io, which holds a number of k8s related images
You can also host your own registries, and AWS/Azure tend to provide registry hosts when you sign up with them

`docker login private-registry.io` - Allows you to login to your private registry. 
    - You can then write out a full `docker run` command using the above specification to create a container.

You can also host your own registry with a docker image provided by docker called `registry` instead of on a cloud platfrom.
`docker run registry -p 5000:5000 --name registry registry:2`
Then push your image to the private registry with `docker image tag <image_name> localhost:5000/<image_name>`
    - And follow this with a `docker push localhost:5000/<image_name>`

### Docker Engine
This is the name of what you install when you download Docker to a host. This contains:
    - Docker CLI - This doesn't have to be on the same host, and can interact with a remote docker engine using the `-H` flag
    - REST API
    - Docker Daemon - Background process that manages processes such as containers, images, networks

Docker uses namespaces to isolate workspaces, such as PID, unix timesharing, networks, and mounts
Docker uses 'cgroups' (Control groups) to limit the amount of hardware resources for each container
    - add `--cpus=` to your `docker run` to control this manually. This takes a float value ie .5
    - add `--memory=` to specify the amount of RAM your container has in mb (append 'm' to the end of the number)

### Container Orchestration
This is one host that holds multiple containers for a production environment
    - This is mostly used for data redundancy and to prevent issues with containers going down or similar issues.

`docker service create --replicas=100 nodejs` - This creates 100 identical nodeJS containers

Docker hosts allow you to scale up or down based on the needs of the users.
Additional hosts can also be added if they are required
Orchestration solutions also support advanced networking between hosts, as well as load balancing

Various Orchestration tools include:
    - Docker Swarm
    - Kubernetes - This is the most popular and well supported orchestration tool
    - Mesos

