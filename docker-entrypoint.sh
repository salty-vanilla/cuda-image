#!/bin/bash

/etc/init.d/ssh start

USER_NAME=${USER:-user}
USER_ID=${USER_ID:-9001}
GROUP_ID=${GROUP_ID:-9001}
HOME=/home/$USER_NAME

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
groupadd -g $GROUP_ID stuff
useradd -u $USER_ID -g $GROUP_ID -o -m -d $HOME -s /bin/bash $USER_NAME

exec gosu $USER_NAME "$@"
