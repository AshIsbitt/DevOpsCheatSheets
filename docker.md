Docker is used as a Container application. You can use it to create a single environment that will run the exact same, no matter what machine you are on. 
This lets you get around the issue of each machine having it's own configs and being set up differently by their users.

Containers - Isolated environments with their own processes, services, network interfaces, and mounts.
    Docker containers each share the same underlying kernel. This means that if the base OS is any version of Linux, Docker containers can hold any other version of linux they want.

Compared to VMs, Docker containers use less layers, meaning they are faster, and they are lightweight, taking up less storage space.

Using both containers and VMs together can be a benefit. You can use them together with no issues.

Most common applications have docker containerized versions up on the Docker store already.  

`docker run <tool>` will run a dockerised version of that tool, such as Ansible, mongodb, redis, nodejs. Running `docker run` with the same tool a second time will add a second instance of the tool, and you just need to load balance between the two to make full use of it.

Images - these are templates of tools or OSe and are used to create one or more containers. (Similar to the relationship between an object and a class - one image can create one or more containers)


