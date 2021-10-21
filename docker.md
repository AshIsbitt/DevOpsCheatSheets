Docker is used as a Container application. You can use it to create a single environment that will run the exact same, no matter what machine you are on. 
This lets you get around the issue of each machine having it's own configs and being set up differently by their users.

Containers - Isolated environments with their own processes, services, network interfaces, and mounts.
    Docker containers each share the same underlying kernel. This means that if the base OS is any version of Linux, Docker containers can hold any other version of linux they want.

Compared to VMs, Docker containers use less layers, meaning they are faster, and they are lightweight, taking up less storage space.

Using both containers and VMs together can be a benefit. You can use them together with no issues.

Most common applications have docker containerized versions up on the Docker store already.  

`docker run <tool>` will run a dockerised version of that tool, such as Ansible, mongodb, redis, nodejs. Running `docker run` with the same tool a second time will add a second instance of the tool, and you just need to load balance between the two to make full use of it.

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

Containers aren't meant to run an entire OS, even though there are OS images to download. runnign `docker run ubuntu` will generally close after a second
`docker run ubuntu sleep 100` - you can run a command in the container through the docker run
`docker exec <containerName> <command>` will also work, eg if you want to `cat` a file while the ubuntu image is up.

If you have a process that requires output, such as a webapp `docker run kodekloud/simple-webapp`, this will halt the terminal
    - you can run this process detatched by adding the `-d` flag to `docker run`
    - to then re-attach to the detatched process, do `docker attach <processID>`
