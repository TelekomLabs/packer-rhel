# Packer Image Builder for Ubuntu 12.04

## Instroduction

This repo started by using the [veewee templates](https://github.com/jedi4ever/veewee/tree/master/templates) for Centos OS. They have been adapted and improved. Furthermore the build machanism changed. Instead of maintaining multiple templates for RedHat, Centos and Oralce Linux we use the same scripts for all of them. Currently this templates support

 - RedHat 6.5
 - Centos 6.5
 - Oracle Linux 6.5

For all operating systems we generate images for 

 - Virtual Box
 - VmWare
 - OpenStack

This template only is tested against 64 bit systems. 

## Packer

The templates are only tested with [packer](http://www.packer.io/downloads.html) 0.5.2 and later.

## Run converison process

    # Build CentOS virtualbox image
    PACKER_LOG=1 packer build -only="centos-65-vbox" rhel65.json

    # Build Oracle Linux virtualbox image
    PACKER_LOG=1 packer build -only="oel-65-vbox" rhel65.json

## Install packer on Ubuntu

### Install packer

    cd ~
    apt-get install -y unzip
    mkdir packer
    cd packer
    wget https://dl.bintray.com/mitchellh/packer/0.5.2_linux_amd64.zip
    unzip 0.5.2_linux_amd64.zip
    echo "export PATH=\$PATH:~/packer/" >> ~/.bashrc
    source ~/.bashrc

### Install virtualbox

    echo "deb http://download.virtualbox.org/virtualbox/debian saucy contrib" >> /etc/apt/sources.list
    wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
    sudo apt-get update
    sudo apt-get install -y virtualbox-4.3


## Convert the image for OpenStack

    apt-get install -y qemu-system
    qemu-img convert -f vmdk -O qcow2 centos65.dsk centos65.qcow2


# License

Company: Deutsche Telekom AG

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
