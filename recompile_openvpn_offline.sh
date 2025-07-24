#!/bin/bash
set -e

# --------------------------
# Definir diretórios e variáveis
# --------------------------
OFFLINE_DIR="/opt/offline_openvpn_build"
SRC_DIR="$OFFLINE_DIR/src"
RPM_DIR="$OFFLINE_DIR/rpms"
OPENVPN_VERSION="2.6.14"

# --------------------------
# Etapa 1: Instalar pacotes RPM
# --------------------------
echo "[1/5] Instalando pacotes RPM..."
dnf install -y "$RPM_DIR"/*.rpm

# --------------------------
# Etapa 2: Garantir que o OpenVPN consiga localizar a libpkcs11-helper
# --------------------------
echo "[2/5] Definindo variável de ambiente para libpkcs11-helper..."
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH

# --------------------------
# Etapa 3: Extrair código-fonte do OpenVPN
# --------------------------
OPENVPN_TAR="$SRC_DIR/openvpn-${OPENVPN_VERSION}.tar.gz"

if [ ! -f "$OPENVPN_TAR" ]; then
  echo "❌ O arquivo '$OPENVPN_TAR' não foi encontrado!"
  exit 1
fi

echo "[3/5] Extraindo código-fonte do OpenVPN..."
tar -xzf "$OPENVPN_TAR" -C "$SRC_DIR"

# --------------------------
# Etapa 4: Configurar e compilar o OpenVPN
# --------------------------
echo "Configurando o OpenVPN..."
cd "$SRC_DIR/openvpn-${OPENVPN_VERSION}"

# Remover manualmente arquivos antigos, se existirem
rm -f config.log config.status config.cache Makefile
rm -rf obj

./configure \
  --prefix=/usr/local \
  --enable-dco \
  --enable-pkcs11 \
  --enable-plugins \
  --enable-plugin-auth-pam \
  --enable-plugin-down-root \
  --enable-management \
  --enable-lz4 \
  --enable-lzo \
  --enable-fragment \
  --enable-systemd \
  --enable-static \
  --enable-shared \
  --enable-x509-alt-username \
  --enable-crypto-ofb-cfb \
  --disable-selinux \
  --disable-iproute2 \
  --with-pkcs11-helper=/usr/local

echo "Compilando e instalando OpenVPN..."
make -j"$(nproc)"
sudo make install

# Mover binarios para /opt/openvpn
mv $OFFLINE_DIR/src/openvpn-${OPENVPN_VERSION}/ /opt/openvpn/

# --------------------------
# Etapa 5: Verificação
# --------------------------
echo "✅ OpenVPN e libpkcs11-helper instalados com sucesso!"
/usr/local/sbin/openvpn --version
