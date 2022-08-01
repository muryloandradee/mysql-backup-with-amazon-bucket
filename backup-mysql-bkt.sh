#!/bin/bash

cd /home/user/

if [ ! -d backup_cloud	]
then
	mkdir backup_cloud
fi


CONSTANT_LOCAL=/home/user/backup_cloud

cd $CONSTANT_LOCAL

data=$(date +%F)

if [ ! -d $data ]
then
	mkdir $data
fi

variavel_tabelas=$(sudo mysql -u root mutillidae -e "show tables;" | grep -v Tables)

for tabela in $variavel_tabelas
do
	mysqldump -u root mutillidae $tabela > $CONSTANT_LOCAL/$data/$tabela.sql
done

aws s3 sync $CONSTANT_LOCAL s3://nome-do-bucket
