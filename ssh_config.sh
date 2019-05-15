#!/bin/bash

#Esse script faz a configuração do ssh para não permitir acesso por senha,o acesso fica restrito a quem tem chaves pre-definidas 
#O script também faz a configuração de dar um ip para o ssh ouvir, assim barrando o acesso ao outro(s) ips da maquina  
user=$(whoami)

config="
# Use most defaults for sshd configuration.
Port 22
ListenAddress 0.0.0.0# Public IP
UsePrivilegeSeparation sandbox
Subsystem sftp internal-sftp
ClientAliveInterval 180
UseDNS no
UsePAM yes
PrintLastLog no # handled by PAM
PrintMotd no # handled by PAM
PasswordAuthentication no
ChallengeResponseAuthentication no"

if [ $user = "root" ]
then
	cd /etc/ssh/
	mv sshd_config oldsshd_config
	echo movendo arquivo ssh_config	
	echo  "$config" > sshd_config
	chmod 600 sshd_config	
	chown $user:$user sshd_config
	service ssh restart
	echo serviço ssh reiniciado 
	echo configuração completa
else
	echo execute o script como root
	exit 	
fi

 




