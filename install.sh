#!/usr/bin/env bash

DOWNLOAD_URL=https://github.com/vyloy/relay-release/raw/master
DOWNLOAD_BINARY_URL=https://github.com/vyloy/relay-release/releases/download/v0.1.0
CONFIG_PATH=/etc/relay
CONFIG_FILE="${CONFIG_PATH}/relay.conf"
SERVICE_PATH=/etc/systemd/system
SERVICE_FILE="${SERVICE_PATH}/relay.service"
BIN_PATH=/usr/local/sbin

if [[ ! -s ${CONFIG_FILE} ]]; then
 echo "installing config file to ${CONFIG_PATH}"
 sudo mkdir -p ${CONFIG_PATH}
 sudo chown root:wheel ${CONFIG_PATH}
 sudo chmod 775 ${CONFIG_PATH}
 sudo curl -o ${CONFIG_FILE} -fsSL "${DOWNLOAD_URL}/relay.conf"
else
 echo "skip installing config file."
fi

echo "installing binary file to ${BIN_PATH}"
sudo chown root:wheel ${BIN_PATH}
sudo chmod 775 ${BIN_PATH}
sudo curl -o "${BIN_PATH}/wstunnel" -fsSL "${DOWNLOAD_BINARY_URL}/relay"

echo "installing service file to ${SERVICE_PATH}"
sudo chown root:wheel ${SERVICE_PATH}
sudo chmod 775 ${SERVICE_PATH}
sudo curl -o "${SERVICE_FILE}" -fsSL "${DOWNLOAD_URL}/relay.service"

echo "cat ${CONFIG_FILE}"
echo "=================================================="
echo ""
cat ${CONFIG_FILE}
echo ""
echo "=================================================="
echo ""
echo "Please edit config file ${CONFIG_FILE}."
echo "And then sudo systemctl daemon-reload, sudo systemctl start wstunsrv."
