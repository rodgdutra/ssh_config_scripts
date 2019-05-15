#!/bin/bash

#coloque os dados da chave e a chave:
user="root" #Prefixo dos usuários , ou o nome do usuario que irá receber a chave
nome_dev="" #nome do dono da chave
#chave
chave="
  
"
    sistuser=$(cut -d: -f1 /etc/passwd | grep "$user")
i=1

if [ $sistuser = "$user" ]
then 
	echo foi encontrado o usuario "$user" no sistema
else
	echo não foi encontrado o usuario "$user" no sistema
	echo tentando "$user" como prefixo
	for var in {1..3}
	do 
	if [ $sistuser = "$user""$var" ]
	then
		echo encontrado usuario "$user""$var"
		((i=0))
	fi
	done

	if [ $i != 0 ]
	then 
		echo não foi encontrado nenhum usuário usando o prefixo "$user"
		exit
	fi
fi


if [ $sistuser = "root" ]
then
	cd /root/
else
	cd /home/$sistuser 	
fi

if [ $(ls -a | grep .ssh) = ".ssh" ]
then
	chmod 700 .ssh
	chown $sistuser:$sistuser .ssh
	cd .ssh
else
	mkdir .ssh
	chmod 700 .ssh	
	chown $sistuser:$sistuser .ssh
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
chown $sistuser:$sistuser authorized_keys
#echo  ""$nome_dev >> authorized_keys
echo "$chave" >> authorized_keys 
echo chave adicionada



