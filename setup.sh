#!/bin/bash
#sudo apt update -y
sudo apt install curl unzip -y
sudo echo "192.168.56.110 odin" >> /etc/hosts
sudo echo "192.168.56.111 thor" >> /etc/hosts
sudo echo "192.168.56.112 loki" >> /etc/hosts

# Senha foi criptografada em meu PC usando comando abaixo
# echo -n 'mude_para_sua_senha' | openssl passwd -6 -salt $(openssl rand -base64 3) -stdin
encrypted_password='$6$VXLf$UTAvtRDCihxj6THu5QTyz5z4agkwOS6z6/i2uEFklHI5lSdwnlcR3z4lsMAv2ryk5Z99FTDEPkGR9gwoGUnUy0' # Mude para a saída do comando openssl

new_user="devops"

useradd -m -s /bin/bash $new_user

# A opção "-e" entende que a senha está criptografada e adciona diretamente ao arquivo "/etc/shadow"
echo $new_user:$encrypted_password | chpasswd -e

# Adicionar o usuário ao grupo sudo sem solicitar senha
echo "$new_user ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers > /dev/null

#Execução somente no master
name_host=$(hostname)
if [ "$name_host" == "odin" ]; then
    sudo apt install software-properties-common
    sudo add-apt-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible -y
    sudo -u devops ssh-keygen -t rsa -b 2048 -N "" -f /home/devops/.ssh/id_rsa < /dev/null

    touch /home/devops/.ssh/authorized_keys
    cat /home/devops/.ssh/id_rsa.pub > /home/devops/.ssh/authorized_keys
    
    # Obter chave pública do arquivo no master
    public_key=$(cat /home/devops/.ssh/id_rsa.pub)
fi


# execução para as máquinas nodes
machines=("odin" "thor" "loki")

# Caminho do arquivo de configuração do SSH
ssh_config_path="/etc/ssh/sshd_config"

for machine in "${machines[@]}"; do
    # Verifica se a máquina Vagrant está em execução
    if ping -q -c 1 -W 1 "$machine" >/dev/null; then

        sudo cp "$ssh_config_path" "$ssh_config_path.bak"
        sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' "$ssh_config_path"
        sudo sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' "$ssh_config_path"

        # sudo touch /home/devops/.ssh/authorized_keys
        # sudo echo "$public_key" >> /home/devops/.ssh/authorized_keys

        sudo service ssh restart
    else
        echo "Máquina $machine não está em execução ou não está acessível. Continuando com a próxima máquina..."
    fi
done