#if [ -f /opt/qt514/bin/qt514-env.sh ] && ! $(echo ${PATH} | grep -q '/opt/qt514/bin'); then
if [ -f /opt/qt514/bin/qt514-env.sh ]; then
    source /opt/qt514/bin/qt514-env.sh
fi
export QT_X11_NO_MITSHM=1
export QT_GRAPHICSSYSTEM="native"
