# myOS  
  
## Manjaro  
sudo dd bs=4M if=./manjaro.iso of=/dev/sdc status=progress oflag=sync  

## eOS  
adb reboot bootloader  
fastboot flash recovery recovery.img  
fastboot reboot recovery  
adb sideload rom.zip  
adb sideload magisk.zip  
adb shell touch /data/adb/shamiko/whitelist  
adb shell sed -i 's/blacklist/whitelist/g' /data/clash/clash.config  
adb shell sed -i 's/ipv6: true/ipv6: false/g' /data/clash/template
adb shell 'echo foundation.e.apps | tee -a /data/clash/packages.list'  
adb shell 'echo foundation.e.browser | tee -a /data/clash/packages.list'  
wget $(curl -s https://api.github.com/repos/topjohnwu/Magisk/releases/latest | grep browser_download_url | grep apk | grep Magisk- | cut -d'"' -f4)
wget $(curl -s https://api.github.com/repos/taamarin/ClashforMagisk/releases/latest | grep browser_download_url | grep zip | cut -d'"' -f4)
wget $(curl -s https://api.github.com/repos/LSPosed/LSPosed.github.io/releases/latest | grep browser_download_url | grep zip | cut -d'"' -f4)
wget $(curl -s https://api.github.com/repos/fcitx5-android/fcitx5-android/releases/latest | grep browser_download_url | grep apk | grep v8a | cut -d'"' -f4)
