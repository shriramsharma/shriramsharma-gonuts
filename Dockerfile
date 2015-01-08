FROM shriramsharma/basedocker
MAINTAINER Shriram Sharma "shriram.sharma22@gmail.com"

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get update

RUN apt-get install -q -y CMake
RUN apt-get install -q -y build-essential
RUN apt-get install -q -y mercurial python python-dev python3 python3-dev ruby ruby-dev libx11-dev libxt-dev libgtk2.0-dev  libncurses5  ncurses-dev
RUN apt-get install -q -y wget

# Configure GOLANG
RUN mkdir -p /usr/local/go
RUN mkdir -p /root/go
WORKDIR /usr/local/go
RUN wget https://storage.googleapis.com/golang/go1.4.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go1.4.linux-amd64.tar.gz
WORKDIR /root

# COPY OVER THE DOTFILES
ADD dotfiles/* /root/

# SETUP VIM
RUN apt-get install -q -y vim
RUN mkdir -p /root/.vim/bundle
RUN mkdir -p /root/.vim/colors
WORKDIR /root/.vim/bundle
RUN git clone https://github.com/gmarik/Vundle.vim.git
RUN vim +PluginInstall +GoInstallBinaries +qall
WORKDIR /root

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
