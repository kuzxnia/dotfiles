FROM ubuntu:19.10
MAINTAINER Kacper Kuźniarski <kacper.kuzniarski@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# OS updates and install
RUN apt-get -qq update
RUN apt-get install sudo python3 curl -qq -y

# Create test user and add to sudoers
RUN useradd -m -s /bin/bash tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
RUN chown -R tester:tester /home/tester

# Switch testuser
USER tester
ENV HOME /home/tester

RUN curl -sSL https://raw.githubusercontent.com/kuzxnia/dotfiles/master/manage.py | DEBUG=true python3 

# Run setup
CMD ["bin/bash"]
