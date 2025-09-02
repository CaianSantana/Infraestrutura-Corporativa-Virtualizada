#!/bin/bash

readonly mounted_dir="/vagrant"
readonly conf_dir="$mounted_dir/conf/DNS"
readonly dns_dir="/etc/bind"
readonly dominio="minhaempresa.inet"
readonly db_file="$dns_dir/db.$dominio"
readonly zona_rev="56.168.192"
readonly db_rev_file="$dns_dir/$zona_rev.rev"


function install_requirements() {
    echo ">>> Atualizando pacotes e instalando o BIND9..."
    sudo apt-get update >/dev/null
    sudo apt-get install -y bind9

    echo ">>> Desativando systemd-resolved e configurando resolv.conf..."
    sudo systemctl stop systemd-resolved
    sudo systemctl disable systemd-resolved
    
    sudo unlink /etc/resolv.conf
    echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf

    sudo chattr +i /etc/resolv.conf
    echo ">>> Pré-requisitos instalados com sucesso."
}

function config_dns() {
    echo ">>> Copiando arquivos de configuração do BIND..."
    sudo cp "$conf_dir"/* "$dns_dir/"

    echo ">>> Verificando a sintaxe dos arquivos de configuração..."
    sudo named-checkconf
    if [[ $? -ne 0 ]]; then
        echo "ERRO: Problema no arquivo de configuração principal do BIND (named.conf.local)."
        exit 1 
    fi

    if ! sudo named-checkzone "$dominio" "$db_file"; then
        echo "ERRO: Problema no arquivo da zona direta: $db_file"
        exit 1
    fi
    
    if ! sudo named-checkzone "$zona_rev.in-addr.arpa" "$db_rev_file"; then
        echo "ERRO: Problema no arquivo da zona reversa: $db_rev_file"
        exit 1
    fi
    
    echo ">>> Sintaxe OK. Reiniciando o serviço BIND9..."
    sudo systemctl restart bind9

    if sudo systemctl is-active --quiet bind9; then
        echo ">>> SUCESSO: Servidor DNS BIND9 está ativo e rodando."
    else
        echo "ERRO: Falha ao iniciar o serviço BIND9. Verifique os logs com 'journalctl -u named.service'."
        exit 1
    fi
}

main(){
    install_requirements
    config_dns
}

main