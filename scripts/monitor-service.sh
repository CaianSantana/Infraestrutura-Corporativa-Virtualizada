#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "Erro: Este script precisa ser executado com 'sudo'."
   exit 1
fi

if [[ $# == 1 ]]; then
    SERVICE_NAME="$1"
else
    echo "Uso: sudo $0 <nome-do-serviço>"
    exit 1
fi

if [[ -n "$SUDO_USER" ]]; then
    INVOKING_USER="$SUDO_USER"
else
    INVOKING_USER="root (execução direta)"
fi

LOG="/var/log/$SERVICE_NAME.log"

if ! [[ -e "$LOG" ]]; then
    sudo touch "$LOG"
fi

function verify(){
    if ! systemctl is-active --quiet "${SERVICE_NAME}"; then
        echo "--- $(date) ---" >> "$LOG"
        echo "$SERVICE_NAME não está ativo. Iniciando-o..." >> "$LOG"
        
        echo "Usuário que executou o script: $INVOKING_USER" >> "$LOG"
        uptime >> "$LOG"

        echo "Comando de inicialização para $SERVICE_NAME enviado." >> "$LOG" 
        systemctl start "$SERVICE_NAME"
        if [[ $? -eq 0 ]]; then
            echo "Processo iniciado com sucesso."
        else
            echo "Processo falhou, contate o admin."
        fi
        
    else
        echo "$SERVICE_NAME já está ativo."
    fi
}


main(){
    verify
}

main "$@"