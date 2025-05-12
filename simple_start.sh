#!/bin/bash

if [ -n "$SETID" ]; then
    usermod -u $SETID fanke
    groupmod -g $SETID fanke
    
    chown -R fanke:fanke /home/fanke
fi

exec runuser -l fanke
