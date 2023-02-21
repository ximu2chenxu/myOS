#!/bin/bash

sudo tee /etc/sudoers.d/$USER <<< "$USER ALL=(ALL) NOPASSWD: ALL"
sudo chmod 440 /etc/sudoers.d/$USER

balooctl suspend
balooctl disable
sed -i '3a [Keyboard]\nNumLock=0\n' $HOME/.config/kcminputrc
echo -e "[Daemon]\nAutolock=false\nLockOnResume=false" | tee $HOME/.config/kscreenlockerrc
sudo sed -i 's/RefreshPeriod = ./RefreshPeriod = 0/g' /etc/pamac.conf
mkdir $HOME/.config/plasma-workspace $HOME/.config/plasma-workspace/env
echo -e "#\!/bin/bash\n\
xbindkeys\n\
if [ \$(cat /usr/share/applications/chromium.desktop | grep -c Vaapi) -le 0 ]; then sudo sed -i 's/\/chromium/\/chromium --disable-features=UseChromeOSDirectVideoDecoder --enable-features=VaapiVideoEncoder,VaapiVideoDecoder/g' /usr/share/applications/chromium.desktop; fi\n\
if [ \$(cat /usr/share/applications/texstudio.desktop | grep -c fcitx) -le 0 ]; then sudo sed -i 's/Exec=texstudio/Exec=export XMODIFIERS=\"@im=fcitx\";export QT_IM_MODULE=\"fcitx\";texstudio/g' /usr/share/applications/texstudio.desktop; fi\n\
" | tee $HOME/.config/plasma-workspace/env/myauto.sh
chmod +x $HOME/.config/plasma-workspace/env/myauto.sh

sudo pacman-mirrors --geoip -m rank
geoLocation=$(pacman-mirrors --status | grep -c China)
sudo pamac remove --no-confirm matray
sudo pamac checkupdates -a
sudo pamac upgrade -a --force-refresh --no-confirm

sudo pamac install --no-confirm archlinux-keyring
sudo pamac install --no-confirm gvfs-smb samba kdenetwork-filesharing manjaro-settings-samba
sudo pamac install --no-confirm base-devel ninja openmpi tbb cmake make python python-numpy
sudo pamac install --no-confirm ttf-hannom noto-fonts noto-fonts-extra noto-fonts-emoji noto-fonts-cjk adobe-source-code-pro-fonts adobe-source-han-sans-cn-fonts adobe-source-han-sans-hk-fonts adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts adobe-source-han-sans-otc-fonts adobe-source-han-sans-tw-fonts adobe-source-han-serif-cn-fonts adobe-source-han-serif-hk-fonts adobe-source-han-serif-jp-fonts adobe-source-han-serif-kr-fonts adobe-source-han-serif-otc-fonts adobe-source-han-serif-tw-fonts adobe-source-serif-fonts wqy-zenhei wqy-microhei
sudo pamac install --no-confirm texstudio texlive-core texlive-bibtexextra texlive-fontsextra texlive-formatsextra texlive-latexextra texlive-pictures texlive-pstricks texlive-publishers texlive-science texlive-humanities texlive-langchinese texlive-langjapanese
sudo pamac install --no-confirm libxau libxi libxss libxtst libxcursor libxcomposite libxdamage libxfixes libxrandr libxrender mesa-libgl alsa-lib libglvnd
sudo pamac install --no-confirm fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-chinese-addons
sudo pamac install --no-confirm wine winetricks wine-mono wine_gecko
sudo pamac install --no-confirm libxcrypt-compat
sudo pamac install --no-confirm intel-gpu-tools
sudo pamac install --no-confirm wireguard-tools
sudo pamac install --no-confirm android-tools
sudo pamac install --no-confirm scrcpy
sudo pamac install --no-confirm net-tools
sudo pamac install --no-confirm glfw-x11
sudo pamac install --no-confirm freerdp
sudo pamac install --no-confirm gconf
sudo pamac install --no-confirm nmap
sudo pamac install --no-confirm vim
sudo pamac install --no-confirm barrier
sudo pamac install --no-confirm vlc
sudo pamac install --no-confirm octave
sudo pamac install --no-confirm remmina
sudo pamac install --no-confirm libreoffice
sudo pamac install --no-confirm inkscape
sudo pamac install --no-confirm flameshot
sudo pamac install --no-confirm obs-studio
sudo pamac install --no-confirm audacity
sudo pamac install --no-confirm kdenlive
sudo pamac install --no-confirm rnote
sudo pamac install --no-confirm filezilla
sudo pamac install --no-confirm paraview
sudo pamac install --no-confirm pandoc
sudo pamac install --no-confirm kodi
sudo pamac install --no-confirm gimp
sudo pamac install --no-confirm code
sudo pamac install --no-confirm git
sudo pamac install --no-confirm wget
sudo pamac install --no-confirm zip
sudo pamac install --no-confirm unzip
sudo pamac install --no-confirm qbittorrent
sudo pamac install --no-confirm wireshark-qt
sudo pamac install --no-confirm doxygen
sudo pamac install --no-confirm graphviz
sudo pamac install --no-confirm blender
sudo pamac install --no-confirm freecad
sudo pamac install --no-confirm torbrowser-launcher
sudo pamac install --no-confirm nginx; sudo systemctl enable --now nginx
sudo pamac install --no-confirm syncthing; sudo systemctl enable --now syncthing@$USER
sudo pamac install --no-confirm chromium; xdg-settings set default-web-browser chromium.desktop
sudo pamac install --no-confirm xdotool xbindkeys xorg-xev; xbindkeys --defaults > $HOME/.xbindkeysrc

