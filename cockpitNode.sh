#!/bin/bash

APP_NAME="CockpitNode"
REMOTE_USER="cockpit"
PAUSE_TIME=1.5

pause() {
    sleep "$PAUSE_TIME"
}

log() {
    echo ""
    echo "======================================="
    echo " $APP_NAME - $1"
    echo "======================================="
    pause
}

if [ "$EUID" -ne 0 ]; then
    echo "Kérlek sudo-val futtasd:"
    echo "sudo ./cockpitnode.sh"
    exit 1
fi

clear

echo "======================================="
echo " CockpitNode"
echo " Remote Cockpit host előkészítő"
echo "======================================="
echo ""
echo "Ez a script előkészíti a szervert"
echo "központi Cockpit menedzsmenthez."
echo ""
pause

log "1/8 - Csomaglista frissítése"
apt update

log "2/8 - Cockpit és Files telepítése"
apt install -y -t noble-backports \
    cockpit \
    cockpit-bridge \
    cockpit-system \
    cockpit-ws \
    cockpit-files \
    htop \
    mc

log "3/8 - Cockpit user ellenőrzése"

if id "$REMOTE_USER" &>/dev/null; then
    echo "A(z) $REMOTE_USER user már létezik."
else
    echo "A(z) $REMOTE_USER user létrehozása..."
    adduser --disabled-password --gecos "" "$REMOTE_USER"

    echo ""
    echo "Adj meg jelszót a(z) $REMOTE_USER userhez."
    passwd "$REMOTE_USER"
fi

pause

log "4/8 - Sudo jogosultság beállítása"
usermod -aG sudo "$REMOTE_USER"

log "5/8 - Cockpit socket indítása"
systemctl enable --now cockpit.socket

log "6/8 - Cockpit socket státusz"
systemctl status cockpit.socket --no-pager

log "7/8 - Helyi 9090 port ellenőrzése"
ss -tulpn | grep 9090 || echo "FIGYELEM: A Cockpit helyben sem figyel a 9090-es porton!"

pause

log "8/8 - Összegzés"

IP=$(hostname -I | awk '{print $1}')

echo ""
echo "Telepítés kész."
echo ""
echo "Host IP:"
echo "$IP"
echo ""
echo "Létrehozott / használt user:"
echo "$REMOTE_USER"
echo ""
echo "FONTOS:"
echo "- A 9090-es portot NE nyisd ki internet felé."
echo "- A Master Cockpit SSH-n keresztül csatlakozik."
echo "- Csak az SSH port legyen elérhető."
echo ""
echo "Master Cockpitben:"
echo "1. Connect to another host"
echo "2. Host: $IP vagy DNS név"
echo "3. User: $REMOTE_USER"
echo "4. Pipáld be: Create a new SSH key and authorize it"
echo ""
echo "Ajánlott ellenőrzések:"
echo "sudo ufw status"
echo "systemctl status cockpit.socket"
echo ""
echo "$APP_NAME kész 👍"