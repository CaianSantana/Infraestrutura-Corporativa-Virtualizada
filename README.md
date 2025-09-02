# Infraestrutura Corporativa Típica com DMZ de Firewall Duplo
Este projeto recria uma arquitetura de rede corporativa segura, conforme apresentado no diagrama abaixo, utilizando Máquinas Virtuais (VMs). O objetivo é simular um ambiente de alta segurança com uma rede local (LAN), uma zona desmilitarizada (DMZ) protegida por dois firewalls e conexão com a Internet (WAN), focando na interação controlada entre os componentes.

## Diagrama da Infraestrutura


 ![Diagrama da Arquitetura de Rede](https://www.plantuml.com/plantuml/svg/TPFTRjis5CVl-HHdxiKI876JA1Y6NWIrf0GrqBg2xI1PCA0ubauSefJeyYDpD-nXYbuCkzZbdi0lDXvH_fZh1W5CYh_pSVxyyxLrQ9olbVZ1FL5DKACZ8r7y23azoeO0ePA6Ld-jlcgeD2ZyhBs32e7i9qycB1PeiCEawxQbGaE_er3qwC1fC7B-v5gaT58tGZZf5C70VFBIaVCX9DDceGqw-OmmeRddBBg6_Dq34Do4oDzGASZzGcaXIgLz1RsxmGYEXeqZqv0xxW5Q29z4wFxzDkHwoUSQLdz3wCx8cgH1cA4nl12DhWXw-_IlpT6mcE9CaOrvR-u-NDzFuGM3CoFBZq8iiFo8yn3CFHwDAUG9_mMPrJyrEQD3u8ktF7WO3HNy8I3ynN8fAcnAmaeRZidGp36K7CrbiuprYl7x-rzs8YPadYNZTpGxEm_i89H_ecxew_Ji_7lmnG7uudjmSW1ETk1yD861Tzf8nrV5EgN3KHxXSFYXk4t5dtit46z8WwNEAonOXV1sCDgJFwA7vH-EWlnZ_HbLgZpjo1_ITFB7QDm8p-3_TB-s3Zil4qmDpb0zwQXtTaYIyI0VtauOw9Q7e0USpUIoXHu6QJgyFmJbRxA2aNRH0XMwKD-sRcZAjgCSAsqZbUw9lXLcJ5QhPp8li-qr1OBrYSgVdfx6roitp_P6-MKty-hB8yqrGyoUzxTdr3Y35JBlhLzzCL8BVc6dLsltluBUcCAJjPpvNxBmPZejNav2KuKs3YtyV7O2bvV9SK_4Y10RdSorBlgmzdqTQkcDyw7Yqc7VEaEq0Q71g-ZhlVt5tZxXrCdE61MBsEM2pd2jHKhDLLGuXWKf_Oq_ZqEYMuiDpr_3tFY5Zl5MrWib7sM9XiMsvD2AexQvazXJ_4cEeT-_YbxT4-lhjhMrMgnpcfy0BLz1afpz54NZI4wIfppNPHyoNVicb8v9P7Ju-lKK6UiGhp-Mp7HZlNB8tzPqJqHVChlJtJlTIATDl8nDSMOEpXQpAtAuLRcpldXDJULhzHy0)

[Código do Diagrama](https://www.plantuml.com/plantuml/uml/TPFTRjis5CVl-HHdxiKI876JA1Y6NWIrf0GrqBg2xI1PCA0ubauSefJeyYDpD-nXYbuCkzZbdi0lDXvH_fZh1W5CYh_pSVxyyxLrQ9olbVZ1FL5DKACZ8r7y23azoeO0ePA6Ld-jlcgeD2ZyhBs32e7i9qycB1PeiCEawxQbGaE_er3qwC1fC7B-v5gaT58tGZZf5C70VFBIaVCX9DDceGqw-OmmeRddBBg6_Dq34Do4oDzGASZzGcaXIgLz1RsxmGYEXeqZqv0xxW5Q29z4wFxzDkHwoUSQLdz3wCx8cgH1cA4nl12DhWXw-_IlpT6mcE9CaOrvR-u-NDzFuGM3CoFBZq8iiFo8yn3CFHwDAUG9_mMPrJyrEQD3u8ktF7WO3HNy8I3ynN8fAcnAmaeRZidGp36K7CrbiuprYl7x-rzs8YPadYNZTpGxEm_i89H_ecxew_Ji_7lmnG7uudjmSW1ETk1yD861Tzf8nrV5EgN3KHxXSFYXk4t5dtit46z8WwNEAonOXV1sCDgNFw87vH-EWlnZ_HbLgZpjo1_ITFB7QDm8p-3_TB-s3Zil4qmDpb0zwQXtTaYIyI0VtauOw9Q7e0USpUIoXHu6QJgyFmJbRxA2aNRH0XMwKD-sRcZAjgCSAsqZbUw9lXLcJ5QhPp8li-qr1OBrYSgVdfx6roitp_P6-MKty-hB8yqrGyoUzxTdr3Y35JBlhLzzCL8BVc6dLsltluBUcCAJjPpvNxBmPZejNav2KuKs3YtyV7O2bvV9SK_428wDJWwrBlgmzdqTQkcDyw7Yqc7VEaEq0Q71g-ZhlVt5tZxXrCdE61MBsEM2pd2jHKhDLLGuXWKf_Oq_ZqEYMuiDpr_3tFY5Zl5MrWib7sM9XiMsvD2AexQvazXJ_4cEeT-_YbxT4-lhjhMrMgnpcfy0BLz1afpz54NZI4wIfppNPHyoNVicb8v9P7Ju-lKK6UiGhp-Mp7HZlNB8tzPqJqHVChlJtJlTIATDl8nDSMOEpXQpAtAuLRcplX2lgQbyhVu3)
 
## Arquitetura da Rede
A infraestrutura é dividida em três zonas de segurança distintas, com os firewalls atuando como pontos de controle de fronteira entre elas.

### LAN (Rede Corporativa Segura)
A LAN é a rede interna e confiável, onde residem os dados críticos e os sistemas de suporte ao negócio. O acesso a esta zona é estritamente controlado pelo Firewall Interno. Seus componentes incluem:

- Estação de Trabalho: Representa os computadores dos usuários finais.

- Servidor DHCP: Distribui endereços IP e configurações de rede para os dispositivos internos.

- DNS Interno / AD: Resolve nomes de domínio para a rede local e gerencia a autenticação de usuários (Active Directory).

- Servidor RADIUS: Centraliza a autenticação de serviços de rede, como a VPN.

- Servidor Zabbix: Realiza o monitoramento de toda a infraestrutura (servidores, firewalls, etc.).

- Banco de Dados: Armazena os dados sensíveis das aplicações.

### DMZ (Zona Desmilitarizada)
A DMZ é uma zona de perímetro, isolada entre o Firewall Externo e o Interno. Ela hospeda os serviços que precisam ser expostos à internet, agindo como uma camada de sacrifício para proteger a LAN.

- Servidores Web (Apache): Hospeda os sites e aplicações acessíveis publicamente.

- Balanceador de Carga: Intermedia o tráfego, oferecendo cache, balanceamento de carga e uma camada extra de segurança para os servidores web.

- DNS Público: Resolve nomes de domínio públicos (ex: www.suaempresa.com) para requisições vindas da internet.

### Controle de Acesso (Firewalls)
A segurança desta arquitetura é baseada no conceito de defesa em camadas, utilizando dois firewalls distintos:

- Firewall Externo: Fica entre a WAN e a DMZ. Sua função é proteger os serviços públicos na DMZ de ataques vindos da internet, permitindo apenas tráfego estritamente necessário (ex: portas 80/443 para o servidor web).

- Firewall Interno: Fica entre a DMZ e a LAN. É a proteção mais crítica, operando com uma política de "negação total" e permitindo apenas conexões mínimas e específicas iniciadas da DMZ para a LAN (ex: a consulta do servidor web ao banco de dados).

### WAN (Rede Externa)
Internet: Simula a conexão da infraestrutura corporativa com a rede mundial, de onde vêm tanto usuários legítimos quanto tráfego malicioso.

## Tecnologias Utilizadas
Virtualização: VirtualBox

Provisionamento: Vagrant

Sistemas Operacionais: Ubuntu Server

## Como Executar (Em construção)
Pré-requisitos: Certifique-se de ter VirtualBox e Vagrant instalados.

Clone o repositório:

    git clone https://github.com/CaianSantana/Infraestrutura-Corporativa-Virtualizada.git

Acesse o diretório do projeto:

    cd Infraestrutura-Corporativa-Virtualizada

Inicie o ambiente:

    vagrant up

Após o provisionamento, as VMs estarão configuradas e prontas para uso. Consulte os arquivos de configuração para verificar os endereços IP de cada serviço.