sudo pamac install --no-confirm neovim
if [ "$geoLocation" -gt 0 ]; then
    git clone https://gitclone.com/github.com/NvChad/NvChad ~/.config/nvim --depth 1
else
    git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
fi
nvim&

timeout 9 firefox
sudo sed -i 's|Exec=|Exec=export MOZ_DISABLE_RDD_SANDBOX=1 \&\& |g' /usr/share/applications/firefox.desktop
ffUserRelease=$(find /home/$USER/.mozilla/firefox/ -type d -name '*default-release')
echo -e "\
user_pref(\"network.trr.mode\", 3);\n\
user_pref(\"network.trr.uri\", \"https://mozilla.cloudflare-dns.com/dns-query\");\n\
user_pref(\"network.dns.echconfig.enabled\", true);\n\
user_pref(\"network.dns.use_https_rr_as_altsvc\", true);\n\
user_pref(\"dom.security.https_only_mode\", true);\n\
user_pref(\"network.proxy.type\", 5);\n\
user_pref(\"network.proxy.socks\", \"127.0.0.1\");\n\
user_pref(\"network.proxy.socks_port\", 7890);\n\
user_pref(\"network.proxy.socks_remote_dns\", true);\n\
user_pref(\"media.ffmpeg.vaapi.enabled\", true);\n\
user_pref(\"media.ffvpx.enabled\", false);\n\
user_pref(\"media.rdd-vpx.enabled\", false);\n\
user_pref(\"media.av1.enabled\", false);\n\
user_pref(\"browser.startup.homepage\", \"about:blank\");\n\
" | tee $ffUserRelease/user.js

sudo pamac install --no-confirm virt-manager qemu vde2 dnsmasq bridge-utils openbsd-netcat edk2-ovmf swtpm
yes | sudo pamac install --no-confirm iptables-nft
sudo systemctl daemon-reload
sudo systemctl enable libvirtd
sudo usermod -aG kvm $USERecho
sudo usermod -aG libvirt $USER
sudo systemctl start libvirtd
source $HOME/.bashrc
source $HOME/.zshrc

sudo pamac install --no-confirm docker
if [ "$geoLocation" -gt 0 ]; then
    echo -e '{\n "registry-mirrors": ["http://hub-mirror.c.163.com","https://mirror.ccs.tencentyun.com"] \n}' | sudo tee /etc/docker/daemon.json && sudo systemctl restart docker
fi
sudo systemctl daemon-reload
sudo systemctl enable docker
sudo usermod -aG docker $USER
sudo systemctl start docker
sudo pamac install --no-confirm docker-compose
source $HOME/.bashrc
source $HOME/.zshrc

sudo pamac install --no-confirm clash
clash -t
echo -e "\
mixed-port: 7890\n\
allow-lan: false\n\
bind-address: '*'\n\
mode: rule\n\
log-level: info\n\
ipv6: false\n\
external-controller: 127.0.0.1:9090\n\
external-ui: clash-dashboard\n\
secret: '0000'\n\
dns:\n\
  enable: true\n\
  listen: 0.0.0.0:53\n\
  ipv6: false\n\
  default-nameserver:\n\
   - 9.9.9.9\n\
   - 223.5.5.5\n\
   - 119.29.29.98\n\
  nameserver:\n\
   - https://cn-east.iqiqzz.com/dns-query\n\
  enhanced-mode: fake-ip\n\
  fake-ip-range: 198.18.0.1/16\n\
  fallback:\n\
   - https://cloudflare-dns.com/dns-query\n\
  fallback-filter:\n\
   geoip: true\n\
   geoip-code: CN\n\
proxies:\n\
    {name: \"ss\", type: ss, port: 8388, server: 0.0.0.0, cipher: chacha20-ietf-poly1305, password: password}\n\
    {name: \"vm\", type: vmess, port: 443, network: ws, alterId: 0, cipher: auto, tls: true, server: cdn.cdn, uuid: uuid, ws-opts: {path: /path}}\n\
    {name: \"ip\", type: vmess, port: 443, network: ws, alterId: 0, cipher: auto, tls: true, server: 0.0.0.0, uuid: uuid, ws-opts: {path: /path, headers: {Host: cdn.cdn}}}\n\
proxy-groups:\n\
  - name: \"relay\"\n\
    type: relay\n\
    proxies:\n\
      - vm\n\
      - ss\n\
proxy-providers:\n\
  providerI:\n\
    type: http\n\
    url: \"url\"\n\
    interval: 600\n\
    path: ./providerI.yaml
