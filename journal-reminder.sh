#espeak "Make a journal entry"
eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)";
notify-send "Make a journal entry"
