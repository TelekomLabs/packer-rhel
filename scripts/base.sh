yum -y update
yum -y install wget curl openssh-server

# Make ssh faster by not waiting on DNS
echo "UseDNS no" >> /etc/ssh/sshd_config
