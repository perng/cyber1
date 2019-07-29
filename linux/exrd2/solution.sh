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
