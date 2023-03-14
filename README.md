# myOS  
  
## Manjaro  
sudo dd bs=4M if=./manjaro.iso of=/dev/sdc status=progress oflag=sync  

## eOS  
wget $(curl -s https://api.github.com/repos/topjohnwu/Magisk/releases/latest | grep browser_download_url | grep apk | grep Magisk- | cut -d'"' -f4); cp $(ls | grep Magisk | grep apk) magisk.zip  
wget $(curl -s https://api.github.com/repos/taamarin/box_for_magisk/releases/latest | grep browser_download_url | grep zip | cut -d'"' -f4)  
wget $(curl -s https://api.github.com/repos/LSPosed/LSPosed.github.io/releases/latest | grep browser_download_url | grep zip | cut -d'"' -f4)  
adb reboot bootloader; read -p "Press enter to continue (waiting: adb reboot bootloader)"  
fastboot flash recovery recovery.img; read -p "Press enter to continue (waiting: fastboot flash recovery recovery.img)"  
fastboot reboot recovery; read -p "Press enter to continue (waiting: fastboot reboot recovery)"  
adb sideload rom.zip; read -p "Press enter to continue (waiting: adb sideload rom.zip)"  
adb sideload magisk.zip; read -p "Press enter to continue (waiting: adb sideload magisk.zip)"  
adb root  
adb install $(ls | grep apk)  
adb push $(ls | grep zip) /sdcard/Download/  
adb shell mkdir /data/adb/shamiko  
adb shell touch /data/adb/shamiko/whitelist  
read -p "Press enter to continue (waiting: modules)"  
wget $(curl -s https://api.github.com/repos/fcitx5-android/fcitx5-android/releases/latest | grep browser_download_url | grep apk | grep v8a | cut -d'"' -f4)  
wget $(curl -s https://api.github.com/repos/pppscn/SmsForwarder/releases/latest | grep browser_download_url | grep apk | grep v8a | cut -d'"' -f4)  
wget $(curl -s https://api.github.com/repos/wuhgit/CustomPinyinDictionary/releases/latest | grep browser_download_url | grep tar | cut -d'"' -f4); tar -zxvf $(ls | grep tar); rm -rf *.tar.gz  
wget $(curl -s https://api.github.com/repos/InfinityLoop1308/AnimePipe/releases/latest | grep browser_download_url | grep apk | cut -d'"' -f4)  
adb install $(ls | grep -E 'apk' | grep -v 'Magisk')  
adb push $(ls | grep -E 'dict') /sdcard/Download/  
