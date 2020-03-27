FROM ubuntu:19.10
MAINTAINER Kacper Kuźniarski <kacper.kuzniarski@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

# OS updates and install
RUN apt-get -qq update
RUN apt-get install curl python3 python3-pip git sudo zsh -qq -y
RUN pip3 install progress

# Create test user and add to sudoers
RUN useradd -m -s /bin/zsh tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
ADD . /home/tester/.dotfiles
RUN chown -R tester:tester /home/tester

# Switch testuser
USER tester
ENV HOME /home/tester

# Change working directory
WORKDIR /home/tester/.dotfiles

RUN python3 -u manage.py

# Run setup
CMD ["bin/bash"]
