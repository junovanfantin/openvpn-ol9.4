# OpenVPN Offline Installation Scripts

Este repositório contém dois scripts que auxiliam na instalação do **OpenVPN 2.6** e suas dependências em ambientes **offline**. Os scripts permitem baixar, compilar e instalar o OpenVPN e as bibliotecas necessárias de forma autônoma, sem precisar de uma conexão com a internet após a preparação inicial.

---

## Scripts

### 1. `prepare_openvpn_offline.sh`

Este script é usado **inicialmente** para baixar todos os pacotes necessários e gerar um conjunto de arquivos **RPM** que serão usados posteriormente para a instalação offline do OpenVPN e suas dependências.

#### Funcionalidades:
- Baixa o código-fonte do **OpenVPN 2.6.14** e das dependências necessárias.
- Baixa os pacotes RPM de todas as dependências.
- Organiza e prepara os arquivos para instalação offline.

#### Como Usar:

1. Faça o download do script para o seu sistema.
2. Execute o script para baixar as dependências e gerar os pacotes RPM:

   ```bash
   chmod +x prepare_openvpn_offline.sh
   ./prepare_openvpn_offline.sh

Este script irá:

    Baixar o código-fonte do OpenVPN 2.6.14 e suas dependências.

    Gerar arquivos RPM no diretório especificado, que serão utilizados para a instalação offline.

    Após a execução, os arquivos RPM necessários para a instalação offline estarão prontos no diretório especificado. Esses pacotes podem ser transferidos para o servidor ou sistema onde a instalação offline será realizada.

### 2. `recompile_openvpn_offline.sh`

Este script é usado para compilar todas as dependências e o OpenVPN 2.6 a partir dos pacotes RPM gerados previamente. Ele configura, compila e instala o OpenVPN e suas dependências, sem necessidade de conexão com a internet.
Funcionalidades:

    Instala as dependências a partir dos pacotes RPM locais.

    Compila e instala libpkcs11-helper e outras bibliotecas necessárias.

    Compila e instala o OpenVPN 2.6.14 a partir do código-fonte, utilizando as dependências locais.

    Verifica se a instalação foi bem-sucedida.

Como Usar:

    Certifique-se de que os pacotes RPM gerados com o script prepare_openvpn_offline.sh estejam disponíveis.

    Faça o download do script para o seu sistema.

    Execute o script para compilar e instalar o OpenVPN:

    chmod +x recompile_openvpn_offline.sh
    ./recompile_openvpn_offline.sh

    Este script irá:

        Instalar as dependências a partir dos pacotes RPM.

        Compilar e instalar libpkcs11-helper e o OpenVPN 2.6.14.

    Após a execução bem-sucedida do script, o OpenVPN 2.6.14 estará instalado e pronto para uso.

Pré-requisitos

    Sistema Linux com Oracle Linux 9.4 ou similar.

    Dependências mínimas como gcc, make, pkg-config e outras ferramentas de desenvolvimento (instaladas por meio de pacotes RPM).

Observações

    O script prepare_openvpn_offline.sh deve ser executado em um sistema com acesso à internet, onde ele irá baixar todos os pacotes e gerar os arquivos RPM necessários.

    O script recompile_openvpn_offline.sh é utilizado para instalar o OpenVPN em sistemas offline, onde você já tem os arquivos RPM baixados.

Contribuindo

Sinta-se à vontade para fazer contribuições. Se você encontrar problemas ou quiser sugerir melhorias, abra uma issue ou um pull request.
Licença

Este projeto está licenciado sob a Licença MIT.

