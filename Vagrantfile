Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/focal64" # Você pode escolher uma imagem de box diferente, se desejar
    
    # Configuração da máquina odin
    config.vm.define "odin" do |odin|
      odin.vm.network "private_network", type: "static", ip: "192.168.56.110"
      odin.vm.hostname = "odin"
      odin.vm.provider "virtualbox" do |vb|
        vb.memory = "2048" # 2GB de memória
        vb.cpus = 2 # 2 vCPUs
      end
  
      # Configurando o usuário "rangel" com acesso root
      odin.vm.provision "shell", path: "./setup.sh"

      # Configurando pasta compartilhada
    odin.vm.synced_folder "./k8s", "/k8s"
    end
  
    # Configuração da primeira máquina node
    config.vm.define "thor" do |thor|
      thor.vm.network "private_network", type: "static", ip: "192.168.56.111"
      thor.vm.hostname = "thor"
      thor.vm.provider "virtualbox" do |vb|
        vb.memory = "1024" # 1GB de memória
        vb.cpus = 2 # 2 vCPUs
      end
  
      # Configurando o usuário "rangel" com acesso root
      thor.vm.provision "shell", path: "./setup.sh"

    
    end

    config.vm.define "loki" do |loki|
      loki.vm.network "private_network", type: "static", ip: "192.168.56.112"
      loki.vm.hostname = "loki"
      loki.vm.provider "virtualbox" do |vb|
        vb.memory = "2024" # 1GB de memória
        vb.cpus = 2 # 2 vCPUs
      end
  
      # Configurando o usuário "rangel" com acesso root
      loki.vm.provision "shell", path: "./setup.sh"
    end
  end
  