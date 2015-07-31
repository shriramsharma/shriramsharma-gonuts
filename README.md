# VIM+GO Dev Env
## For people who want *GOnuts*.

Sets you up with a GO development env with some useful VIM GO plugins inside of a docker container. This makes sure you have your favorite development env always with you even if you are using your spouse's laptop. ;)

####Mac users:
* Install [boot2Docker](https://github.com/boot2docker/osx-installer/releases)
* Once installed, launch boot2Docker.
  ![boot2Docker screen](img/boot2Docker.png)
* git clone https://github.com/shriramsharma/shriramsharma-gonuts.git
* Build docker image
  ``` docker build -t gonuts/gonuts . ```
* Run docker container. I am forwarding host port 2223 to container's default ssh port. You may specify any port you want.
  ``` docker run -d -p 2223:22 --name gonuts gonuts/gonuts ```
* Do ``` docker ps ``` to verify if the container is running.
  ![docker ps](img/dockerps.jpg)
