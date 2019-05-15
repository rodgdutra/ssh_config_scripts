#!/bin/bash

#coloque os dados da chave e a chave:
user="server" #nome do usuario que vai ser acessado pela chave 
nome_dev="Rodrigo" #nome do dono da chave
#chave
chave=""

if [ $user = "root" ]
then
	cd /root/
else
	cd /home/$user 	
fi

if [ $(ls -a | grep .ssh) = ".ssh" ]
then
	chmod 700 .ssh
	chown $user:$user .ssh
	cd .ssh
else
	mkdir .ssh
	chmod 700 .ssh	
	chown $user:$user .ssh
	cd .ssh	
fi

if [ $(ls -a | grep authorized_keys ) = "authorized_keys" ] 
then 
	echo arquivo de chaves ja existente		
else
	echo criando arquivo de chaves
	touch authorized_keys	
fi

chmod 600 authorized_keys	
chown $user:$user authorized_keys
echo  "#"$nome_dev >> authorized_keys
echo $chave >> authorized_keys 
echo chave adicionada



