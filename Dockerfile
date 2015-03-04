# 此镜像用于构建ubuntu server  的中国版本，主要包括时区及源设置。如需要构建
# FROM的版本号及sources.list的内容。并同步修改build文件。

FROM phusion/baseimage:0.9.16
MAINTAINER Beta CZ <hlj8080@gmail.com>

ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Set the software sources to the fastest server.
COPY sources.list /etc/apt/sources.list

# install Ansible, from https://github.com/ansible/ansible-docker-base
RUN apt-get -y update && apt-get install -y python-yaml \
  python-jinja2 \
  python-httplib2 \
  python-keyczar \
  python-paramiko \
  python-setuptools \
  python-pkg-resources \
  git \
  python-pip

RUN mkdir /etc/ansible/
RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
RUN pip install ansible

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Change the timezone
RUN cp -f /usr/share/zoneinfo/PRC /etc/localtime
