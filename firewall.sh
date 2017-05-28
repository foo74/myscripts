#!/bin/sh
# https://www.cyberciti.biz/tips/linux-iptables-4-block-all-incoming-traffic-but-allow-ssh.html
# https://www.digitalocean.com/community/tutorials/iptables-essentials-common-firewall-rules-and-commands
# https://unix.stackexchange.com/questions/125833/why-isnt-the-iptables-persistent-service-saving-my-changes
# My system IP/set ip address of server
SERVER_IP="192.168.0.242"
# Flushing all rules
iptables -F
iptables -X
# Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
 
# Allow incoming ssh only
iptables -A INPUT -p tcp -s 0/0 -d $SERVER_IP --sport 513:65535 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -s $SERVER_IP -d 0/0 --sport 22 --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT

# Allow incoming ssh only from IP x.x.x.x
#iptables -A INPUT -p tcp -s x.x.x.x -d $SERVER_IP --sport 513:65535 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT
#iptables -A OUTPUT -p tcp -s $SERVER_IP -d x.x.x.x --sport 22 --dport 513:65535 -m state --state ESTABLISHED -j ACCEPT

# make sure nothing comes or goes out of this box
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
