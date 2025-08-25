# Infraestrutura Corporativa Típica com DMZ de Firewall Duplo
Este projeto recria uma arquitetura de rede corporativa segura, conforme apresentado no diagrama abaixo, utilizando Máquinas Virtuais (VMs). O objetivo é simular um ambiente de alta segurança com uma rede local (LAN), uma zona desmilitarizada (DMZ) protegida por dois firewalls e conexão com a Internet (WAN), focando na interação controlada entre os componentes.

## Diagrama da Infraestrutura


 ![Diagrama da Arquitetura de Rede](https://www.plantuml.com/plantuml/svg/RPBFRjD048VlVeh1lPH3sZi7L3jEXQNYhfAKX0Yf6jkJPDNrRjXTfwaG3uCuSE85kER56FyXIf5pMkzyyzkPJxbn7gslAnMyyLkg22hqP2K6Ndf5aEgrHNBUrhws26DZTyQYbtk4-V7tJXO8XQaW-RY2ak1MscTK2f9wfqnGA5EN42wY32vJpQcQ_DiGq05V1S4EYoVS48JS7CB5dTniFUUZWcy1y4-RaeipidjP6WiBoh_eouYxjdITRQG-z5cJU0Z_93B6xtUa-NIT2aT5n_Fd6I-iERp0bFPadO7h_fNPrrgMvu-8wVtoyrbRair07F_aIXQc1VZYKJoSJy8kg9NHhTvXjul7D9l3nTIye8fLJKCDayEhXicI6vfYRcNn57m_CtSNPV_CDM6ln4sSn-Eluqy3_3MtcAFQTfbYF2Hi6YNfmwm1-kCGjC8ybuSMMaLnd2x_SzBloYAZvEI5DnxAIZwCHSVmeGLAz3ocOoX6NRI39rWQrr5nithG6nmfMliHi01u1-7S7d-iQMDEheFUswWqpte4YmuR6qq7DjB-PR67oOSSAyPmTVM-7QKX1MsuBiBJVRT6KvgICsfFl4r5BWnkI9TrfVu2)

[Código do Diagrama](https://www.plantuml.com/plantuml/uml/RPBFRjD048VlVeh1lPH3sZi7L3jEXQNYhfAKX0Yf6jkJPDNrRjXTfwaG3uCuSE85kER56FyXIf5pMkzyyzkPJxbn7gslAnMyyLkg22hqP2K6Ndf5aEgrHNBUrhws26DZTyQYbtk4-V7tJXO8XQaW-RY2ak1MscTK2f9wfqnGA5EN42wY32vJpQcQ_DiGq05V1S4EYoVS48JS7CB5dTniFUUZWcy1y4-RaeipidjP6WiBoh_eouYxjdITRQG-z5cJU0Z_93B6xtUa-NIT2aT5n_Fd6I-iERp0bFPadO7h_fNPrrgMvu-8wVtoyrbRair07F_aIXQc1VZYKJoSJy8kg9NHhTvXjul7D9l3nTIye8fLJKCDayEhXicI6vfYRcNn57m_CtSNPV_CDM6ln4sSn-Eluqy3_3MtcAFQTfbYF2Hi6YNfmwm1-kCGjC8ybuSMMaLnd2x_SzBloYAZvEI5DnxAIZwCHSVmeGLAz3ocOoX6NRI39rWQrr5nithG6nmfMliHi01u1-7S7d-iQMDEheFUswWqpte4YmuR6qq7DjB-PR67oOSSAyPmTVM-7QKX1MsuBiBJVRT6KvgICsfFl4r5BWnkI9TrfVu2)
 
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

- Servidor Web (Apache/Nginx): Hospeda os sites e aplicações acessíveis publicamente.

- Servidor VPN (OpenVPN/IPsec): Ponto de entrada seguro para funcionários remotos se conectarem à rede.

- Proxy Reverso / Web: Intermedia o tráfego, oferecendo cache, balanceamento de carga e uma camada extra de segurança para os servidores web.

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

    git clone https://github.com/seu-usuario/seu-repositorio.git

Acesse o diretório do projeto:

    cd seu-repositorio

Inicie o ambiente:

    vagrant up

Após o provisionamento, as VMs estarão configuradas e prontas para uso. Consulte os arquivos de configuração para verificar os endereços IP de cada serviço.







