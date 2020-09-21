#!/bin/bash

unset _VSCS_VER _ARCH VSCS_VER_LATEST VSCS_VER VSCS_DOWNLOAD_URL VSCS_BUNDLE_NAME 

while [ $# -gt 0 ]; do
  case "$1" in
    --vscs-ver*|-v*)
      if [[ "$1" != *=* ]]; then shift; fi # Value is next arg if no '=' (3.5.0, 3.4.1, 3.4.0)
      _VSCS_VER="${1#*=}"
      ;;
    --arch*|-a*)                           
      if [[ "$1" != *=* ]]; then shift; fi # Value is next arg if no `=` (amd, arm)
      _ARCH="${1#*=}"
      ;;
    --help|-h)
      printf "Install Code-Server. \n" 
      printf "\t Examples: \n"
      printf "\t . code_server_install.sh \n"
      printf "\t . code_server_install.sh --vscs-ver=3.4.1 \n"
      printf "\t . code_server_install.sh --vscs-ver=3.4.1 --arch=arm \n"
      printf "\t . code_server_install.sh --arch=arm \n"
      exit 0
      ;;
    *)
      >&2 printf "Error: Invalid argument: '$1' \n"
      exit 1
      ;;
  esac
  shift
done

echo "##########################################################"
echo "#        Installing Code-Server on Ubuntu (${_ARCH:-amd}64)        #"
echo "##########################################################"

export DEBIAN_FRONTEND=noninteractive

#VSCS_PKG="amd64.deb"   # arm64.deb (Ubuntu 64 bits in Raspberry Pi 3b+)
VSCS_PKG="${_ARCH:-amd}64.deb"
VSCS_TAG_LATEST=$(curl -s https://api.github.com/repos/cdr/code-server/releases/latest | jq -r -M '.tag_name')
VSCS_VER_LATEST=$(echo "${VSCS_TAG_LATEST}" | sed "s/v\(.*\)/\1/")
VSCS_VER="${_VSCS_VER:-$VSCS_VER_LATEST}"

# https://github.com/cdr/code-server/releases/download/3.4.1/code-server_3.4.1_amd64.deb
# https://github.com/cdr/code-server/releases/download/v3.4.1/code-server_3.4.1_amd64.deb
VSCS_DOWNLOAD_URL=$(curl -s https://api.github.com/repos/cdr/code-server/releases | jq -r ".[].assets[].browser_download_url" | grep -m 1 "/v$VSCS_VER/code-server_$VSCS_VER.$VSCS_PKG")
VSCS_BUNDLE_NAME="${VSCS_DOWNLOAD_URL##*/}"

echo "----> VSCS_VER $VSCS_VER"
echo "----> $VSCS_DOWNLOAD_URL"

if [ -f "${VSCS_BUNDLE_NAME}" ]; then 
    printf ">> The '$VSCS_BUNDLE_NAME' file has been downloaded previously. Nothing to download. \n"
else
    printf ">> The '$VSCS_BUNDLE_NAME' doesn't exist. Downloading '$VSCS_DOWNLOAD_URL' \n"
    wget -q $VSCS_DOWNLOAD_URL
fi

echo ">> Installing DEB file."
sudo dpkg -i $VSCS_BUNDLE_NAME

echo ">> Starting user systemd service."
systemctl --user enable --now code-server

echo ">> Deleting DEB file."
rm -rf code-server*

echo ">> Waiting Code-Server starts"
sleep 5s
printf "\n"

printf ">> Installing 'MKCert'. \n"
#MKCERT_PKG="linux-amd"   # linux-arm 
MKCERT_PKG="linux-${_ARCH:-amd}"
MKCERT_BUNDLE_URL=$(curl -s https://api.github.com/repos/FiloSottile/mkcert/releases/latest | jq -r ".assets[].browser_download_url | select(contains(\"${MKCERT_PKG}\"))")
MKCERT_BUNDLE_NAME="${MKCERT_BUNDLE_URL##*/}"

if [ -f "${MKCERT_BUNDLE_NAME}" ]; then
    printf ">> The $MKCERT_BUNDLE_NAME file exists. Nothing to download. \n"
else
    printf ">> The file doesn't exist. Downloading the $MKCERT_BUNDLE_NAME file. \n"
    wget -q $MKCERT_BUNDLE_URL
fi
cp $MKCERT_BUNDLE_NAME mkcert
chmod +x mkcert

printf ">> Generating TLS certs with 'mkcert' for 'Code-Server'.\n"
sudo apt -y install libnss3-tools
./mkcert -install
./mkcert vscs.ubuntu localhost 127.0.0.1 ::1
mv vscs.* ~/
printf "\n"

echo ">> Tweaking '~/.config/code-server/config.yaml' to enable TLS. \n"
sed -i.bak 's/^bind-addr: .*$/bind-addr: 0.0.0.0:8443/' ~/.config/code-server/config.yaml
sed -i.bak 's/cert: false/cert: vscs.ubuntu+3.pem/' ~/.config/code-server/config.yaml
echo -e 'cert-key: vscs.ubuntu+3-key.pem' >> ~/.config/code-server/config.yaml
echo -e 'disable-telemetry: true\n' >> ~/.config/code-server/config.yaml
printf "\n"

printf ">> The '~/.config/code-server/config.yaml' final is: \n"
echo "-----------------------------------------------"
cat ~/.config/code-server/config.yaml
echo "-----------------------------------------------"

printf ">> Trust on the Root CA crt generated by 'mkcert'.\n"
printf ">> You have to install it in your browser as trusted CA and add 'vscs.ubuntu 192.168.1.44' in you '/etc/hosts' file.\n"
printf ">> You can found the Root CA here: /home/<USER>/.local/share/mkcert/rootCA.pem \n\n"

printf ">> Installing Extension: Shan.code-settings-sync. \n"
code-server --install-extension Shan.code-settings-sync
printf "\nGet a trusted Gist ID to restore extensions and configurations through Settings-Sync extension:\n"
printf "\t Gist URL: https://gist.github.com/chilcano/b5f88127bd2d89289dc2cd36032ce856 \n"
printf "\t Gist ID: b5f88127bd2d89289dc2cd36032ce856 \n\n"

printf ">> Installing Extension from VSIX: AmazonWebServices.aws-toolkit-vscode. \n"
AWS_TOOLKIT_VSIX_URL=$(curl -s https://api.github.com/repos/aws/aws-toolkit-vscode/releases/latest | jq -r -M '.assets[].browser_download_url')
AWS_TOOLKIT_VSIX_NAME="${AWS_TOOLKIT_VSIX_URL##*/}"
wget -q $AWS_TOOLKIT_VSIX_URL
code-server --install-extension $AWS_TOOLKIT_VSIX_NAME
rm -rf $AWS_TOOLKIT_VSIX_NAME
printf "\n"

printf ">> Restarting Code-Server to apply changes. \n"
systemctl --user restart code-server




printf ">> Code-Server $VSCS_VER was installed successfully. \n"
