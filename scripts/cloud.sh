# Installs cloudinit and heat-cfntools
# requires epel release

yum -y install perl python python-setuptools cloud-init python-pip
pip-python install argparse 'boto==2.5.2' heat-cfntools
cfn-create-aws-symlinks --source /usr/bin
