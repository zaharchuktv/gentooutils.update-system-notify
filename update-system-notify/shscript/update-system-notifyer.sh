#!/bin/sh
#update for gentoo
#emerge --sync

de=$(cat /etc/update-system-notify/update-system.cfg)

user=`ps -C gnome-panel -o user=` #find UID user who start plasma-desktop
#pids=`pgrep -u $user gnome-panel` #find PID
#Ищем лузера с рабочими кедами. Если у вас не кеды -- подставляете вашу DE-специфичную вещь.

export XAUTHORITY="/home/$user/.Xauthority"
export DISPLAY=":0"

#Это, чтобы в иксы пробиться
layman -s calculate
eix-update
eix-sync
#eix-remote update
eix-update
emerge -uDN world

#Овчинка, которую мы и выделываем
ee=`emerge -pavuDN world | grep -c - `
if [ "$ee" -eq 0 ];then
echo "$(date) : Система не обновлена" > /var/log/update-system.log
else
/usr/bin/update-system-notify.sh "ВНИМАНИЕ!" "Система обновлена "$(date +%d-%m-%Y)". Установлено "$ee" обновлений." 60000 normal /usr/share/icons/gnome/256x256/status/dialog-warning.png transfer.complete $de $user || /usr/bin/update-system-notify.sh "ВНИМАНИЕ!" "Обновление завершилось неудачей" 60000 critical /usr/share/icons/gnome/256x256/status/dialog-error.png transfer.error $de $user ;
fi



#Мессага!
