#!/bin/bash
user=$(whoami)
if [ $user = "root" ]
then
echo programa para configuração de rede de ip fixo publico e privado

else
        echo execute o script como root
        exit
fi
echo gostaria de gerar um backup da configuração anterior?
echo "(y/n)"
read op
if [ $op = "y" ]
then
	echo gerando backup de configuração de rede anterior e salvando em /etc/network/interfaces.backup
	cp /etc/network/interfaces /etc/network/interfaces.backup
fi 

cp interfaces-prod /etc/network/interfaces-prod
cd /etc/network
rede="$(route | grep '^default' | grep -o '[^ ]*$')"
echo a interface utilizada na maquina é "$rede"?
echo "(y/n)"
read op
if [ $op = "y" ]
then
	sed -i "s/eno1/"$rede"/" interfaces-prod 
else
	echo qual a interface?
	read rede
	sed -i "s/eno1/"$rede"/" interfaces-prod
 
fi 

echo qual o ip fixo publico desejado?
read ip
sed -i "s/200.239.93.X/"$ip"/" interfaces-prod

echo qual o ip fixo privado desejado?
read ip
sed -i "s/192.168.10.X/"$ip"/" interfaces-prod

echo verifique a configuração: 
cat interfaces-prod

echo aplicar configuração ?
echo "(y/n)"
read op
if [ $op = "y" ]
then
        echo trocando configuração antiga pela nova
        cp interfaces-prod interfaces
	echo você deseja reiniciar a rede?
	read op
	if [ $op = "y" ]
	then
		/etc/init.d/networking restart 
  		echo rede reiniciada, finalizando programa
		exit         
	fi
else
        echo fechando o programa 
	exit 
 
fi  
