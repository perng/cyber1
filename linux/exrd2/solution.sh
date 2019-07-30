sudo nano /etc/apt/sources.list #check for malicious sources
sudo nano /etc/resolv.conf #make sure if safe, use 8.8.8.8 for name server
sudo nano /etc/hosts #make sure is not redirecting
sudo nano /etc/rc.local #should be empty except for 'exit 0'
sudo nano /etc/sysctl.conf #change net.ipv4.tcp_syncookies entry from 0 to 1
sudo nano /etc/lightdm/lightdm.conf #allow_guest=false, remove autologin
sudo nano /etc/ssh/sshd_config #Look for PermitRootLogin and set to no

#media file deletion
sudo find / -name '*.mp3' -type f -delete
sudo find / -name '*.mov' -type f -delete
sudo find / -name '*.mp4' -type f -delete
sudo find / -name '*.avi' -type f -delete
sudo find / -name '*.mpg' -type f -delete
sudo find / -name '*.mpeg' -type f -delete
sudo find / -name '*.flac' -type f -delete
sudo find / -name '*.m4a' -type f -delete
sudo find / -name '*.flv' -type f -delete
sudo find / -name '*.ogg' -type f -delete

# remove image files (seems no need for this round)
#sudo find /home -name '*.gif' -type f -delete
#sudo find /home -name '*.png' -type f -delete
#sudo find /home -name '*.jpg' -type f -delete
#sudo find /home -name '*.jpeg' -type f -delete

# firewall
sudo ufw enable
sudo ufw deny 23
sudo ufw deny 2049
sudo ufw deny 515
sudo ufw deny 111

#find all admin users
grep -Po '^sudo.+:\K.*$' /etc/group
# output: ballen,iwest,hwells,jgarrick,jwells,wwest,jwest
# wwest and jwest are not supposed to be admin
sudo deluser wwest sudo
sudo deluser wwest adm  # wwest was never in adm
sudo deluser jwest sudo

# find all users
grep -v false /etc/passwd | grep -v nologin | cut -d: -f1

# disable root login
sudo chsh -s /bin/sbin/nologin root

# delete un-authorized users
# TODO: write a function to compare authorized users
sudo  userdel -r brainiac
sudo  userdel -r alchemy 

# change password, but not for ballen
echo -e "iwest: JiTTerS\nhwells: thawne25\njgarrick: ZoLomOn\njwells: quick" |sudo chpasswd 

sudo apt-get remove minetest
grep minetest ~/Desktop/*
# you should see "/home/ballen/Desktop/minetest.desktop" contains minetest
rm /home/ballen/Desktop/minetest.desktop

sudo apt-get remove ophcrack 
grep  ophcrack ~/Desktop/*
rm /home/ballen/Desktop/ophcrack.desktop


# update software
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y autoremove
sudo apt-get upgrade firefox


#install openssh
sudo apt-get install -y openssh-server

# remove SMB (samba) server
sudo apt-get remove samba
grep samba /etc/group
# sambashare should be removed
sudo groupdel sambashare 


sudo ufw enable

sudo nano /etc/ssh/sshd_config 
# change "#PermitRootLogin yes" to "#PermitRootLogin no"
