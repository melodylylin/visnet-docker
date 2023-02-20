#!/bin/bash
set -e

if [ "$RUN_VNC" = true ] ; then
  /opt/TurboVNC/bin/vncserver -geometry 1920x1080 -name visnet -xstartup /bin/openbox-session :20
fi

exec $@