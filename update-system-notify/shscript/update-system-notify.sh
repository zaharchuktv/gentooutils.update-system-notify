#!/bin/sh
# notify.sh
# (c) init_6

de=$7
user=$8

#user=`ps -C $de -o user=` #find UID user who start plasma-desktop
pids=`pgrep -u $user $de` #find PID
#Ищем лузера с рабочими кедами. Если у вас не кеды -- подставляете вашу DE-специфичную вещь.
title=$1
text=$2
timeout=$3
urgency=$4
icon=$5
category=$6

if [ -z "$urgency" ]; then
#low, normal, critical
urgency=normal
fi
if [ -z "$timeout" ]; then
timeout=60000
fi
if [ -z "$icon" ]; then
icon=/usr/share/icons/gnome/256x256/status/dialog-warning.png
#dialog-error.svg dialog-warning.svg
fi
if [ -z "$category" ]; then
#"device" A generic device-related notification that doesn't fit into any other category.
#"device.added" A device, such as a USB device, was added to the system.
#"device.error" A device had some kind of error.
#"device.removed" A device, such as a USB device, was removed from the system.
#"email" A generic e-mail-related notification that doesn't fit into any other category. \
#"email.arrived" A new e-mail notification.
#"email.bounced" A notification stating that an e-mail has bounced.
#"im" A generic instant message-related notification that doesn't fit into any other category.
#"im.error" An instant message error notification.
#"im.received" A received instant message notification.
#"network" A generic network notification that doesn't fit into any other category.
#"network.connected" A network connection notification, such as successful sign-on to a network service. This should not be confused with device.added for new network devices.
#"network.disconnected" A network disconnected notification. This should not be confused with device.removed for disconnected network devices.
#"network.error" A network-related or connection-related error.
#"presence" A generic presence change notification that doesn't fit into any other category, such as going away or idle.
#"presence.offline" An offline presence change notification.
#"presence.online" An online presence change notification.
#"transfer" A generic file transfer or download notification that doesn't fit into any other category.
#"transfer.complete" A file transfer or download complete notification.
#"transfer.error" A file transfer or download error.
category=transfer
fi
if [ -z "$title" ]; then
echo You need to give me a title >&2
exit 1
fi
if [ -z "$text" ]; then
text=$title
fi

for pid in $pids; do
su $user -c "notify-send -u $urgency -t $timeout -i $icon -c $category '$title' '$text' "
done

