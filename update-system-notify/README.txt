The program scans the update overlays and displays a message about the updates to the desktop. If necessary, updates the world.

After installation, edit the following files:

1) in /etc/update-system-notify/update-system.cfg enter your DE option for GNOME - gnome-panel parameter for KDE - plasms-desktop

2) the file update-system-notify.cron move the folder /etc/cron.hourly cron.weekly folder or any other