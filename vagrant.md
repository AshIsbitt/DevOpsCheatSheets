# VAGRANT

This is a tool from Hashicorp commonly used to easily create and automate virtual machines, and will work within tools such as MS Hyper-V or VagrantBox

- Highly customisable 
- Connects to the big Cloud providers (MSA, AWS, GCP)
- Config files are called Vagrantfiles
- Works with Docker

`brew install vagrant` will install Vagrant on mac, but you can also install it from the website.

Best practice is to create a folder on your host machine to store your vagrantfiles.
Inside that folder, do `vagrant init` to create a vagrantfile

The Vagrantfile has a large number of comments throughout it, to explain what it's doing. 

`config.vm.box = "hashicorp/bionic64"` - This is the specific VM "box" that the vagrantfile specifies. These boxes can be sourced from the hashicorp website. Bionic64 is an installation of Ubuntu.

Uncomment line 40 `config.vm.network "public_network"` to allow the VM to have a bridged network, so you can connect via IP to the VM

Line 46 of the vagrantfile `config.vm.synced_folder "../data", "/vagrant_data"` lets you sync a file over from your host to the VM when its created.

`vagrant up` will start the machine as provisioned

### Vagrant Provisioning
The easiest way to provision a file is to add the following line:
`config.vm.provision "shell", path: "script.sh"`
and then write all the shell commands needed into `script.sh`.

Note that the `path:` argument can take a file path, as well as a URL if you
are holding your sh script on gist or another location. 
