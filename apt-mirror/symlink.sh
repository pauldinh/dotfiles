#!/bin/bash

for DIR in /var/spool/apt-mirror/mirror/* ; do
    if [ -d $DIR ]; then
        ln -sfv $DIR /var/www
    fi
done