rules:\n\
  - GEOIP,CN,DIRECT,no-resolve\n\
  - DOMAIN-SUFFIX,cn,DIRECT\n\
  - DOMAIN-KEYWORD,linkedin,vm\n\
  - MATCH,vm\n\
" | tee $HOME/.config/clash/config.yaml
if [ "$geoLocation" -gt 0 ]; then
    git clone -b gh-pages --depth 1 https://gitclone.com/github.com/Dreamacro/clash-dashboard $HOME/.config/clash/clash-dashboard
else
    git clone -b gh-pages --depth 1 https://github.com/Dreamacro/clash-dashboard $HOME/.config/clash/clash-dashboard
fi
echo "alias exportproxy=\"export {http,https,HTTP,HTTPS,ftp,rsync,all}_proxy=http://127.0.0.1:7890/\"" | tee -a $HOME/.bashrc $HOME/.zshrc
source $HOME/.bashrc
source $HOME/.zshrc

sudo pamac clean -k 0 -b -v --no-confirm
yes | sudo pacman -Scc

wget -P $HOME/Downloads https://gmsh.info/bin/Linux/gmsh-stable-Linux64.tgz
tar -zxvf $HOME/Downloads/gmsh-stable-Linux64.tgz -C $HOME/Downloads
gmshfolder=$(find $HOME/Downloads/ -type d -name 'gmsh*Linux64')
sudo mv -f $gmshfolder/bin/gmsh /usr/bin/
rm -rf $HOME/Downloads/gmsh*

wget -O - https://www.anaconda.com/distribution/ 2>/dev/null | sed -ne 's@.*\(https:\/\/repo\.anaconda\.com\/archive\/Anaconda3-.*-Linux-x86_64\.sh\)\">64-Bit (x86) Installer.*@\1@p' | xargs wget
bash ./Anaconda3-*-Linux-x86_64.sh -b -p $HOME/anaconda3
rm -rf ./Anaconda3-*-Linux-x86_64.sh
echo -e "\
[Desktop Entry]\n\
Type=Application\n\
Name=Spyder\n\
Exec=$HOME/anaconda3/bin/spyder\n\
Terminal=false\n\
StartupNotify=true\n\
Categories=Science\n\
" | sudo tee /usr/share/applications/spyder.desktop
source $HOME/.bashrc
source $HOME/.zshrc

echo "alias dredroid=\"docker run -itd --privileged --pull always -v $HOME/data:/data -p 5555:5555 redroid/redroid:13.0.0-latest --memory-swappiness=0 androidboot.hardware=mt6891 ro.secure=0 ro.boot.hwc=GLOBAL ro.ril.oem.imei=861503068361145 ro.ril.oem.imei1=861503068361145 ro.ril.oem.imei2=861503068361148 ro.ril.miui.imei0=861503068361148 ro.product.manufacturer=Xiaomi ro.build.product=chopin redroid.width=720 redroid.height=1280 \"" | tee -a $HOME/.bashrc $HOME/.zshrc
echo "alias redroid=\"adb connect localhost:5555; scrcpy -s localhost:5555\"" | tee -a $HOME/.bashrc $HOME/.zshrc

echo "alias dof=\"docker run -v $HOME/Documents/WorkSpace:/home/sudofoam -it opencfd/openfoam-dev su - sudofoam\"" | tee -a $HOME/.bashrc $HOME/.zshrc
echo "alias dof2112=\"docker run -v $HOME/Documents/WorkSpace:/home/sudofoam -it opencfd/openfoam-dev:2112 su - sudofoam\"" | tee -a $HOME/.bashrc $HOME/.zshrc
echo "alias dof10=\"docker run -v $HOME/Documents/WorkSpace:/home/openfoam -it openfoam/openfoam10-paraview56\"" | tee -a $HOME/.bashrc $HOME/.zshrc
mkdir $HOME/Documents/WorkSpace
sudo chmod -R 777 $HOME/Documents/WorkSpace
wget -P $HOME/Downloads https://dl.openfoam.com/source/v2212/OpenFOAM-2112.tgz
wget -P $HOME/Downloads https://dl.openfoam.com/source/v2212/ThirdParty-v2112.tgz
tar -zxvf $HOME/Downloads/OpenFOAM*.tgz
tar -zxvf $HOME/Downloads/ThirdParty*.tgz
rm -rf $HOME/Downloads/*.tgz
mkdir $HOME/openfoam
mv -f $HOME/Downloads/OpenFOAM* $HOME/openfoam/
mv -f $HOME/Downloads/ThirdParty* $HOME/openfoam/
source ~/openfoam/OpenFOAM-v2112/etc/bashrc
cd $HOME/openfoam/OpenFOAM-v2112
./Allwmake -j -s -q -l
