#!/bin/bash
if [ $# -lt 1 ]; then
echo "[ Modo de uso: ./webrecon.sh http://businesscorp.com.br ]"
exit 1
fi

echo ""
echo "██╗    ██╗███████╗██████╗     ██████╗ ███████╗ ██████╗ ██████╗ ███╗   ██╗"
echo "██║    ██║██╔════╝██╔══██╗    ██╔══██╗██╔════╝██╔════╝██╔═══██╗████╗  ██║"
echo "██║ █╗ ██║█████╗  ██████╔╝    ██████╔╝█████╗  ██║     ██║   ██║██╔██╗ ██║"
echo "██║███╗██║██╔══╝  ██╔══██╗    ██╔══██╗██╔══╝  ██║     ██║   ██║██║╚██╗██║"
echo "╚███╔███╔╝███████╗██████╔╝    ██║  ██║███████╗╚██████╗╚██████╔╝██║ ╚████║"
echo " ╚══╝╚══╝ ╚══════╝╚═════╝     ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝"
echo ""
echo "          [ Ferramenta de Reconhecimento Web ]"
echo "          [ Desenvolvido por: rooster123872  ]"
echo "          [ Nao utilize em ambientes em que vc nao tem permissao! ]"
echo ""


for frase in $(cat lista2.txt);
do
resposta=$(curl -sL -H "User-Agent: SecretTool" -o /dev/null -w "%{http_code}" "$1/$frase/")
if [ $resposta == "200" ]; then
	echo -e "\e[32m[+] DIRETORIO ENCONTRADO! $1/$frase --- CODIGO: $resposta\e[0m"
elif [ $resposta == "301" ] || [ $resposta == "302" ]; then
	echo -e "\e[36m[=>] REDIRECIONAMENTO! O diretorio existe, mas aponta para outro local --- CODIGO: $resposta\e[0m"
elif [ $resposta == "403" ]; then
	echo -e "\e[33m[!]ACESSO NEGADO! Mas fique ciente, o diretorio existe! - CODIGO: $resposta\e[0m"
fi
done

echo "Diretorios encontrados! Agora vamos procurar os arquivos"
for file in $(cat arquivos.txt);
do
resposta2=$(curl -sL -H "User-Agent: SecretTool" -o /dev/null -w "%{http_code}" $1/$file)
if [ $resposta2 == "200" ] 
then
echo "Arquivo encontrado! GG, o arquivo e o: $1/$file"
fi
done

