#!/bin/bash
#wget https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
cp imagenes_cloud_init/jammy-server-cloudimg-amd64.img.original jammy-server-cloudimg-amd64.img

# Ruta de la clave SSH a inyectar
ssh_key_path="/root/.ssh/id_key_labredes.pub"

# Instalar el agente de invitado de QEMU
sudo virt-customize -a jammy-server-cloudimg-amd64.img --install qemu-guest-agent

# Crear el usuario labredes
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'useradd -m -s /bin/bash labredes'

# Establecer la contraseña para el usuarioroot y  labredes
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'echo "labredes:labredes" | chpasswd'
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'echo "root:labredes" | chpasswd'

# Agregar el usuario labredes al grupo sudo y adm
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'usermod -aG sudo,adm labredes'

# Crear la carpeta .ssh en el directorio del usuario labredes
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'mkdir -p /home/labredes/.ssh'

# Crear la carpeta .ssh en el directorio del usuario root
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'mkdir -p /root/.ssh'

# Inyectar la misma clave SSH en las carpetas .ssh de labredes y root
sudo virt-customize -a jammy-server-cloudimg-amd64.img --ssh-inject labredes:file:$ssh_key_path
sudo virt-customize -a jammy-server-cloudimg-amd64.img --ssh-inject root:file:$ssh_key_path

# Cambiar la propiedad de las carpetas .ssh a labredes
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'chown -R labredes:labredes /home/labredes/.ssh'

# Permitir el acceso sin contraseña para el usuario labredes en sudo
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'echo "labredes ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'

# Habilitar la autenticación de contraseña en SS
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config'

# Habilitar PermitRootLogin yes en SSH
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config'

# Cambiar el machine-id de la máquina virtual
sudo virt-customize -a jammy-server-cloudimg-amd64.img --run-command 'rm -f /etc/machine-id; dbus-uuidgen --ensure=/etc/machine-id; rm /var/lib/dbus/machine-id; dbus-uuidgen --ensure'

# Crear la máquina virtual con la imagen personalizada
sudo qm create 9010 --name "ubu-2204-tpl-root-labredes-pass-key-sudoer-nopasswd" --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0
sudo qm importdisk 9010 jammy-server-cloudimg-amd64.img local-lvm
sudo qm set 9010 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9010-disk-0
sudo qm set 9010 --boot c --bootdisk scsi0
sudo qm set 9010 --ide2 local-lvm:cloudinit
sudo qm set 9010 --serial0 socket --vga serial0
sudo qm set 9010 --agent enabled=1

# Crear la plantilla de la máquina virtual
sudo qm template 9010
