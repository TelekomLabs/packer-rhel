# Packer Image Builder for RHEL Family (RedHat, CentOS, Oracle Linux)

## Introduction

This packer templates create vagrant, vmware and kvm images of RedHat 6, CentOS 6 and Oracle Linux 6. The templates support VirtualBox, VmWare and KVM. The kvm images, also run in OpenStack. 

The OS versions are:

 - RedHat 6.6
 - Centos 6.6
 - Oracle Linux 6.6

For all operating systems we generate images for 

 - Virtual Box (user: packer/packer)
 - VmWare (user: packer/packer)
 - OpenStack

This template only is tested against 64 bit systems. 

## Requirements

The templates are only tested with [packer](http://www.packer.io/downloads.html) 0.5.2 and later.

## Run conversion process

    # Build CentOS virtualbox image
    PACKER_LOG=1 packer build -only="centos-6-vbox" packer-centos-6.json

    # Build Oracle Linux virtualbox image
    PACKER_LOG=1 packer build -only="oel-6-vbox" packer-oel-6.json

## Build cloud images for openstack

### CentOS

    # Build CentOS openstack image and compress qcow2 image before 
    # upload (normally from 4.5 GB to less than 500 MB)
    packer build -only="centos-6-cloud-kvm" packer-centos-6.json

    # Reduce the file size
    qemu-img convert -c -f qcow2 -O qcow2 -o cluster_size=2M img_centos_6_openstack/centos6_openstack.qcow2 img_centos_6_openstack/centos6_openstack_compressed.qcow2

    # Upload the file to open stack
    glance image-create --name "CentOS 6.5" --container-format ovf --disk-format qcow2 --file img_centos_6_openstack/centos6_openstack_compressed.qcow2 --is-public True --progress

### Oracle Linux

    # Build Oracle Linux openstack image and compress qcow2 image before 
    packer build -only="oel-6-cloud-kvm" packer-oel-6.json
    
    # Reduce the file size
    qemu-img convert -c -f qcow2 -O qcow2 -o cluster_size=2M img_oel_6_openstack/oel6_openstack.qcow2 img_oel_6_openstack/oel6_openstack_compressed.qcow2
    
    # Upload the file to open stack
    glance image-create --name "OEL 6.5" --container-format ovf --disk-format qcow2 --file img_oel_6_openstack/centos6_openstack_compressed.qcow2 --is-public True --progress

### RedHat

Before you start with RedHat you need a valid subscription to download the latest iso image. Update the `iso_url` parameter in rhel6.json accordingly. Additionally you need to modify the file `scripts/rhn_reg` with your user credentials to recieve yum updates during the packer run.

    # Build RedHat openstack image
    packer build -only="rhel-6-cloud-kvm" packer-rhel-6.json

    # Reduce the file size
    qemu-img convert -c -f qcow2 -O qcow2 -o cluster_size=2M rhel6_openstack.qcow2 rhel6_openstack_compressed.qcow2

    # Upload the file to open stack
    glance image-create --name "RedHat 6.5" --container-format ovf --disk-format qcow2 --file rhel6_openstack_compressed.qcow2 --is-public True --progress


## Issues during build time

If you experience issues with packer, please use `PACKER_LOG=1 packer ... ` to find the errors.

## Author

 - Author:: Christoph Hartmann (<chris@lollyrock.com>)

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
