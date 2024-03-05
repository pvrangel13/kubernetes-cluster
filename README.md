# kubernetes-cluster

Reconhecendo a considerável demanda de tempo associada à configuração manual de laboratórios para estudos, incluindo a instalação de máquinas virtuais Ubuntu e o subsequente processo manual de instalação do cluster, optei por automatizar essas etapas. Utilizando o Vagrant para o provisionamento das máquinas e o Ansible para orquestrar a instalação do cluster, busquei simplificar e agilizar esse processo.

Embora os arquivos presentes possam não ser considerados exemplares, destaco que estão funcionalmente operacionais, atendendo aos objetivos propostos. Encorajo aqueles interessados a utilizá-los ou aprimorá-los, sendo a colaboração bem-vinda para a constante melhoria deste recurso.

Este repositório serve como uma fonte para aqueles que desejam criar um Cluster Kubernetes. Utilizando o Vagrant para o provisionamento das máquinas e o Ansible para automatizar todo o processo de instalação do Cluster, proporcionamos uma solução eficiente e prática para a implementação e gerenciamento de clusters Kubernetes, simplificando a configuração e permitindo uma inicialização rápida do ambiente de desenvolvimento/laboratório.

No arquivo Vagrantfile, configuramos três máquinas distintas: odin (Líder), thor e loki (Operários).

Odin possui 2 vCPUs e 2GB de memória.
Thor e Loki são configurados com 2 vCPUs e 1GB de memória cada.

## Obs.: Não use isso em produção, apenas para estudos! 

## Documentação Oficial de instalação do cluster kubernetes

[Documentação Oficial Instalação Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)


## Uso
Em construção...
