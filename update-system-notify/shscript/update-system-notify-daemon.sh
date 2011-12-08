#!/bin/sh
#update for gentoo
#emerge --sync

#Подставляем вашу DE-специфичную вещь из конфига.
de=$(cat /etc/update-system-notify/update-system.cfg)


#Ищем пользователя с рабочим DE.
user=`ps -C $de -o user=`


#Это, чтобы в иксы пробиться
export XAUTHORITY="/home/$user/.Xauthority"
export DISPLAY=":0"

layman -s calculate
eix-update
eix-sync
eix-update
#eix-remote update

#Овчинка, которую мы и выделываем
ee=`emerge -pavuDN world | grep -c - `
if [ "$ee" -eq 0 ];then
echo "$(date) : Проверка обновлений : Обновлений нет" > /var/log/update-system.log
else
/usr/local/bin/update-system-notify.sh "ВНИМАНИЕ !" "Получены обновления на "$(date +%d-%m-%Y)".\\n
Доступно обновлений для "$ee" программ.\\n
Не забудьте выполнить emerge -uDN world!" 60000 normal /usr/share/icons/gnome/256x256/status/dialog-warning.png transfer.complete $de $user || /usr/local/bin/update-system-notify.sh "ВНИМАНИЕ!" "Проверка обновлений завершилась неудачей" 60000 critical /usr/share/icons/gnome/256x256/status/dialog-error.png transfer.error $de $user;
echo "$(date) : Проверка обновлений : ВНИМАНИЕ ! Получены обновления на $(date). Доступно обновлений для $ee программ." > /var/log/update-system.log
fi
