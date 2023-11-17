#!/bin/bash

# Enable ssh password authentication
echo "Enable ssh password authentication"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/.*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl reload sshd

# Set Root password
echo "Set root password"
echo -e "admin\nadmin" | passwd root >/dev/null 2>&1

echo "Copying public key to root user"
sudo cp /home/vagrant/.ssh/authorized_keys /root/.ssh/authorized_keys
echo "The public key has been copied to /root/.ssh/authorized_keys"
systemctl reload sshd
