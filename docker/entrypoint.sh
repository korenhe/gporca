#!/bin/bash
set -e

USER_ID=${LOCAL_USER_ID:-9001}
GROUP_ID=${LOCAL_GROUP_ID:-$USER_ID}

# Create user called "udocker" to match host uid
if [ $(getent group $GROUP_ID) ]; then
    useradd --shell /bin/bash -u $USER_ID -o -c "" -m udocker
    GROUP_ID=$USER_ID
else
    groupadd -g $GROUP_ID gdocker || GROUP_ID=$USER_ID
    useradd --shell /bin/bash -u $USER_ID -g gdocker -o -c "" -m udocker
fi

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"

# Gives sudo priviledge for udocker
usermod -aG sudo udocker

echo "udocker:udocker" | chpasswd

exec gosu udocker "$@"
