#!/bin/bash
set -e

# --------------------------
# Variáveis
# --------------------------
OPENVPN_VERSION="2.6.14"
OPENVPN_TAR="openvpn-${OPENVPN_VERSION}.tar.gz"
OPENVPN_URL="https://swupdate.openvpn.net/community/releases/${OPENVPN_TAR}"
PKCS11_VERSION="1.30.0-1.4"
PKCS11_URL="https://rpmfind.net/linux/opensuse/tumbleweed/repo/oss/x86_64/libpkcs11-helper1-${PKCS11_VERSION}.x86_64.rpm"

# Diretório de saída
OFFLINE_DIR="/opt/offline_openvpn_build"
SRC_DIR="${OFFLINE_DIR}/src"
RPM_DIR="${OFFLINE_DIR}/rpms"


# --------------------------
# Criar estrutura de diretórios
# --------------------------
mkdir -p "$SRC_DIR" "$RPM_DIR" 

# --------------------------
# Baixar OpenVPN
# --------------------------
echo "[1/6] Baixando OpenVPN ${OPENVPN_VERSION}..."
cd "$SRC_DIR"
curl -kLO "$OPENVPN_URL"

# --------------------------
# Baixar e instalar RPM do pkcs11-helper
# --------------------------
echo "[2/6] Baixando pkcs11-helper versão ${PKCS11_VERSION}..."
cd "$RPM_DIR"
curl -kLO "$PKCS11_URL"
dnf install libpkcs11-helper1-${PKCS11_VERSION}.x86_64.rpm -y

# --------------------------
# Empacotar os arquivos baixados para ambiente offline
# --------------------------
echo "[3/6] Empacotando arquivos para offline..."
cd "$OFFLINE_DIR"

# Empacotar OpenVPN
tar -czf "openvpn-${OPENVPN_VERSION}_offline.tar.gz" -C "$SRC_DIR" "openvpn-${OPENVPN_VERSION}.tar.gz"
rm -rf "openvpn-${OPENVPN_VERSION}_offline.tar.gz"

# --------------------------
# Baixar pacotes RPM das dependências
# --------------------------
echo "[4/6] Baixando pacotes RPM necessários..."
cd "$RPM_DIR"
DEPS=(
  gcc
  make
  autoconf
  automake
  libtool
  bzip2
  openssl-devel
  lzo-devel
  libnl3-devel
  libcap-ng
  libcap-ng-devel
  lz4-devel
  pam-devel
  systemd-devel
  epel-release
  easy-rsa
)

for pkg in "${DEPS[@]}"; do
  echo " - Baixando $pkg..."
  dnf download --resolve --alldeps --destdir="$RPM_DIR" "$pkg"
done

# --------------------------
# Empacotar RPMs para o ambiente offline
# --------------------------
echo "[5/6] Empacotando RPMs..."
cd "$RPM_DIR"
tar -czf "rpm_packages_offline.tar.gz" ./*.rpm

# --------------------------
# Finalização
# --------------------------
echo "[6/6] Processo concluído."
echo "Pacotes prontos em: $OFFLINE_DIR"
echo " - openvpn-${OPENVPN_VERSION}_offline.tar.gz"
echo " - rpm_packages_offline.tar.gz"

