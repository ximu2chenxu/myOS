# myOS  
  
## Manjaro  
sudo dd bs=4M if=./manjaro.iso of=/dev/sdc status=progress oflag=sync  

## eOS  
adb reboot bootloader  
fastboot flash recovery recovery.img  
fastboot reboot recovery  
adb sideload rom.zip  
adb sideload magisk.zip  
wget $(curl -s https://api.github.com/repos/topjohnwu/Magisk/releases/latest | grep browser_download_url | grep apk | grep Magisk- | cut -d'"' -f4); cp $(ls | grep Magisk | grep apk) magisk.zip  
wget $(curl -s https://api.github.com/repos/taamarin/box_for_magisk/releases/latest | grep browser_download_url | grep zip | cut -d'"' -f4)  
wget $(curl -s https://api.github.com/repos/LSPosed/LSPosed.github.io/releases/latest | grep browser_download_url | grep zip | cut -d'"' -f4)  
wget $(curl -s https://api.github.com/repos/fcitx5-android/fcitx5-android/releases/latest | grep browser_download_url | grep apk | grep v8a | cut -d'"' -f4)  
wget $(curl -s https://api.github.com/repos/wuhgit/CustomPinyinDictionary/releases/latest | grep browser_download_url | grep tar | cut -d'"' -f4); tar -zxvf $(ls | grep tar); rm -rf *.tar.gz  
wget $(curl -s https://api.github.com/repos/InfinityLoop1308/AnimePipe/releases/latest | grep browser_download_url | grep apk | cut -d'"' -f4)  
adb install $(ls | grep apk)  
adb push $(ls | grep zip) /sdcard/Download/  
adb push $(ls | grep gict) /sdcard/Download/  
adb shell touch /data/adb/shamiko/whitelist  
adb shell sed -i 's/blacklist/whitelist/g' /data/clash/clash.config  
adb shell sed -i 's/ipv6: true/ipv6: false/g' /data/clash/template  
adb shell 'echo foundation.e.apps | tee -a /data/clash/packages.list'  
adb shell 'echo foundation.e.browser | tee -a /data/clash/packages.list'  
adb shell 'echo InfinityLoop1309.NewPipeEnhanced | tee -a /data/clash/packages.list'  
