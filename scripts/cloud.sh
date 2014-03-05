# to install the following packages, epel is required

# Installs cloudinit and heat-cfntools
yum -y install perl python python-setuptools cloud-init python-pip
pip-python install argparse 'boto==2.5.2' heat-cfntools
cfn-create-aws-symlinks --source /usr/bin
