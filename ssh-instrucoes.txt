## Instruções ssh: 

## Colocando novas chaves ssh(por script):

* Coloque o script na maquina que vai receber a chave, altere o script com as informações desejadas(chave, nome de usuario e dono da chave), depois salve e execute.

## Para bloquear acesso ssh via senha e escolher o ip e porta que o ssh irá ouvir (Por script):
* Coloque o script na maquina desejada para receber a configuração
* Altere as configurações de porta e ip desejados no script
* Salve e execute o script como `root`
* Feche as conexões ssh e depois abra novamente para testar as configurações aplicadas

## Colocando novas chaves ssh(manualmente):
* Verifique a existencia do arquivo `/home/user/.ssh/authorized_keys`, se o arquivo não existir crie  
* Se o usuário o qual irá receber a chave for o usuário `root`, a pasta .ssh estará em: `/root/.ssh`  
* Certifique-se que as permições desse arquivo sejam `0600`
* Certifique-se que o usuário que irá ser acessado pela chave seja dono do arquivo authorized_keys e da pasta .ssh, `user:user`
* Certifique-se que as permições da pasta .ssh seja `0700`
* Coloque a chave publica desejada dentro do arquivo `authorized_keys` e depois salve o arquivo

## Para bloquear acesso ssh via senha e escolher o ip e porta que o ssh irá ouvir (manualmente) : 

* Vá no arquivo /etc/ssh/sshd_config e altere as  linhas espesificadas abaixo  e  certifique-se que essas linhas  não estejam em forma de comentario. 
```
Port 22 # Porta padrão
ListenAddress 0.0.0.0# Public IP
PasswordAuthentication no
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
UseDNS no
AcceptEnv LANG LC_*
Subsystem       sftp    /usr/lib/openssh/sftp-server
```
* Depois salve o arquivo vá no terminal e execute o comando: `service ssh restart` 
* Feche as conexões ssh e depois abra novamente para testar as configurações aplicadas

