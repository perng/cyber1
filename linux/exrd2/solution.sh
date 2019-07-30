#!/bin/bash

# run by "sudo solution.sh"

nano /etc/apt/sources.list #check for malicious sources
nano /etc/resolv.conf #make sure if safe, use 8.8.8.8 for name server
nano /etc/hosts #make sure is not redirecting
nano /etc/rc.local #should be empty except for 'exit 0'
nano /etc/sysctl.conf #change net.ipv4.tcp_syncookies entry from 0 to 1
nano /etc/lightdm/lightdm.conf #allow_guest=false, remove autologin
nano /etc/ssh/sshd_config #Look for PermitRootLogin and set to no

#media file deletion
find / -name '*.mp3' -type f -delete
find / -name '*.mov' -type f -delete
find / -name '*.mp4' -type f -delete
find / -name '*.avi' -type f -delete
find / -name '*.mpg' -type f -delete
find / -name '*.mpeg' -type f -delete
find / -name '*.flac' -type f -delete
find / -name '*.m4a' -type f -delete
find / -name '*.flv' -type f -delete
find / -name '*.ogg' -type f -delete

# remove image files (seems no need for this round)
#sudo find /home -name '*.gif' -type f -delete
#sudo find /home -name '*.png' -type f -delete
#sudo find /home -name '*.jpg' -type f -delete
#sudo find /home -name '*.jpeg' -type f -delete

# firewall
ufw enable
ufw deny 23
ufw deny 2049
ufw deny 515
ufw deny 111

# password age, set the following 2 lines
# PASS_MAX_DAYS   30
# PASS_MIN_DAYS   1
nano /etc/login.defs

#find all admin users
grep -Po '^sudo.+:\K.*$' /etc/group
# output: ballen,iwest,hwells,jgarrick,jwells,wwest,jwest
# wwest and jwest are not supposed to be admin
deluser wwest sudo
deluser wwest adm  # wwest was never in adm
deluser jwest sudo

# find all users
grep -v false /etc/passwd | grep -v nologin | cut -d: -f1

# disable root login
chsh -s /bin/sbin/nologin root

# delete un-authorized users
# TODO: write a function to compare authorized users
 userdel -r brainiac
 userdel -r alchemy 

# change password, but not for ballen
echo -e "iwest: JiTTerS\nhwells: thawne25\njgarrick: ZoLomOn\njwells: quick" |sudo chpasswd 

apt-get remove minetest
grep minetest ~/Desktop/*
# you should see "/home/ballen/Desktop/minetest.desktop" contains minetest
rm /home/ballen/Desktop/minetest.desktop

apt-get remove ophcrack 
grep  ophcrack ~/Desktop/*
rm /home/ballen/Desktop/ophcrack.desktop

# the last bit with no command line solution yet
# open "software updater", "Settings...", "Updates" 
# check "trusty-security" and "trusty-updates"
# select "Automatically check for updates" to Daily


# update software
apt-get update
apt-get upgrade
apt-get -y autoremove
apt-get upgrade firefox

# need a reboot 

#install openssh
apt-get install -y openssh-server

# remove SMB (samba) server
apt-get remove samba
grep samba /etc/group
# sambashare should be removed
groupdel sambashare 


nano /etc/ssh/sshd_config 
# change "#PermitRootLogin yes" to "#PermitRootLogin no"



