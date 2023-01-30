# myOS

## Manjaro

sudo dd bs=4M if=./manjaro.iso of=/dev/sdc status=progress oflag=sync 

## eOS

adb shell touch /data/adb/shamiko/whitelist

adb shell sed -i 's/blacklist/whitelist/g' /data/clash/clash.config

adb shell 'echo foundation.e.apps | tee -a /data/clash/packages.list'

adb shell 'echo foundation.e.browser | tee -a /data/clash/packages.list'
