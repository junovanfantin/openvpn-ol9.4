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
