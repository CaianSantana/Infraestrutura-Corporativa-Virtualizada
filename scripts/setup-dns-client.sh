#!/bin/bash
readonly ip_dns="192.168.56.3"

function set_nameserver(){
    echo ">>> Configurando cliente DNS"
    sudo unlink /etc/resolv.conf
    echo "nameserver $ip_dns" | sudo tee /etc/resolv.conf
    ping -qc 1 ns1.minhaempresa.inet >/dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo ">>> Configuração de cliente DNS falhou..."
        exit 1
    fi
    echo ">>> Configuração concluida com sucesso!"
    exit 0
}

set_nameserver
