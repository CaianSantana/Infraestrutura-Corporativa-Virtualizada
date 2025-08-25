#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
set -x

mount_dir="/vagrant"
conf_dir="/etc/nginx"

function install_requirements (){
    echo "Instalando o NGINX e seus requisitos..."
    sudo apt update
    sudo apt install -y curl gnupg ca-certificates lsb-release ubuntu-keyring nginx
    echo "Instalação concluida."
}

function config_nginx (){
    echo "Configurando nginx..."

    sudo rm -rf "${conf_dir}"/nginx.conf
    sudo rm -rf "${conf_dir}"/sites-enabled/default
    sudo cp "${mount_dir}"/conf/nginx.conf "${conf_dir}"

    if [ -z "$(sudo nginx -s reload)" ]; then
        echo "NGINX configurado com sucesso!"
        exit 0
    else
        echo "Configuração do NGINX com problemas!"
        if [ "$(sudo systemctl status nginx.service | grep "Active" | awk '{print $2}')" != "active" ]; then
            echo "Erro fatal!"
            exit 2
        else
            echo "Erro não fatal."
            exit 1
        fi
    fi
}




main (){
    install_requirements
    config_nginx
}


main "$@"
