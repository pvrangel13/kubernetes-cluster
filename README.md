<img src="./k8s.png" alt="Alt Text" width="100">


# kubernetes-cluster

Reconhecendo a considerável demanda de tempo associada à configuração manual de laboratórios para estudos, incluindo a instalação de máquinas virtuais Ubuntu e o subsequente processo manual de instalação do cluster, optei por automatizar essas etapas. Utilizando o Vagrant para o provisionamento das máquinas e o Ansible para orquestrar a instalação do cluster, busquei simplificar e agilizar esse processo.

Embora os arquivos presentes possam não ser considerados exemplares, destaco que estão funcionalmente operacionais, atendendo aos objetivos propostos. Encorajo aqueles interessados a utilizá-los ou aprimorá-los, sendo a colaboração bem-vinda para a constante melhoria deste recurso.

Este repositório serve como uma fonte para aqueles que desejam criar um Cluster Kubernetes. Utilizando o Vagrant para o provisionamento das máquinas e o Ansible para automatizar todo o processo de instalação do Cluster, proporcionamos uma solução eficiente e prática para a implementação e gerenciamento de clusters Kubernetes, simplificando a configuração e permitindo uma inicialização rápida do ambiente de desenvolvimento/laboratório.

No arquivo Vagrantfile, configuramos três máquinas distintas: odin (Líder), thor e loki (Operários).

- Odin possui 2 vCPUs e 2GB de memória.
- Thor e Loki são configurados com 2 vCPUs e 1GB de memória cada.
  
```
* Obs.: Não use isso em produção, apenas para estudos! *
```


## Documentação Oficial de instalação do cluster kubernetes

[Documentação Oficial Instalação Kubernetes](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

## Explicação arquivos
Em construção...

## Uso


1. **Instalação de Recursos Necessários:**
   - Certifique-se de ter o OpenSSL instalado em sua máquina. Se não estiver instalado, você pode fazer isso com o comando apropriado para o seu sistema operacional (por exemplo, `sudo apt-get install openssl` no Ubuntu).

2. **Criptografia da Senha:**
   - Execute o comando abaixo para criptografar sua senha (Substitua 'mude_para_sua_senha' pela sua senha):
     ```bash
     echo -n 'mude_para_sua_senha' | openssl passwd -6 -salt $(openssl rand -base64 3) -stdin
     # Troque 'mude_para_sua_senha' pela sua senha e gera um salt aleatório usando openssl rand -base64 3
     ```

3. **Configuração do Arquivo `setup.sh`:**
   - Vá para o arquivo `setup.sh` e encontre a linha contendo `encrypted_password`. Substitua o valor pela saída do comando OpenSSL executado no passo anterior.

4. **Subindo as Máquinas com Vagrant:**
   - Use o comando abaixo para iniciar as máquinas no Vagrant:
     ```bash
     cd /caminho/do/seu/repo
     vagrant up
     ```

5. **Verificando o Status das VMs:**
   - Execute o comando para verificar o status das VMs:
     ```bash
     vagrant status
     ```

6. **Acessando as VMs com Vagrant:**
   - Acesse a VM Odin (ou outra VM de sua escolha) usando:
     ```bash
     vagrant ssh odin
     ```

7. **Ajustando Chaves SSH Manualmente:**
   - Como não foi possível automatizar a troca de chaves, execute os comandos abaixo manualmente de dentro da VM odin:
     ```bash
     sudo su devops
     ssh-copy-id -i ~/.ssh/id_rsa.pub devops@thor
     ssh-copy-id -i ~/.ssh/id_rsa.pub devops@loki
     ```

8. **Execução do Playbook Ansible:**
   - Execute o playbook Ansible:
     ```bash
     devops@odin:/home/vagrant$ ansible-playbook -i /k8s/inventory.ini /k8s/kubernetes_playbook.yaml
     ```

9. **Verificando o Funcionamento:**
   - Após a conclusão do playbook, execute os comandos abaixo para verificar o funcionamento do Cluster Kubernetes:

      ```bash
      - Listar os nodes atualmente no cluster
      kubectl get nodes

      NAME | STATUS | ROLES         | AGE | VERSION
      odin   Ready    control-plane   69s   v1.29.2
      thor   Ready    <none>          43s   v1.29.2


      - Resultado deve ser um service e deployment do jenkins, usado para testar nosso cluster
      kubectl get all

      NAME                              | READY  | STATUS   | RESTARTS  | AGE
      pod/jenkins-dp-6fb5fb8cc7-fggpw     1/1      Running    0           118s
      pod/jenkins-dp-6fb5fb8cc7-kqljt     1/1      Running    0           118s

      NAME                 | TYPE       | CLUSTER-IP     | EXTERNAL-IP | PORT(S)        | AGE
      service/jenkins-svc    NodePort	    10.103.35.113    <none>        8080:30005/TCP   117s
      service/kubernetes     ClusterIP    10.96.0.1        <none>        443/TCP          2m27s

      NAME                        | READY  | UP-TO-DATE | AVAILABLE | AGE
      deployment.apps/jenkins-dp    2/2      2            2           118s

      NAME                                   | DESIRED | CURRENT | READY | AGE
      replicaset.apps/jenkins-dp-6fb5fb8cc7    2         2         2       118s


      - Verificar em quais nodes os pods estão sendo executados
      kubectl get pods -o wide

      NAME                         | READY | STATUS   | RESTARTS | AGE   | IP	NODE      | NOMINATED NODE | READINESS | GATES
      jenkins-dp-6fb5fb8cc7-fggpw    1/1     Running    0          3m11s   10.244.192.2   thor             <none>      <none>
      jenkins-dp-6fb5fb8cc7-kqljt    1/1     Running    0          3m11s   10.244.192.1   thor             <none>      <none>
      ```


10. **Limpeza dos Recursos:**
    - Para limpar o deployment e o service, execute:
      ```bash
      kubectl delete deployment.apps/jenkins-dp
      kubectl delete service/jenkins-svc
      ```

11. **Conclusão:**
    - Se tudo correu bem, seu ambiente Kubernetes está pronto para uso. Divirta-se explorando e experimentando! 

