#!/usr/bin/env sh
`screen -d -m socat -d -d -d UNIX-CONNECT:/var/run/zend.stat.socket UNIX-CONNECT:/var/run/telegraf.socket`
exec php-fpm
