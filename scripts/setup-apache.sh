#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail
#set -x

DIR="/tmp"
LINK="https://www.tooplate.com/zip-templates/2139_neural_portfolio.zip"
function install_requirements(){
    echo "Instalando requisitos..."
    sudo apt update
    sudo apt install apache2 wget zip -y
}


function get_page(){
    echo "Configurando página do Apache..."
    cd "${DIR}"
    sudo wget "${LINK}" -O page.zip
    sudo unzip -o -j page.zip -d page

    if [ -n "$(ls -A page)" ]; then
        echo "Arquivo extraído com sucesso."
    else
        echo "Erro na extração do arquivo zip. O diretório 'page' está vazio."
        exit 1
    fi
}

function setup_page(){
    sudo cp page/* /var/www/html/

    sudo systemctl restart apache2.service

    STATUS="$(sudo systemctl status apache2.service | grep "Active" | awk '{print $2}')"

    if [ "${STATUS}" = "active" ]; then
        echo "Página configurada com sucesso. Apache está ativo."
        exit 0
    else
        echo "Erro, Apache não está ativo."
        exit 1
    fi
}


main() {
    install_requirements
    get_page
    setup_page
}

main "$@"



